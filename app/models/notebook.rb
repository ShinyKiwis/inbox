# frozen_string_literal: true

class Notebook < ApplicationRecord
  belongs_to :status
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true, length: { maximum: 30 }

  def to_param
    HashCodec.encode(id)
  end
end
