class ChallengesController < ApplicationController
  before_filter :fetch_quest
  
  def move
    @move = Move.create :quest_id => params[:id], :answer => params[:answer]
    render :action => :index
  end
  
  private
  
    def fetch_quest
      @quest = Quest.draw
    end
  
end
