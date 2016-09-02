class CommentNotifier < ApplicationMailer
  def created(comment, user)
    @user = user
    @comment = comment
    
    @ticket = comment.ticket
    @project = @ticket.project
    
    subject = "[ticketee] #{@project.name} - #{@ticket.name}"
    mail(to: user.email, subject: subject)
  end
end
