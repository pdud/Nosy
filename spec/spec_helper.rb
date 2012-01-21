require 'capybara/rspec'

include Capybara::DSL
Capybara.default_driver = :selenium
Capybara.app_host = "file:///"
Capybara.save_and_open_page_path = File.dirname(__FILE__) + '/../tmp'