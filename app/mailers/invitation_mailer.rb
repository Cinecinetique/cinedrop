class InvitationMailer < ActionMailer::Base
  default from: "do-not-reply@cinecinetique.com"

  def email_invitation(project, user_name, user_email, current_user)
  	@project = project
  	@guest_name = user_name
  	@current_user = current_user.name

  	mail(to:user_email, cc:"#{current_user.name} <#{current_user.email}>", subject:"You have been invited to join the project #{@project.name}")
  end

end