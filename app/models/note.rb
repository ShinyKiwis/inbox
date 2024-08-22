# frozen_string_literal: true

class Note < ApplicationRecord
  include DecodableParamsConcern

  belongs_to :status
  belongs_to :notebook

  scope :active, -> { joins(:status).where.not(statuses: { name: Status::OPERATIONAL[:pending_for_delete] }) }
end
