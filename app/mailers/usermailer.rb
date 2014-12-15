class Usermailer < ActionMailer::Base
  default from: "devpro404@gmail.com"

  def workcreated_email(work)
    @work = work
    mail(to: work.project.user.email,subject: "Work Item Posted")
    
  end
end
