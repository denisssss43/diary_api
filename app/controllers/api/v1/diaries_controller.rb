class Api::V1::DiariesController < ApplicationController

    def index
        diaries = Diary.order('created_at DESC').take(5);
        render json: {
            status: 'SUCCESS', 
            message: 'Loaded diaries', 
            data:diaries
        }, status: :ok
    end

    def show
        
    end

end