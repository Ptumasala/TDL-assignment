require_relative '../../features/pages/base'
# Login page class
class HomePage < BasePage
  attr_accessor :userSettings, :logOutButton, :submitSearchBox, :createEmailButton, :recepientBox, :emailMessageBox

  def initialize
    @userSettings = Element.new(:xpath, "//*[@id=mail-menu_li_options]/a")
    @logOutButton = Element.new(:xpath, "//*[@id='header']/div[5]/div[3]/a[2]/span")
    @submitSearchBox = Element.new(:xpath, "//*[@id='quick-search_input_search-fast']")
    @createEmailButton = Element.new(:xpath, "//*[@id='mail-menu_li_compose']/a")
    @recepientBox = Element.new(:xpath, "//*[@id='suggest-to']")
    @emailMessageBox = Element.new(:xpath, "//html//body[starts-with(@class, 'cke')]")
  end

=begin
  def load_home_page
    visit ''
  end
=end
end