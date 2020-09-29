class Diary < ApplicationRecord
    
    enum kind: {is_public:0, is_private:1}
    
    validates :title, presence: true 
    validates :kind, presence: true
    validates :expiration, inclusion: { in: [nil]}, if: :is_public?

    # has_many :notes, dependent: :destroy

    def is_public?
        kind == :is_public
    end 
end
