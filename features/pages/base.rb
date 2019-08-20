include RSpec::Matchers
# Class for base page template -> implements session base URL
class BasePage
  def visit(url)
    Capybara.visit url
  end
end