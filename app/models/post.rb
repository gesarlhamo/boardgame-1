class Post < ActiveRecord::Base
  attr_accessible :member_id, :message

  belongs_to :member
  belongs_to :group
  validates_presence_of :member_id, :message
end
