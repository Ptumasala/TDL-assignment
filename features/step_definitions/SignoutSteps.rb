# (/^ ......... $/) is called a regular expression and is used to help programm to find your comands

Then (/^I log out from Inbox App$/) do
  @pages.home.logOutButton.visible?
  @pages.home.logOutButton.click
end