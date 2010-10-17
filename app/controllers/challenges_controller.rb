class ChallengesController < ApplicationController
  before_filter :fetch_current_player, :except => ['create']
  before_filter :fetch_quest, :except => ['create']

  def index
    @score = Score.new(@player).calculate if @player.moves.present?
  end
  
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
    if @move.correct?
      flash[:notice] = "You are correct!" 
    else  
      flash[:alert] = "You lose!"
    end
      
    redirect_to challenges_path
  end
  
  def show
    @quest = Quest.get params[:id]
    fetch_current_player
    @score = Score.new(@player).calculate
    render :action => :index
  end

  private
  
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
    @quest = Quest.find_quest_for(@player)
  end
end
