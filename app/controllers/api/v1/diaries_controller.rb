class Api::V1::DiariesController < ApplicationController

    # Список из 100 последних дневников
    def index
        diaries = Diary.order('created_at DESC').take(100);
        # render json: {
        #     status: 'SUCCESS', 
        #     message: 'Loaded diaries', 
        #     data: diaries
        # }, status: :ok
        render json: diaries, status: :ok
    end

    def show
        diary = Diary.find(params[:id])

        render json: diary, stasus: :ok
    end

    # def create

end