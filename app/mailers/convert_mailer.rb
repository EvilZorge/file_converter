class ConvertMailer < ApplicationMailer
  default from: "from@example.com"

  def send_email(email, file)
    @file = file
    mail(to: email, subject: 'Convert Email')
  end
end
