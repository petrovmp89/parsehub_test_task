# frozen_string_literal: true

require 'net/http'

class ParseLatestData
  LATEST_URL = "https://www.parsehub.com/api/v2/projects/#{ENV['PROJECT_TOKEN']}/last_ready_run/data?api_key=#{ENV['API_KEY']}".freeze

  def self.fetch_latest_data
    new.run
  end

  def run
    uri = URI(LATEST_URL)
    puts uri

    Net::HTTP.start(
      uri.host,
      uri.port,
      use_ssl: uri.scheme == 'https'
    ) do |http|
      request = Net::HTTP::Get.new uri

      parse http.request(request).body
    end
  end

  def parse(json_string)
    fetch JSON.parse(json_string)['SKU']
  rescue StandardError
    Rails.logger.info "Failed to parse response #{$ERROR_INFO}"
  end

  def fetch(data)
    Rails.logger.info "\n\n\nPROCESSING DATA:\n#{data}\n\n\n"
    return if data.blank?
    Sku.transaction do
      data.map { |element| handle_single_sku(element) }
    end
  end

  private

  def handle_single_sku(element)
    price = element['price']&.delete('$')
    return unless price
    url = element['url']
    sku = Sku.find_or_initialize_by(url: url)
    sku.image = element['image']
    sku.title = element['Title']
    sku.price = price.to_f
    sku.description = element['description']
    sku.save!
  end
end
