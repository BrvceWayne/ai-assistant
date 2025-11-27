class Message < ApplicationRecord
  belongs_to :game

  validates :role, presence: true, inclusion: { in: %w[user assistant] }
  validates :content, presence: true
end
