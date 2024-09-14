class ReviewersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    reviewers = Reviewer.all
    render json: { reviewers: reviewers.as_json }, status: :ok
  end

  def show
    reviewer = Reviewer.find(params[:id])
    if reviewer.present?
      render json: { reviewer: reviewer.as_json }, status: :ok
    else
      render json: { error: "Not found" }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  def create
    reviewer = Reviewer.new(reviewer_params)
    if reviewer.save
      render json: { reviewer: reviewer.as_json }, status: :created
    else
      render json: { errors: reviewer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    reviewer = Reviewer.find(params[:id])
    if reviewer.update(reviewer_params)
      render json: { reviewer: reviewer.as_json }, status: :ok
    else
      render json: { errors: reviewer.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  def destroy
    reviewer = Reviewer.find(params[:id])
    if reviewer.destroy
      head :no_content
    else
      render json: { errors: reviewer.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  private

  def reviewer_params
    params.require(:reviewer).permit(:name, :email)
  end
end
