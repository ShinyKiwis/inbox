# frozen_string_literal: true

class Status < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  scope :privacy_status, -> { where(status_type: :privacy) }

  def name
    super.try(:inquiry)
  end
end
