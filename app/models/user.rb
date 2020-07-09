class User < ApplicationRecord
    has_many :friends, foreign_key: :requestor, dependent: :destroy
    has_many :current_friends, -> { where(friends: {accepted: true}) }, through: :friends, source: :target
    has_many :pending_friends, -> { where(friends: {accepted: false}) }, through: :friends, source: :target
    has_many :follows, foreign_key: :follower, dependent: :destroy
    has_many :current_follows, through: :follows, source: :target
    has_many :scores, dependent: :destroy
    has_many :completed_challenges, -> { where(scores: {completed: true}) }, through: :scores, source: :challenge
    has_many :feeds

    has_secure_password
    validates :username, uniqueness: true

    def highest_line_score
        values = scores.map{|s| s.line_score}
        values.max{|a,b| a <=> b}
    end

    def highest_speed_score
        values = scores.map{|s| s.speed_score}
        values.max{|a,b| a <=> b}
    end

    def highest_total_score
        values = scores.map{|s| s.speed_score + s.line_score}
        values.max{|a,b| a<=> b}
    end
end
