class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)

    respond_to do |format|
      format.html
      format.csv {
        send_data(@tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" )
      }
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

  def show ;end

  def edit ;end

  def update 

    if @task.update(set_task_params)
      redirect_to task_path(@task), notice: "已更新任務「#{@task.name}」。"
    else
      render :edit
    end
  end

  def destroy

    @task.destroy
    redirect_to tasks_path, notice: "已刪除任務「#{@task.name}」。"
  end

  private 

  def set_task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
