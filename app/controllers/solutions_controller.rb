class SolutionsController < ApplicationController
  def new
    @solution = Solution.find_or_initialize_by(user_id: current_user.id, task_id: params[:task])
    if @solution.new_record?
      @task = @solution.task
      @task.class_files.visible.each do |visible_class_file|
        @solution.class_files << visible_class_file.dup
      end
    else
      redirect_to edit_solution_path(@solution)
    end
  end

  def update
    @solution = Solution.find_by_id(params[:id])
    set_standard_input
    if params[:solution][:run] == 'true'
      run_solution @solution
    else
      update_solution @solution
    end
  end

  def edit
    @solution = Solution.find_by_id(params[:id])
    @task = @solution.task
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.user = current_user
    set_standard_input
    if params[:solution][:run] == 'true'
      run_solution @solution
    elsif @solution.save
      redirect_to edit_solution_path(@solution), notice: 'Solution was saved'
    else
      render 'new'
    end
  end

  def destroy
    @solution = Solution.find_by_id(params[:id])
    @solution.destroy
    redirect_to tasks_path, notice: 'Solution was deleted'
  end

  private

  def solution_params
    params.require(:solution).permit(:task_id, class_files_attributes: [:id, :filename, :code])
  end

  def set_standard_input
    if params[:solution][:custom_input] == '1'
      @solution.stdin = params[:solution][:stdin]
    else
      @solution.stdin = @solution.task.stdin
    end
  end
end
