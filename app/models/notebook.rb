# frozen_string_literal: true

class Notebook < ApplicationRecord
  include DecodableParamsConcern

  belongs_to :status
  belongs_to :owner, class_name: 'User'

  has_many :notes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
end
