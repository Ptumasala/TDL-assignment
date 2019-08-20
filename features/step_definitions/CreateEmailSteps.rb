# (/^ ......... $/) is called a regular expression and is used to help programm to find your comands

And (/^I create a new email$/) do
  @pages.home.logOutButton.visible?
  @pages.home.createEmailButton.click
  @pages.home.recepientBox.send_keys('testdevlabtest@inbox.lv')
  @pages.home.emailMessageBox.send_keys('random text')
  sleep 30
end