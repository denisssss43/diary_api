class Diary < ApplicationRecord
    
    validates :expiration, inclusion: { in: [nil] }, if: :in_public?
    # validates :expiration, presence: true #, if: :is_public?
    validates :title, presence: true 
    validates :kind, presence: true
    
    enum kind: {in_public:0, in_private:1}
    has_many :notes, dependent: :destroy

    def in_public?
        kind == 0
    end 
end
