module ApplicationHelper

  def form_group_tag(errors, &block)
     if errors.any?
       content_tag :div, capture(&block), class: 'form-group has-error'
     else
       content_tag :div, capture(&block), class: 'form-group'
     end
   end

   def moderator?
     # return true if current user is a moderator
     current_user.moderator?
   end

end
