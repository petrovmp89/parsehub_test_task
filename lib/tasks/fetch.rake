# frozen_string_literal: true

desc 'Gets the latest results from parsehub'
task fetch: :environment do
  ParseLatestData.fetch_latest_data
end
