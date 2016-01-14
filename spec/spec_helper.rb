require 'simplecov'
require 'simplecov-rcov'

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end
SimpleCov.use_merging true
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
SimpleCov.command_name "RSpec #{rand(100000)}"
SimpleCov.start 'rails' do
  add_filter "lib/development_mail_interceptor"
end unless ENV["DISABLE_COVERAGE"]


ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

WebMock.disable_net_connect!(allow_localhost: true)

Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(app, stderr: ErrorSuppressor)
end
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  if config.inclusion_filter[:integration].blank?
    config.filter_run_excluding :integration => true
  end

  config.mock_with :mocha

  # can not use transactional fixtures, does not work with capybara :js.
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
    # Do not use :truncation on postgres, this is very slow. And only use :transaction cleaning for non-js specs.
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature, js: true) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Timecop.return
  end

  config.include FactoryGirl::Syntax::Methods
  config.include RSpecHelpers::FeatureSpecs, :type => :feature
  config.include ApplicationHelper, :type => :feature

  config.after :each, type: :feature, js: true do
    if Capybara.javascript_driver == :webkit
      page.driver.console_messages.each { |message| puts message }
    end

    page.reset!
  end
end
