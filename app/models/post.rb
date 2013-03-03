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

class Post < ActiveRecord::Base
  attr_accessible :text
  belongs_to :user
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 140 }

  default_scope order: 'posts.created_at DESC'
end
