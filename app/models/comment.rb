# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class Comment < ActiveRecord::Base
  belongs_to :post
  default_scope -> { order('created_at DESC') }
  #attr_accessible :content, :name
  validates :content, presence: true, length: { maximum: 1400 }
  validates :name, presence: true, length: { maximum: 100 }
  validates :post_id, presence: true
end
