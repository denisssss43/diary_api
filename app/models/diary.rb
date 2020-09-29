class Diary < ApplicationRecord
    enum kind: {is_public:0, is_private:1}
    has_many :notes, dependent: :destroy
    validates :expiration, if: :is_public?, inclusion: { in: [nil] }
    validates :title, presence: true 
    validates :kind, presence: true

    def is_public?
        kind == :is_public
    end 
end
