class Diary < ApplicationRecord
    
    enum kind: {is_public:0, is_private:1}
    
    validates :title, presence: true 
    validates :expiration, inclusion: { in: [nil]}, if: :is_public?
    validates :kind, presence: true

    def is_public?
        kind == :public
    end 
end
