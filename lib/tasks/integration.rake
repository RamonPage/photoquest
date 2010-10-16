if Rails.env.to_s != "production"
  require 'find'

  INTEGRATION_TASKS = %w( 
      git:status:check
      log:clear
      tmp:clear
      backup:local
      git:pull
      spec:lib
      spec:models
      spec:helpers
      spec:controllers
      spec:acceptances
      git:commit            
      git:push
  )

  def scm
    'git'
  end

  def project_name
    File.expand_path(Rails.root.to_s).split("/").last
  end

  def p80(message)
    puts "-"*80
    puts message if message
    yield if block_given?
  end

  def environment_parameters(key)
    return ENV[key].split(/\s*\,\s*/) if ENV[key]
    []
  end

  def skip_task?(task)
    environment_parameters('SKIP_TASKS').include?(task)  
  end

  def remove_old_backups(backup_dir)
    backups_to_keep = ENV['NUMBER_OF_BACKUPS_TO_KEEP'] || 30
    backups = []
    Find.find(backup_dir) { |file_name| backups << file_name if !File.directory?(file_name) && file_name =~ /.*\.zip$/ }
    backups.sort!
    (backups - backups.last(backups_to_keep - 1)).each do |file_name|
      puts "Removing #{file_name}..."
      FileUtils.rm(file_name)
    end
  end

  namespace :backup do
    desc 'Creates a backup of the project in the local disk.'
    task :local do
      backup_dir = '../backups/backup-' + project_name
      sh "mkdir -p #{backup_dir}" if !FileTest.exists?(backup_dir)
      remove_old_backups(backup_dir)
      sh "zip -rq '#{backup_dir}/#{project_name}-#{Time.now.strftime('%Y%m%d-%H%M%S')}.zip' '../#{project_name}'"
    end
  end

  namespace :git do
  
    def has_files_to_commit?
      return false if (`git status`).include?('nothing to commit')
      true  
    end
  
    namespace :status do
      desc 'Check if project can be committed to the repository.'
      task :check do
        result = `git status`
        if result.include?('Untracked files:') || result.include?('unmerged:')
          puts "Files out of sync:"
          puts result
          exit
        end
      end
    end

    desc 'Update files from repository.'
    task :pull do
      sh "git pull"
    end
  
    desc 'Commit project.'
    task :commit do
      message = ''
      message = "-m 'Committed by integration plugin.'" if ENV['SKIP_COMMIT_MESSAGES']
      sh "git commit -a -v #{message}" if has_files_to_commit? 
    end
  
    desc 'Push project.'
    task :push do
      sh "git push"
    end
  end

  desc 'Integrate new code to repository'
  task :integrate do
    INTEGRATION_TASKS.each do |subtask|
      if Rake::Task.task_defined?("#{subtask}:before") && !skip_task?(subtask)
        p80("Executing #{subtask}:before...") do 
          RAILS_ENV = ENV['RAILS_ENV'] || 'development'
          Rake::Task["#{subtask}:before"].invoke 
        end
      end

      if skip_task?(subtask)
        p80 "Skipping #{subtask}..."
      else
        p80("Executing #{subtask}...") do 
          RAILS_ENV = ENV['RAILS_ENV'] || 'development'
          Rake::Task[subtask].invoke 
        end
      end

      if Rake::Task.task_defined?("#{subtask}:after") && !skip_task?(subtask)
        p80("Executing #{subtask}:after...") do 
          RAILS_ENV = ENV['RAILS_ENV'] || 'development'
          Rake::Task["#{subtask}:after"].invoke 
        end
      end
    end
  end
end