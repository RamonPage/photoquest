class ChallengesController < ApplicationController
  
  def index
    @quest = Quest.first
  end
  
  def move
    @move = Move.create :quest_id => params[:id], :correct => correct 
  end
  
  private
  
    def correct
      quest = Quest.get params[:id]
      quest.correct_answer?(params[:answer])
    end
  
end
