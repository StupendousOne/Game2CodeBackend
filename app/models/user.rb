class User < ApplicationRecord
    has_many :friends, foreign_key: :requestor
    has_many :current_friends, -> { where(friends: {accepted: true}) }, through: :friends, source: :target
    has_many :pending_friends, -> { where(friends: {accepted: false}) }, through: :friends, source: :target
    has_many :follows, foreign_key: :follower
    has_many :current_follows, through: :follows, source: :target
    has_many :scores
    has_many :completed_challenges, -> { where(scores: {completed: true}) }, through: :scores, source: :challenges

    has_secure_password
    validates :username, uniqueness: true
end
