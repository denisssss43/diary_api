class Diary < ApplicationRecord
    
    enum kind: {public:0, private:1}, kind == :public
    
    validates :title, presence: true 
    validates :kind, presence: true
    validates :expiration, inclusion: { in: [nil]}, if: :is_public?

    def is_public?
        kind == 0
    end 
end
