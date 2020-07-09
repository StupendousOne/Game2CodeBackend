class Challenge < ApplicationRecord
    has_many :scores, dependent: :destroy
end
