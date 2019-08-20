$LOAD_PATH << File.dirname(__FILE__)

require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'site_prism'
require 'selenium-webdriver'
require 'json'
require 'chromedriver/helper'
require 'base64'
require 'capybara/poltergeist'
require 'phantomjs'
require 'capybara/rspec'
require 'test/unit/assertions'
require 'money'
require 'monetize'
require 'cucumber'

case ENV['PLATFORM']
  when 'prod' then 
    Capybara.app_host = 'https://www.inbox.lv/'
  when 'uat' then
    Capybara.app_host = 'https://www.inbox.lv/'
  when 'preprod' then
    Capybara.app_host = 'https://www.inbox.lv/'
  when 'valid' then
    Capybara.app_host = 'https://www.inbox.lv/'
  else
    Capybara.app_host = 'https://www.inbox.lv/'
end

Capybara.save_path = 'report/'
Capybara::Screenshot.autosave_on_failure = false
Capybara::Screenshot.prune_strategy = :keep_last_run

# =================================================================== #
#######################################################################
# ========================= ENVIRONMENT SETUP ========================#
case ENV['BROWSER']
when 'chrome' then
  Capybara.register_driver(:selenium) do |app|
    prefs = { prompt_for_download: false, default_directory: "#{Dir.pwd}/tmp/downloads" }
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_preference(:download, prefs)
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
when 'firefox' then
  if Gem::Platform.local.os == 'darwin'
    Selenium::WebDriver::Firefox.path = '/Applications/Firefox2.app/Contents/MacOS/firefox'
    Capybara.register_driver(:selenium) {|app| Capybara::Selenium::Driver.new(app, browser: :firefox, marionette: false)}
  elsif Gem::Platform.local.os == 'mingw32'
    Capybara.register_driver(:selenium) {|app| Capybara::Selenium::Driver.new(app, browser: :firefox)}
  end
end
World(Test::Unit::Assertions)
Capybara.default_driver = :selenium
# =============================================================== #
# ######################################################################
# ========================= SCENARIO TEARDOWN ========================#
#
# ---------------------------------------------------------------------
# -----------------------BEFORE HOOKS ---------------------------------
# ---------------------------------------------------------------------#


Before() do |_scenario|
  @pages = Pages.new
  @test_data = YAML.load_file('config/test_data.yml')
  $user_manager = UserManager.new
  @languages = @test_data['Languages']
 #@api_url = Capybara.app_host.gsub('www.', '')
 @api_url = Capybara.app_host
 #Capybara.current_session.driver.quit
  Capybara.current_session.driver.browser.manage.delete_all_cookies
 Capybara.current_session.driver.browser.manage.window.resize_to(1800, 1000)
  Capybara.ignore_hidden_elements = false
  Capybara.default_max_wait_time = 10
  @pages.login.load_home_page
end

# ------------------------------------------------------------------------
# -----------------------AFTER HOOKS--------------------------------------
# ------------------------------------------------------------------------


After() do |scenario|
  if scenario.failed?
    add_screenshot
    print_browser_logs
    Capybara.current_driver = Capybara.javascript_driver
    page.execute_script("if (navigator.appName == 'Microsoft Internet Explorer')" \
                      "{ window.location = 'about:blank';}" \
                      "else {'return window.stop();'}")
    Capybara.current_driver = Capybara.default_driver
    Capybara.current_session.driver.browser.manage.delete_all_cookies
  end
end

AfterStep('not @poltergeist') do |_scenario|
  Capybara.ignore_hidden_elements = false
end

After('@delete_downloads') do |scenario|
  clear_files if scenario.failed?
end


def add_screenshot
  file_name = 'screenshot.png'
  file_path = "report/#{file_name}"
  page.driver.browser.save_screenshot(file_path)
  image = open(file_path, 'rb', &:read)
  encoded_image = Base64.encode64(image)
  embed(encoded_image, 'image/png;base64', 'SCREENSHOT')
end

def print_browser_logs
  # Getting current URL
  current_url = Capybara.current_url.to_s
  # Gather browser logs
  logs = page.driver.browser.manage.logs.get(:browser).map {|line| [line.level, line.message]}
  logs.reject! {|line| %w[WARNING INFO].include?(line.first)}
  logs.any?
  embed(Time.now.strftime('%Y-%m-%d-%H-%M-%S' + "\n") + ('Current URL: ' + current_url + "\n") + logs.join("\n"), 'text/plain', 'BROWSER ERROR')
  # puts '========== BROWSER LOGS =========='
  logs.each do |line|
    # puts line.join(' - ')
    # puts '=================================='
    # puts '========== CURRENT link =========='
    # puts current_url
    # puts '=================================='
  end
end