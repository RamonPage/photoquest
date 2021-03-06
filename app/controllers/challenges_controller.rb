class ChallengesController < ApplicationController
  before_filter :fetch_current_player
  before_filter :fetch_quest, :except => ['create', 'move']

  def index
    @score = @player.score
    @new_quest = Quest.new
  end

  def create
    @new_quest = @player.create_quest(params[:quest]) 
    if @new_quest.valid?
      @score = @player.score
    else
      flash[:error] = "Ops, there was no possible to record your quest."
      fetch_quest
      render :action => :index
    end
  end
  
  def move
    @move = @player.create_answer_move :quest_id => params[:id], :answer => params[:answer]
    if @move.correct_answer?
      flash[:notice] = "You are correct!" 
    else  
      flash[:alert] = "You lose!"
    end

    redirect_to challenges_path
  end

  def show
    @quest = Quest.get(params[:id]) || Quest.find_by_short_id(params[:short_id])
    @score = @player.score
    @new_quest = Quest.new
    render :action => :index
  end

  private
  def fetch_quest
    @quest = Quest.find_quest_for(@player)
  end
end
