class Group < ActiveRecord::Base
  attr_accessible :name, :avatar, :location, :description, :picture

  has_many :users, :through => :members
  has_many :posts, :through => :members
  has_many :members
  has_many :events
  has_many :games, :through => :users
  has_many :invites
  validates_presence_of :name
  validates_uniqueness_of :name

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  after_destroy :remove_related_members

  def add_member(user) 
  	new_member = Member.new
  	new_member.user_id = user.id
  	new_member.group_id = self.id
  	new_member.save
    current_invite = Invite.find_by_group_id_and_user_id(self.id, user.id)
    current_invite.destroy
  end

  def remove_related_members
  	related_members = Member.where(:group_id => self.id)
  	related_members.destroy_all
  end

  def add_admin(user)
    new_member = Member.new
    new_member.user_id = user.id
    new_member.group_id = self.id
    new_member.admin = true
    new_member.save
  end
end
