class ClassFilesController < ApplicationController
  def new
    @task = Task.find(params[:task_id])
    @class_files = @task.class_files.all
    @class_files.build

    respond_to do |format|
      format.js
    end
  end

  def destroy
    # @class_file = ClassFiles.find(params[:id])
    # @class_file.destroy
    #   respond_to do |format|
    #   format.js
    # end
  end
end
