class RankingsController < ApplicationController
  before_filter :fetch_current_player 

  def index
    @ranking = Player.ranking
    @new_player = Player.new if @player.blank? or !@player.already_signed_up?
  end

  def create
    if @player.sign_up! params[:player][:nick_name]
      flash[:notice] = "Congratulations. Now you've entered in photoque.st hall of fame!"
      session[:player_id] = @player.id 
    end 
    redirect_to rankings_path 
  end

end
