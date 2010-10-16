class ChallengesController < ApplicationController
  before_filter :fetch_quest
  before_filter :fetch_current_player
  
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
    @quest = Quest.draw
  end
  def fetch_current_player
    @player = session[:player] 
  end 
  
end
