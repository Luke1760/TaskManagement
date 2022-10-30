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
    @task = Task.new(set_task_params)

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

  def edit 
    @task = Task.find(params[:id])
  end

  def update 
    @task = Task.find(params[:id])

    if @task.update(set_task_params)
      redirect_to task_path(@task), notice: "已更新任務「#{@task.name}」。"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])

    @task.destroy
    redirect_to tasks_path, notice: "已刪除任務「#{@task.name}」。"
  end

  private 

  def set_task_params
    params.require(:task).permit(:name, :description)
  end
end
