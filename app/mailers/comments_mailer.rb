class CommentsMailer < ApplicationMailer

  def notify_comment_owner(comment)
    @comment   = comment
    @post = comment.post
    @owner    = @post.user
    mail(to: @owner.email, subject: "You got a new comment!")
  end

end
