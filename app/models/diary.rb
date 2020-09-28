class Diary < ApplicationRecord
    
    enum kind: {public:0, private:1}
    
    validates :title, presence: true 
    validates :kind, presence: true
    validates :expiration, inclusion: { in: [nil]}, if: :is_public?

    def is_public?
        kind == :public
    end 
end
