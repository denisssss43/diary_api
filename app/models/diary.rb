class Diary < ApplicationRecord
    
    validates :expiration, inclusion: { in: [nil] }, if: :check_is_public?
    validates :title, presence: true 
    validates :kind, presence: true
    
    enum kind: {is_public:0, is_private:1}
    has_many :notes, dependent: :destroy

    def check_is_public?
        kind == :is_public
    end 

    # before_validation do
    #     self.expiration = nil if kind == 0
    # end

end
