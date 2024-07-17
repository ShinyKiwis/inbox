# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :username, presence: true
  before_save :update_default_avatar_image

  DEFAULT_AVATAR_URL = 'https://ui-avatars.com/'

  private

  def update_default_avatar_image
    if self.new_record? || self.username_changed?
      binding.pry
      self.default_avatar_image = HttpEngine::Engine.new(DEFAULT_AVATAR_URL).get('/api/', params: default_avatar_image_options).body
    end
  end

  def default_avatar_image_options
    {
      name: self.username,
      background: '#0565B9',
      color: '#FFFFFF',
      size: 48,
      bold: true,
      rounded: true,
      format: 'svg'
    }
  end
end
