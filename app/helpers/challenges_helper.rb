module ChallengesHelper
  
  def li_for(params)
    return li params, :class => "correct" if params[:answer] == params[:correct] && params[:answer] != params[:chosen]
    return li params, :class => "correct win" if params[:answer] == params[:correct]
    return li params, :class => "incorrect" if params[:answer] == params[:chosen] && params[:chosen] != params[:correct]
    li params
  end
  
  private
  
  def li(params, html_class = {})
    content_tag :li, params[:answer], html_class
  end
  
end
