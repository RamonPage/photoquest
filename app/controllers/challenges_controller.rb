class ChallengesController < ApplicationController
  before_filter :fetch_quest

  
  def move
    @move = Move.create :quest_id => params[:id], :correct => correct 
    render :action => :index
  end
  
  private
  
    def correct
      quest = Quest.get params[:id]
      quest.correct_answer?(params[:answer])
    end
    
    def fetch_quest
      @quest = Quest.first
    end
  
end
