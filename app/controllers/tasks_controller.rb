class TasksController < ApplicationController
  layout "sidebar", except: [:index]
  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find_by_id(params[:id])
  end

  def update
    @task = Task.find_by_id(params[:id])

    if @task.update_attributes(task_params)
      redirect_to tasks_path, notice: t('messages.edit_task')
    else
      render 'edit'
    end
  end

  def show
    @task = Task.find_by_id(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('messages.create_task')
    else
      render 'new'
    end
  end

  def destroy
    @task = Task.find_by_id(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: t('messages.delete_task')
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :description, :score, class_files_attributes: [:id, :filename, :code, :_destroy])
  end
end
