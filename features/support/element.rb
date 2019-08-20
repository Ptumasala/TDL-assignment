class Element
  include RSpec::Matchers
  def initialize(type, value)
    @value = Hash[type: type, value: value]
  end

  def find
    Capybara.find(@value[:type], @value[:value])
  end

  def wait
    expect(find.visible?).to eq true
  end

  def visible?
    find.visible?
  end

  def click
    find.click
  end

  def send_keys(value)
    find.send_keys value
  end

  def text
    find.text
  end

  def value
    find.value
  end

  def checked?
    find.checked?
  end

  def double_click
    find.double_click
  end

  def set(value)
    find.set(value)
  end

  def xpath
    @value[:value]
  end

  def set_xpath(path)
    @value[:value] = path
  end

  def disabled?
    find.disabled?
  end

  def enabled?
    !find.disabled?
  end

  def css
    @value[:value]
  end

  def attribute(attributeName)
    find[:atributeName]
  end
end