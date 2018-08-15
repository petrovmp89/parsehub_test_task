# frozen_string_literal: true

class SkusController < ApplicationController
  def index
    @skus = paginate(Sku.all)
  end

  private

  def paginate(scope)
    scope.page(params[:page])
  end
end
