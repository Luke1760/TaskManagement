class TasksController < ApplicationController

  def index
    @query = current_user.tasks.ransack(params[:query])
    @tasks = @query.result(distinct: true)

    respond_to do |format|
      format.html
    end
  end

  def new 
    @task = Task.new
  end

  def create 
    @task = current_user.tasks.new(set_task_params)

    if @task.save 
      Rails.logger.info "tasks: #{@task.attributes.inspect}"
      redirect_to task_path(@task), notice: "已新增任務「#{@task.name}」。"
    else
      render :new
    end
  end

  def show 
    @task = Task.find(params[:id])
  end

  private 

  def set_task_params
    params.require(:task).permit(:name, :description)
  end
end
