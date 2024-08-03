# frozen_string_literal: true

class Note < ApplicationRecord
  include DecodableParamsConcern

  belongs_to :notebook
end
