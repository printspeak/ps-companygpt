# frozen_string_literal: true

require 'ps/companygpt/version'

module Ps
  module Companygpt
    # raise Ps::Companygpt::Error, 'Sample message'
    Error = Class.new(StandardError)

    # Your code goes here...
  end
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'PsCompanygpt::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('ps/companygpt/version') }
  version   = PsCompanygpt::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
