class ChallengesController < ApplicationController
  
  def index
    @quest = Quest.first
  end
  
end
