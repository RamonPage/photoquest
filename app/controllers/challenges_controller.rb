class ChallengesController < ApplicationController
  before_filter :fetch_quest
  before_filter :fetch_current_player
  
  def move
    @move = Move.create :quest_id => params[:id], :answer => params[:answer]
    @score = Score.calculate
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
    else
      @player = Player.create
      session[:player_id] = @player.id
    end
  end 
  
  def fetch_quest
    @quest = Quest.draw
  end
end
