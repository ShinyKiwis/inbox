# frozen_string_literal: true

class HashCodec
  @hashids = Hashids.new(Credentials.hash_id_key, 15)
  def self.encode(id)
    @hashids.encode(id)
  end

  def self.decode(id)
    @hashids.decode(id)
  end
end
