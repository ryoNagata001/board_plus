class MyThreadsController < ApplicationController
   def index
        @my_threads = MyThread.all
        @current_user = current_user
    end
    
    def show
        @my_thread = MyThread.find(params[:id])
    end

    def new
        @my_thread = MyThread.new
    end

    def create
        @my_thread = MyThread.new(my_thread_params)
        if @my_thread.save
            redirect_to my_threads_path
        else
           render :new
        end
    end

    def edit
        @my_thread = MyThread.find(params[:id])
    end

    def update
        @my_thread = MyThread.find(params[:id])
        if @my_thread.user_id == current_user.id
            if @my_thread.update(my_thread_params)
                redirect_to my_threads_path
            else
                render "edit"
            end
        else
            render "/"
        end
    end
    def destroy
        @my_thread = MyThread.find(params[:id])
        if @my_thread.user_id == current_user.id
            @my_thread.destroy
            redirect_to my_threads_path
        else
            reder "/"
        end
    end
    private

    def my_thread_params
        params[:my_thread].permit(:title).mearge(user_id: current_user.id)
    end
end
