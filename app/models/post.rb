# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

include ApplicationHelper

class Post < ActiveRecord::Base
  attr_accessible :text, :picture, :family, :friends, :others
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 140 }
  has_attached_file :picture,
                    :styles => { :regular => "800x800>", :medium => "300x300>", :thumb => "100x100>" },
                    :path => "/:attachment/:access_token/:style.:extension",
                    :default_url => "/missing/:style/missing.jpg",
                    :convert_options => { :regular => "-unsharp 1.5x1+0.7+0.02" , :original => "-quality 55"}	# This will resharpen the image after the blurring that occurs due to the downsampling.

  default_scope order: 'posts.created_at DESC'
  before_create :generate_access_token

  private

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
