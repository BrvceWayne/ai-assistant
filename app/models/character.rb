class Character < ApplicationRecord
  has_many :games
  validates :name, presence: true, uniqueness: true
  validates :class_type, presence: true, inclusion: { in: %w[warrior mage rogue cleric] }
  validates :health, :mana, :strength, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
