class Diary < ApplicationRecord
    enum kind: {in_public:0, in_private:1}
    
    has_many :notes, dependent: :destroy
    validates :expiration, inclusion: { in: [nil] }, if: :is_public?
    # validates :expiration, presence: true #, if: :is_public?
    validates :title, presence: true 
    validates :kind, presence: true

    def is_public?
        kind == :in_public
    end 
end
