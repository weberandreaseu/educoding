class TasksController < ApplicationController
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

  def solve
    if logged_in?
      redirect_to new_solution_path(task: params[:id])
    else
      flash[:warning] = t('messages.login_first')
      redirect_to login_path
    end
  end

  def new
    @task = Task.new(basic_test: helpers.basic_test_template, advanced_test: helpers.advanced_test_template)
    @task.class_files << ClassFile.new(filename: 'Classfile.java', code: helpers.class_file_template)
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
    params.require(:task).permit(:title, :description, :basic_test, :advanced_test, :stdin, :package, :main, :score, class_files_attributes: [:id, :filename, :code, :visible, :_destroy])
  end
end
