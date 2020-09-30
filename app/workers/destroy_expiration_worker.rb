require 'sidekiq-scheduler'

class DestroyExpirationWorker  
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
        diaries = Diary.where(["expiration < ?", Time.now])
        diaries.each do |d| 
            d.destroy
        end
    end

end