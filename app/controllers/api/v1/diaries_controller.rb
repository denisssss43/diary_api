class Api::V1::DiariesController < ApplicationController

    def index
        diaries = Diary.order('created_at DESC').take(100)
        render json: diaries, status: :ok
    end

    def show
        diary = Diary.find(params[:id])
        render json: diary, stasus: :show
    end

    def create
        diary = Diary.new(diary_params)

        if diary.save
            render json: diary, stasus: :create
        else
            render json: diary.errors, stasus: :unprocessable_entity
        end 
    end

    def destroy
        diaries = Diary.find(params[:id])
        diaries.destroy

        render json: diaries, status: :destroy
    end

    def destroy_expiration
        diaries = Diary.where(["expiration < ?", Time.now])
        diaries.each do |d| 
            d.destroy
        render json: diaries, status: :destroy
    end

    def update
        diary = Diary.find(params[:id])

        if diary.update_attributes(diary_params)
            render json: diary, stasus: :update
        else
            render json: diary.errors, stasus: :unprocessable_entity
        end 
    end

    private 
        def diary_params
            params.permit(:title, :expiration, :kind)
        end

end