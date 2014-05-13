module Api
	module V1
		class ProjectsController < ApplicationController
			respond_to :json

			def index
				if params[:p_updated_at] && params[:p_updated_at]
					updated_at_date = Time.zone.parse(params[:p_updated_at])
					@projects = Project.where("updated_at > ?", updated_at_date)
				else
					@projects = Project.all
				end

				# respond_with @projects
				# render :json =>
				respond_with @projects.to_json(:only => [:id, :name, :p_latitude, :p_longitude], :methods => [:attachment_medium_url, :created_time, :updated_time, :p_formatted_timestamp]) 
			end

			def show
				respond_with Project.find(params[:id])
			end

			def create
				# @project = 
				respond_with Project.create(project_params)
				# if 
				# 	@message = [:message => "Successfully created project"]
					
				# else
				# 	@message = [:message => "Failed to create project"]
				# 	respond_with @message
				# end
				
			end

			def update
				@project = Project.find(params[:id])
				
				respond_with @project.update(project_params)
				# 	@message = [:message => "Successfully updated project"]
				# 	respond_with @message
				# else
				# 	@message = [:message => "Failed to update project"]
				# 	respond_with @message
				# end
			end

			def destroy
				@project = Project.find(params[:id])
	   			respond_with @project.destroy
				# if @project.destroy
				# 	@message = [:message => "Successfully deleted project"]
				# 	respond_with @message
				# else
				# 	@message = [:message => "Failed to deleted project"]
				# 	respond_with @message
				# end
			end
			
		
			private
			def project_params
				params.require(:project).permit(:name, :attachment, :remove_attachment, :image_data, :updated_at, :p_updated_at, :p_latitude, :p_longitude, :p_timestamp, :timestamp_str)
			end
		end
	end
end