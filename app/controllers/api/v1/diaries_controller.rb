class Api::V1::DiariesController < ApplicationController
    # before_action :set_diary

    def index
        @diaries = Diary.order('created_at DESC')
        render json: {
            status: 'SUCCESS', 
            message: 'Loaded diaries',
            data:@diaries
        }, status: :ok
    end

    def show
        
    end

    private
        def set_diary
            @diary = Diary.find(params[:id])
        end

end