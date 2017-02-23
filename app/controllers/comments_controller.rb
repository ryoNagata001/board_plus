class CommentsController < ApplicationController
    def create
        @my_thread = MyThread.find(params[:my_thread_id])
        @comment = @my_thread.comments.new(comment_params)
        if @comment.save
            redirect_to my_thread_path(@my_thread.id), motice: '投稿されました'
        else
            render my_thread_path(@my_thread.id)
        end
    end
    def edit
        @my_thread = MyThread.find(params[:my_thread_id])
        @comment = @my_thread.comments.find(params[:id])
    end
    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to my_thread_path(:id => @comment.my_thread_id)
        else
            render 'edit'
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to my_thread_path(:id => params[:my_thread_id])
    end

    private
    def comment_params
        params.require(:comment).permit(:name, :content, :my_thread_id)
    end
end
