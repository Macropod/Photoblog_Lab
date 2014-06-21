# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Gallery < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date
  has_many :posts, dependent: :destroy
  validates(:name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: true })
  #default_scope order: 'galleries.start_date DESC'
  default_scope -> { order('start_date DESC') }
end
