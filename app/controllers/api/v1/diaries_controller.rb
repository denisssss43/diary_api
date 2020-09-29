class Api::V1::DiariesController < ApplicationController
    before_action :set_diary

    def show
    end

    private
        def set_diary
            @diary = Diary.last # .find(params[:id])
        end

end