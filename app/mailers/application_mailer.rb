class ApplicationMailer < ActionMailer::Base
  default from: 'buydeisco@gmail.com' #should this be app...com
  layout 'mailer'
end
