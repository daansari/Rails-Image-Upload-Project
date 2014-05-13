class ProjectsController < ApplicationController
	def new
		@project = Project.new
	end

	def index
		@projects = Project.all
	end

	def create
		@project = Project.new(project_params)
	    if @project.save
	      # flash[:notice] = "Successfully created Project."
	      redirect_to projects_path
	    else
	      render :action => 'new'
	    end
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
   
	    if @project.update(project_params)
	      redirect_to projects_path
	    else
	      render 'edit'
	    end
	end

	def destroy
		@project = Project.find(params[:id])
	    @project.destroy
      	redirect_to projects_path
      	# , :notice => "Project deleted."
	end
private
  def project_params
    params.require(:project).permit(:name, :attachment, :remove_attachment, :image_data,  :updated_at, :p_updated_at, :p_latitude, :p_longitude, :p_timestamp)
  end
end
