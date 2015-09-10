class Question < ActiveRecord::Base

  # determine css class based on resolved
  def resolved_css(id)
    @question = Question.find(id)
    css_class = "class=text-danger"
    if @question.resolved
      css_class = "class=text-success"
    end
    css_class
  end

end
