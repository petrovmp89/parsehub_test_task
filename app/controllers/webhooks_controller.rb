# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    FetchLatestJob.perform_later if params[:status] == 'complete'
    head :ok
  end
end
