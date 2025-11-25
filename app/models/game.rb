class Game < ApplicationRecord
  belongs_to :user
  belongs_to :character
  belongs_to :scenario
  has_many :chats
end
