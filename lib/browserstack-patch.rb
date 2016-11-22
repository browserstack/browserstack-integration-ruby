require 'selenium/webdriver'
require 'browserstack/local'

$cucumber_after = self.method(:After) rescue nil
$browserstack_username = ENV['BROWSERSTACK_USERNAME'] || ENV['BROWSERSTACK_USER']
$browserstack_access_key = ENV['BROWSERSTACK_ACCESS_KEY'] || ENV['BROWSERSTACK_ACCESSKEY']

if ENV['RUN_ON_BSTACK'].to_s.match(/true/)
  require_relative './browserstack-patch/webdriver_patch.rb'
  
  # See: https://github.com/SeleniumHQ/selenium/issues/2950
  require_relative './browserstack-patch/keep_alive_patch.rb' unless Gem.loaded_specs["selenium-webdriver"].version.to_s.start_with?("3")
end

module BrowserStack
  @@framework = 'ruby'
  @@bs_local = nil
  @@bstack_identifier = "bstack_patches_#{(0...16).map { ('a'..'z').to_a[rand(26)] }.join}"

  def self.for(framework)
    @@framework = framework
  end

  def self.get_framework
    @@framework
  end

  def self.get_framework_version
    if @@framework.match(/cucumber/i)
      return Cucumber::VERSION
    end
  end

  def self.get_identifier
    @@bstack_identifier
  end

  def self.track_environment(track_hash)
    if ENV['TRAVIS'] && ENV['TRAVIS'].match(/true/i)
      track_hash['ci_env'] = 'travis'
      track_hash['ci_env.travis.build_id'] = ENV['TRAVIS_BUILD_ID']
      track_hash['ci_env.travis.build_number'] = ENV['process.env.TRAVIS_BUILD_NUMBER']
      track_hash['ci_env.travis.repo_slug'] = ENV['process.env.TRAVIS_REPO_SLUG']
      track_hash['ci_env.travis.test_result'] = ENV['process.env.TRAVIS_TEST_RESULT']
    elsif ENV['BUILD_TAG'] && ENV['BUILD_TAG'].match(/jenkins/i)
      track_hash['ci_env'] = ENV['jenkins']
      track_hash['ci_env.jenkins.build_id'] = ENV['process.env.BUILD_ID']
      track_hash['ci_env.jenkins.build_number'] = ENV['process.env.BUILD_NUMBER']
      track_hash['ci_env.jenkins.job_name'] = ENV['process.env.JOB_NAME']
      track_hash['ci_env.jenkins.build_tag'] = ENV['process.env.BUILD_TAG']
      track_hash['ci_env.jenkins.git_url'] = ENV['process.env.GIT_URL']
    end
  end

  private
  def self.start_local
    @@bs_local = BrowserStack::Local.new
    bs_local_args = {
      'key' => $browserstack_access_key,
      'localIdentifier' => @@bstack_identifier
    }
    @@bs_local.start(bs_local_args)

    if @@framework.match(/cucumber/i)
      $cucumber_after.call do
        @@bs_local.stop() if @@bs_local
      end
    end
  end
end
