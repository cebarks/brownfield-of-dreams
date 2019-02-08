class ApplicationMailer < ActionMailer::Base
  default from: 'emails@brownfield.io'
  layout 'mailer'
end
