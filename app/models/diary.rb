class Diary < ApplicationRecord
    
    validates :expiration, inclusion: { in: [nil], message }, if: :is_public
    validates :title, presence: true 
    validates :kind, presence: true
    
    enum kind: {is_public:0, is_private:1}
    has_many :notes, dependent: :destroy

end
