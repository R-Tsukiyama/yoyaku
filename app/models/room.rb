class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations
  validates :name, presence: true
  validates :overview, presence: true
  validates :address, presence: true
  validates :price, presence: true

  def self.search(search)
    if search != ""
      Room.where(['room_name LIKE(?) OR overview LIKE(?) OR address LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Room.all
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "name", "overview", "price", "roomimage", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

end
