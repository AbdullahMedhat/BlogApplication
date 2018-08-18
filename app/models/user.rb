class User < ApplicationRecord
  has_many :blogs

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable

  def self.find_for_facebook_oauth(auth)
    user = User.where(
      provider: auth.provider, uid: auth.uid
    ).first
    return user if user

    registered_user = User.where(email: auth.info.email).first
    return registered_user if registered_user
    create_new_user(auth.extra.raw_info.to_h, 'Facebook')
  end

  # for Google
  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    user = User.where(
      provider: access_token.provider, uid: access_token.uid
    ).first
    return user if user

    registered_user = User.where(
      email: access_token.info.email
    ).first
    return registered_user if registered_user
    create_new_user(data, 'Google')
  end

  def self.create_new_user(data, provider)
    User.create!(
      full_name: data['name'],
      provider: provider,
      email: data['email'],
      password: Devise.friendly_token[0, 20]
    )
  end
end
