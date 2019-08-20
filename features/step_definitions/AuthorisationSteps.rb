# (/^ ......... $/) is called a regular expression and is used to help programm to find your comands

Given(/^I am on Inbox login page$/) do
  @pages.login.load_home_page
end

And(/^I login as (.*)/) do |user|
  file = YAML.load_file('config/test_data.yml')
  case user
  when 'user1' then
    $user_manager.current_user = 'user1'
    @pages.login.fill_form(file['user1'])
  end
end
  
Then (/^I see that login was successful$/) do
  @pages.home.submitSearchBox.visible?
end