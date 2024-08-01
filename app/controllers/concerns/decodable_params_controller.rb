# frozen_string_literal: true

module DecodableParamsController
  extend ActiveSupport::Concern
  included do
    before_action :decode_id_params, if: -> { id_params.present? }
  end

  private

  def decode_id_params
    id_params.each do |key, value|
      params[key] = HashCodec.decode(value).first if value.present?
    end
  end

  def id_params
    params.slice(*params.keys.select { |key| key.end_with?('id') })
  end
end
