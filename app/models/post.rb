# == Schema Information
#
# Table name: posts
#
#  id                   :integer          not null, primary key
#  text                 :string(255)
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  access_token         :string(255)
#  family               :boolean          default(FALSE)
#  friends              :boolean          default(FALSE)
#  others               :boolean          default(TRUE)
#  gallery_id           :integer
#  sort_index           :integer          default(0)
#

include ApplicationHelper

class Post < ActiveRecord::Base
  attr_accessible :text, :picture, :family, :friends, :others, :gallery_id, :sort_index
  belongs_to :user
  belongs_to :gallery
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 140 }
  has_attached_file :picture,
                    :styles => { :regular => "800x800>", :medium => "300x300>", :thumb => "100x100>" },
                    :path => "/:attachment/:access_token/:style.:extension",
                    :default_url => "/missing/:style/missing.jpg",
                    :convert_options => { :regular => "-unsharp 1.5x1+0.7+0.02" , :original => "-quality 55"}	# This will resharpen the image after the blurring that occurs due to the downsampling.
  #validates_attachment_content_type :picture, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] }
  do_not_validate_attachment_file_type :picture
  #validates_attachment_file_name :picture, :matches => [/jpg\Z/, /jpe?g\Z/]

  #default_scope order: 'posts.created_at DESC'
  default_scope -> { order('sort_index DESC, created_at DESC') }
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
