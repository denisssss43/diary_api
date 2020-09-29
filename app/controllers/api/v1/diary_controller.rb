class Api::V1:DiaryController < ApplicationController
    before_action :set_diaries

    def show
        render 
    end

    private
        def set_diaries
            @diary = Diary.find(params[:id])
        end

end