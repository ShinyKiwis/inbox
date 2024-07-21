# frozen_string_literal: true

class Status < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
