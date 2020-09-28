class Diary < ApplicationRecord
    enum kind: [:public, :private], prefix: :kind
    
    validates :title, presence: true 
    validates :kind, presence: true
    validates :expiration, inclusion: { in: [nil]}, if: :is_public?

    def is_public?
        kind == 0
    end 
end
