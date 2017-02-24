class CommentsController < ApplicationController
    def create
        @my_thread = MyThread.find(params[:my_thread_id])
        @comment = @my_thread.comments.new(comment_params)
        if @comment.save
            redirect_to my_thread_path(@my_thread.id), motice: '投稿されました'
        else
            render "new"
        end
    end
    def new
        @comment = Comment.new
    end
    def edit
        @my_thread = MyThread.find(params[:my_thread_id])
        @comment = @my_thread.comments.find(params[:id])
    end
    def update
        @comment = Comment.find(params[:id])
        if @comment.user_id == current_user.id
            if @comment.update(comment_params)
                redirect_to my_thread_path(:id => @comment.my_thread_id)
            else
                render 'edit'
            end
        else
            redirect_to my_threads_path, notice: "権限がありません"
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.user_id == current_user.id
            @comment.destroy
            redirect_to my_thread_path(:id => params[:my_thread_id])
        else
            render 'edit'
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:name, :content, :my_thread_id).merge(user_id: current_user.id)
    end
end
