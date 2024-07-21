# frozen_string_literal: true

class Notebook < ApplicationRecord
  belongs_to :status
  belongs_to :users, class_name: 'User', foreign_key: 'owner_id', inverse_of: :notebooks

  validates :name, presence: true, length: { maximum: 100 }
end
