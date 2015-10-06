require "rspec/mocks"
require_relative "../game"
require_relative "../move"
require_relative "../adjacent_space"
require_relative "../board"
require_relative "../player"

RSpec.configure do |config|
  config.mock_with :rspec
end
