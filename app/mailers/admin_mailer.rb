class AdminMailer < ActionMailer::Base
  default from: "admin@ironocean.io"

  def contact(email, message)
    @email = email
    @message = message
    mail to: "amcritchie@ironocean.io", from: "admin@ironocean.io", subject: "Contact From #{email}."
  end
end
