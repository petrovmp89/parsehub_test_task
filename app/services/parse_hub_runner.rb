# frozen_string_literal: true

require 'net/http'

class ParseHubRunner
  RUN_URL = "https://www.parsehub.com/api/v2/projects/#{ENV['PROJECT_TOKEN']}/run"

  def self.run
    params = {
      api_key: ENV['API_KEY']
    }
    url = URI.parse(RUN_URL)
    url.query = URI.encode_www_form(params)

    Net::HTTP.post_form(url, params)
  end
end
