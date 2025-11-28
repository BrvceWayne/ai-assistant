class Game < ApplicationRecord
 belongs_to :scenario
belongs_to :character
belongs_to :user, optional: true
has_many :messages, dependent: :destroy

# validates :state, presence: true
end
