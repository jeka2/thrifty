class DepartmentsController < ApplicationController
    before_action :authenticate_admin, only: [:new, :create, :edit, :update, :delete]
    def index
        @departments = Department.all
    end

    def show
        @department = Department.find_by_id(params[:id])
        unless @department
            flash[:alert] = ["Such department doesn't exist"]
        end
    end

    def new
    end

    def create
        deparment = Deparment.new(department_params)
        if department.save 
            redirect_to departments_path
        else
            set_flash_alert_for(department)

            redirect_to departments_path
        end
    end

    def edit
        @department = Deparment.find_by_id(params[:id])
    end

    def update
        deparment = Deparment.find_by_id(params[:id])
        if department.update
            redirect_to departments_path
        else
            set_flash_alert_for(department)

            redirect_to departments_path
        end
    end

    def destroy

    end

private
    def department_params
        params.require(:department).permit(:name, :description)
    end

end