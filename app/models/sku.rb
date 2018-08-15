# frozen_string_literal: true

class Sku < ApplicationRecord

  validates :image, :url,:title, :price, :description, presence: true
  validates :price, numericality: { greater_than: 0 }
end
