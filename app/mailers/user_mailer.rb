class UserMailer < ActionMailer::Base
  default from: "support@customerfirstcrm.nl"
  default host: "customerfirstcrm.nl"

  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "customer:First registratie")
  end

  def registration_inform_admin(user)
	  @user = user
	  mail(:to => "johnvanarkelen@gmail.com", :subject => "customer:First nieuwe gebruiker toegevoegd")
  end

  def visitor_info_email(visitor_email)
    @visitor_email = visitor_email
    mail(:to => "support@customerfirstcrm.nl", :subject => "Info aanvraag customer:First")
  end

end
