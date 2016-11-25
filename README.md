# BrowserStack-Automate

Run Cucumber tests on BrowserStack Automate using our Ruby integration.

> Running your Selenium tests on BrowserStack requires a username and an access key. To create an account go to www.browserstack.com/automate

![BrowserStack Logo](https://d98b8t1nnulk5.cloudfront.net/production/images/layout/logo-header.png?1469004780)

## Running First Test

You can use our integration to run your Cucumber tests on BrowserStack. It's a simple two-step process:

#### Step 1 - Install *browserstack-automate* integration

```
gem install browserstack-automate
```

#### Step 2 - Add it to your `support/env.rb` file 

You just need to add this to your configuration file

```
require 'browserstack-automate'
BrowserStack.for "cucumber"
```

That's it! You can now execute your tests on BrowserStack by using the `RUN_ON_BSTACK`, `BROWSERSTACK_USERNAME` and `BROWSERSTACK_ACCESS_KEY` environment variables.

```bash
RUN_ON_BSTACK=true BROWSERSTACK_USERNAME=<your_username> BROWSERSTACK_ACCESS_KEY=<your_access_key> bundle exec cucumber
```

## Running Local Tests

In order to run tests inside your local development environments, use ```BSTACK_LOCAL=true```.

```
RUN_ON_BSTACK=true BSTACK_LOCAL=true BROWSERSTACK_USERNAME=<username> BROWSERSTACK_ACCESS_KEY=<access_key> bundle exec cucumber
```

This creates an instance of BrowserStack Local Binary for every single build. To know more about how this works, read our documentation on [Local Testing](www.browserstack.com/local-testing).


## Running Parallel Tests

You can run your parallel tests on BrowserStack by adding ```RUN_ON_BSTACK=true``` to your parallel tests.

```
RUN_ON_BSTACK=true BROWSERSTACK_USERNAME=<username> BROWSERSTACK_ACCESS_KEY=<access_key>  bundle exec cucumber
```

## Integrating with CI

Configure these parameters in your Continuous Integration platform to run your tests directly on BrowserStack

```
//Required
RUN_ON_BSTACK - Boolean. To run your tests on BrowserStack
BROWSERSTACK_USERNAME - your BrowserStack username
BROWSERSTACK_ACCESS_KEY - your BrowserStack accesskey

//Optional
BSTACK_LOCAL - Boolean. Whether to start/stop BrowserStackLocal for your tests
```

## Further Reading
* [BrowerStack Automate documentation for Cucumber](www.browserstack.com/automate/cucumber-integration)
* [BrowserStack Automate documentation for Ruby](www.browserstack.com/automate/ruby)
* [Full range of testing capabilities on BrowserStack](www.browserstack.com/automate/capabilities)
* [Testing local, development servers with BrowserStack](www.browserstack.com/local-testing)
