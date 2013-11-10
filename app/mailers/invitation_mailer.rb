class InvitationMailer < ActionMailer::Base
  default from: "do-not-reply@cinecinetique.com"

  def email_invitation(project, user)
  	@project = project
  	@user = user
  	mail(to:user.email, subject:"You have been invited to join the project #{@project.name}")
  end

end