class AbusesController < ApplicationController
  before_filter :fetch_current_player

  def create
    @quest = Quest.get(params[:id])
    @quest.mark_as_abuse!(@player) 
    flash[:notice] = "This photo was reported as being abusive"
    redirect_to challenges_path 
  end

end
