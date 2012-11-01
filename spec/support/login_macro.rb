module LoginMacro

  def login_user(user)
	  visit root_path
		click_link "Inloggen"
		fill_in 'email', :with => user.email
    fill_in 'password', :with => user.password
    click_button 'Inloggen'
  end
  
  def logout_and_login_user(user)
    click_link(I18n.t :logout_link)
    self.login_user(user)
  end
end