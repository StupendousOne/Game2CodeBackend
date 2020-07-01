class Friend < ApplicationRecord
    belongs_to :requestor, class_name: 'User'
    belongs_to :target, class_name: 'User'
end
