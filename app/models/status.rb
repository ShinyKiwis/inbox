# frozen_string_literal: true

class Status < ApplicationRecord
  PRIVACY = {
    published: 'published',
    private: 'private',
    shared: 'shared',
  }

  OPERATIONAL = {
    pending_for_delete: 'pending_for_delete',
  }

  validates :name, presence: true, uniqueness: true

  scope :privacy_status, -> { where(status_type: :privacy) }

  def name
    super.try(:inquiry)
  end
end
