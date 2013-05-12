class Gallery < ActiveRecord::Base
  attr_accessible :name
  has_many :posts, dependent: :destroy
  validates(:name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: true })
end