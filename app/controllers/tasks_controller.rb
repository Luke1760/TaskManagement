class TasksController < ApplicationController

  def index
    @query = current_user.tasks.ransack(params[:query])
    @tasks = @query.result(distinct: true)

    respond_to do |format|
      format.html
    end
  end
end
