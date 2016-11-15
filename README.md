# BrowserStack-Integration

Patches for Selenium scripts and test suites to run on BrowserStack when RUN_ON_BSTACK=true is set in environment.
Currently supports Capybara

![BrowserStack Logo](https://d98b8t1nnulk5.cloudfront.net/production/images/layout/logo-header.png?1469004780)

# Ruby

## Setup
* Clone the repo
* Install dependencies `bundle install`
* Export the environment variables for the Username and Access Key of your BrowserStack account
  
  ```
  export BROWSERSTACK_USERNAME=<browserstack-username>
  export BROWSERSTACK_ACCESS_KEY=<browserstack-access-key>
  ```

## Running the test

### Ruby script
- To run locally, run `cd examples/simple_sample/ && bundle install`
- To run on BrowserStack, run `RUN_ON_BSTACK=true bundle exec ruby sample.rb`

### Cucumber test
- To run locally, run `cd examples/cucumber/ && bundle install`
- To run on BrowserStack, run `RUN_ON_BSTACK=true bundle exec cucumber`

## Configuring Tests

The following environment variables are supported,

```
RUN_ON_BSTACK - Boolean. To run your tests on BrowserStack
BSTACK_BROWSER - The browser to run your tests on BrowserStack
BSTACK_BROWSER_VERSION - The browser_version to run your tests on BrowserStack
BSTACK_OS - The os to run your tests on BrowserStack
BSTACK_OS_VERSION - The os_version to run your tests on BrowserStack
BSTACK_DEVICE - The device to run your tests on BrowserStack
BSTACK_LOCAL - Boolean. Whether to start/stop BrowserStackLocal for your tests

BROWSERSTACK_USERNAME - your BrowserStack username
BROWSERSTACK_ACCESS_KEY - your BrowserStack accesskey
```

## To run tests

```ruby
bundle exec rake
```
