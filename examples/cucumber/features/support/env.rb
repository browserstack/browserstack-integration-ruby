require 'selenium/webdriver'

require 'browserstack-patch'
BrowserStack.integrate

browser = Selenium::WebDriver.for :chrome # :remote, :desired_capabilities => { :browser => "chrome" }

Before do |scenario|
  @browser = browser
end

at_exit do
  browser.quit
end
