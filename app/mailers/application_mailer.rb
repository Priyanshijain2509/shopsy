# frozen_string_literal: true

# Mailer to send the mails for confirmation
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
