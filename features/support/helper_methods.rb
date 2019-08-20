require 'fileutils'
def wait_until
  t = Capybara.default_max_wait_time
  time_start = Time.now.to_i
  while t > (Time.now.to_i - time_start)
    break if yield
    sleep(0.1)
  end
  raise 'Execution expired (Timeout::Error)' unless yield
end

def wait_long(param)
  orig_time = Capybara.default_max_wait_time
  Capybara.default_max_wait_time = param
  time_start = Time.now.to_i
  while Capybara.default_max_wait_time > (Time.now.to_i - time_start)
    break if yield
    sleep(0.1)
  end
  Capybara.default_max_wait_time = orig_time
  raise 'Execution expired (Timeout::Error)' unless yield
end


# @poltergeist method
def wait_traffic(param,session)
  t = Capybara.default_max_wait_time
  time_start = Time.now.to_i
  semaphore=false
  while t > (Time.now.to_i - time_start)
    session.driver.network_traffic.each do |request|
      request.response_parts.uniq(&:url).each do |response|
        if response.url.include? param
          semaphore=true
          break
        end
      end
    end
    sleep(0.1)
  end
  raise 'Execution expired (Timeout::Error)' unless semaphore
end

# check if file exists in downloads directory
def wait_to_download(file_name)
  unless File.exist?(Dir.pwd + "/tmp/downloads/#{file_name}*.csv")
    sleep 0.1
  end
  sleep 1
end

# FOR AFTER HOOK - clear download directory
def clear_files
  Dir.glob(Dir.pwd + "/tmp/downloads/*.csv").each { |file| File.delete(file) }
end
# Find element xpath in a block wrapper methods
def assert_xpath_in_block(block_selector,xpath)
  within(block_selector) { expect(Capybara.page).to have_xpath xpath.gsub('//','.//') }
end

def assert_not_xpath_in_block(block_selector,xpath)
  within(block_selector) { expect(Capybara.page).not_to have_xpath xpath.gsub('//','.//') }
end

def refresh_page
page.driver.browser.navigate.refresh
end

def tecdoc_image_exists
  visit page.find("img[src*='medias/images/tecdoc-parts']")[:src]
  expect(page).to have_css("img[src*='medias/images/tecdoc-parts']")
  page.go_back
end
