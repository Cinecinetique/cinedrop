class NotificationMailer < ActionMailer::Base
  default from: "do-not-reply@cinecinetique.com"

  def changes_notification(document, user)
  	@document = document
  	mail(to:user.email, subject:"A document has changed")
  end

end
