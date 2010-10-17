class ChallengesController < ApplicationController
  before_filter :fetch_quest, :except => ['create']
  before_filter :fetch_current_player, :except => ['create']
  
  def create
    Quest.create params[:quest]
    @quest = Quest.first
    fetch_current_player
    @score = Score.new(@player).calculate
  end
  
  def move
    @move = Move.create :quest_id => params[:id], :answer => params[:answer]
    @player.moves << @move
    @player.save
    @score = Score.new(@player).calculate
    render :action => :index
  end
  
  private
  
  def correct
    quest = Quest.get params[:id]
    quest.correct_answer?(params[:answer])
  end
  
  def fetch_current_player
    if session[:player_id] 
      @player = Player.get session[:player_id] 
      create_new_session if @player.nil?
    else
      create_new_session
    end
  end 
  
  def create_new_session
    @player = Player.create
    session[:player_id] = @player.id
  end
  
  def fetch_quest
    @quest = Quest.draw
  end
end
