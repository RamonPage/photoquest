class RankingsController < ApplicationController
  before_filter :fetch_current_player 

  def index
    @ranking = Player.ranking
    @new_player = Player.new if @player.blank? or !@player.already_signed_up?
  end

  def create
    
    nick_name_sem_arroba = params[:player][:nick_name].gsub(/@/, "") unless params[:player][:nick_name].blank?

    if @player.sign_up! nick_name_sem_arroba 
      flash[:notice] = "Congratulations. Now you've entered in photoque.st hall of fame!"
      session[:player_id] = @player.id 
    end 
    redirect_to rankings_path 
  end

end
