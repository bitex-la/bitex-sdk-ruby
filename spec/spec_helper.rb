require 'bundler/setup'
Bundler.setup

require 'bitex'

require 'byebug'
require 'factory_bot'
require 'rspec/its'
require 'webmock/rspec'
require 'timecop'
require 'webmock/rspec'

FactoryBot.find_definitions
Dir[File.expand_path('support/**/*.rb', __dir__)].each { |f| require f }

RSpec.configure do |config|
  config.include(FactoryBot::Syntax::Methods)
  config.include(Helpers)

  config.mock_with(:rspec) do |mocks|
    mocks.yield_receiver_to_any_instance_implementation_blocks = true
    mocks.syntax = %i[expect]
  end

  config.expect_with(:rspec) do |c|
    c.syntax = %i[expect]
  end

  config.after(:each) { Timecop.return }

  config.order = 'random'
end
