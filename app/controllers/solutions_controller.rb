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
    @solution.assign_attributes(solution_params.except(:filename))
    if final?
      if @solution.update_attributes(solution_params.except(:filename))
        flash[:success] = t('messages.update', model: Solution.model_name.human)
      else
        flash[:error] = "Fehler beim speichern"
      end
    end
    run_solution
  end

  def edit
    @solution = Solution.find_by_id(params[:id])
    @task = @solution.task
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.user = current_user
    if final?
      if @solution.save
        flash[:success] = t('messages.save', model: Solution.model_name.human)
      else
        flash[:error] = "Fehler beim speichern"
      end
    end
    run_solution
  end

  def destroy
    @solution = Solution.find_by_id(params[:id])
    @solution.destroy
    flash[:warning] = t('messages.delete', model: Solution.model_name.human)
    redirect_to tasks_path
  end

  private

  def solution_params
    params.require(:solution).permit(:task_id, class_files_attributes: [:id, :filename, :code])
  end

  def final?
    params[:solution][:run] == 'true' ? @solution.final = false : @solution.final = true
    params[:solution][:custom_input] == '1' ? @solution.stdin = params[:solution][:stdin] : @solution.stdin = @solution.task.stdin
    @solution.final
  end

  def run_solution
    @solution.run
    respond_to do |format|
      format.js
    end
  end
end
