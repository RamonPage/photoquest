class ChallengesController < ApplicationController
  before_filter :fetch_current_player, :except => ['create']
  before_filter :fetch_quest, :except => ['create', 'move']

  def index
    @score = Score.new(@player).calculate if @player.moves.present?
  end

  # TODO: refactor move the sharing move create inside the Quest.create(player, params[:quest]) 
  def create
    Quest.create params[:quest]
    @quest = Quest.first
    fetch_current_player
    @player.moves << SharingMove.create
    @player.save
    @score = Score.new(@player).calculate
  end
  
  def move
    @move = @player.create_new_move :quest_id => params[:id], :answer => params[:answer]
    if @move.correct_answer?
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
  def fetch_quest
    @quest = Quest.find_quest_for(@player)
  end
end
