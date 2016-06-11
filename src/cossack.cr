require "http"
require "uri"

require "./cossack/**"

module Cossack
  alias Params = Hash(String, String)

  class Error < Exception; end
  class TimeoutError < Error; end
  class MockError < Error; end

  @@default_client = Client.new

  {% for method in %w(get post put patch delete head options) %}
    def self.{{method.id}}(*args, **nargs)
      @@default_client.{{method.id}}(*args, **nargs)
    end

    def self.{{method.id}}(*args, **nargs, &block : Request -> _)
      @@default_client.{{method.id}}(*args, **nargs, &block)
    end
  {% end %}
end
