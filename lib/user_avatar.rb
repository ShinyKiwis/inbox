# frozen_string_literal: true

class UserAvatar
  DEFAULT_AVATAR_URL = 'https://ui-avatars.com'

  def initialize(username)
    @username = username
  end

  def default_avatar_url
    HttpEngine::Engine.new(DEFAULT_AVATAR_URL).full_request_url('api', default_avatar_image_options)
  end

  private

  attr_reader :username

  def default_avatar_image_options
    {
      name: username,
      background: '#0565B9',
      color: '#FFFFFF',
      size: 40,
      bold: true,
      rounded: true,
      format: 'svg',
    }
  end
end
