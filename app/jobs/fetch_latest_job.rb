# frozen_string_literal: true

class FetchLatestJob < ApplicationJob
  queue_as :default

  def perform
    ParseLatestData.fetch_latest_data
  end
end
