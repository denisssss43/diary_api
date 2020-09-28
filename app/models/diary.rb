class Diary < ApplicationRecord
    validates :title, presence: true 
    validates :kind, presence: true
    validates :expiration, inclusion: { in: [nil]}, if: :is_public?

    enum kind: [:public, :private]


    def is_public?
        kind == 0
    end 
end
