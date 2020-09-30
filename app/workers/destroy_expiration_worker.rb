require 'sidekiq-scheduler'

class DestroyExpirationWorker  
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
        puts 'DestroyExpirationWorker ' + Time.now 

        diaries = Diary.where(["expiration < ?", Time.now])
        diaries.each do |d| 
            puts 'id: '+ d.id
            d.destroy
        end
    end

end