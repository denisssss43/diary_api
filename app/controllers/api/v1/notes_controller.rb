class Api::V1::NotesController < ApplicationController

    def index
        notes = Note.order('created_at DESC').take(100)
        render json: notes, status: :ok
    end

    def show
        note = Note.find(params[:id])
        render json: note, stasus: :show
    end

    def create
        note = Note.new(note_params)

        if note.save
            render json: note, stasus: :create
        else
            render json: note.errors, stasus: :unprocessable_entity
        end 
    end

    def destroy
        note = Note.find(params[:id])
        note.destroy

        render json: note, status: :destroy
    end

    def update
        note = Note.find(params[:id])

        if note.update_attributes(note_params)
            render json: note, stasus: :update
        else
            render json: note.errors, stasus: :unprocessable_entity
        end 
    end

    private 
        def note_params
            params.permit(:text, :diary_id)
        end

end