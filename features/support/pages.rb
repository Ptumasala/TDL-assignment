class Pages
  attr_accessor :inbox, :login, :users, :usermanager, :home

  def initialize
    @login ||= LoginPage.new
    @home ||= HomePage.new
  end
end
