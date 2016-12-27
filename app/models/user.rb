# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  access_token    :string(255)
#  family          :boolean          default(FALSE)
#  friends         :boolean          default(FALSE)
#  others          :boolean          default(TRUE)
#

class User < ActiveRecord::Base
  #attr_accessible :name, :password, :password_confirmation, :family, :friends, :others
  has_secure_password
  has_many :posts, dependent: :destroy

  #before_save { self.name.downcase! }
  before_save :create_remember_token
  before_create :generate_access_token

  validates(:name, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: true })
  validates(:password, length: { minimum: 6 })
  validates(:password_confirmation, presence: true)
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # simple random salt
    def random_salt(len = 20)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      salt = ""
      1.upto(len) { |i| salt << chars[rand(chars.size-1)] }
      return salt
    end

    # SHA1 from random salt and time
    def generate_access_token
      self.access_token = Digest::SHA1.hexdigest("#{random_salt}#{Time.now.to_i}")
    end

    # interpolate in paperclip
    Paperclip.interpolates :access_token  do |attachment, style|
      attachment.instance.access_token
    end
end
