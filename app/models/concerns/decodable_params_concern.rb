# frozen_string_literal: true

module DecodableParamsConcern
  extend ActiveSupport::Concern
  def to_param
    HashCodec.encode(id)
  end

  def hashed_param
    HashCodec.encode(id)
  end
end
