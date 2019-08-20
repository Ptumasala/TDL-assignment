require_relative '../../features/pages/base'
# Login page class
class LoginPage < BasePage
  attr_accessor :email, :password, :loginButton

  def initialize
    @email = Element.new(:xpath, "//*[@id='imapuser']") 
    @password = Element.new(:xpath, "//*[@id='pass']")
    @loginButton = Element.new(:xpath, "//*[@id='btn_sign-in']")
  end

  def fill_form(user)
    @email.visible?
    @email.click
    @email.send_keys user['email']
    @password.click
    @password.send_keys user['password']
    @loginButton.click
  end

  def load_home_page
    visit ''
    @email.visible?
    @password.visible?
    @loginButton.visible?
  end
end