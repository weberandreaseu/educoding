class SolutionsController < ApplicationController
  layout "sidebar"

  def new
    @solution = Solution.find_or_initialize_by(user_id: current_user.id, task_id: params[:task])
    @task = @solution.task
    @task.class_files.each do |task_class_file|
      @solution.class_files << task_class_file.dup
    end
  end

  def update
    @solution = Solution.find_by_id(params[:id])
    if @solution.update_attributes(solution_params)
      redirect_to tasks_path, notice: 'Solution was updated'
    else
      render 'edit'
    end
  end

  def edit
    @solution = Solution.find_by_id(params[:id])
  end

  def create
    @solution = Solution.create(solution_params)
    if @solution.save
      redirect_to tasks_path, notice: 'Solution was saved'
    else
      render 'new'
    end
  end

  private

  def solution_params
    byebug
    params.require(:solution).permit(class_files_attributes: [:id, :filename, :code])
  end
end
