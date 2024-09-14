class Comment2sController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    comment2s = Comment2.all
    render json: { comment2s: comment2s.as_json(include: [:movie, :reviewer]) }, status: :ok
  end

  def show
    comment2 = Comment2.find(params[:id])
    render json: { comment2: comment2.as_json(include: [:movie, :reviewer]) }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  def create
    comment2 = Comment2.new(comment2_params)
    if comment2.save
      render json: { comment2: comment2.as_json(include: [:movie, :reviewer]) }, status: :created
    else
      render json: { errors: comment2.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    comment2 = Comment2.find(params[:id])
    if comment2.update(comment2_params)
      render json: { comment2: comment2.as_json(include: [:movie, :reviewer]) }, status: :ok
    else
      render json: { errors: comment2.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  def destroy
    comment2 = Comment2.find(params[:id])
    if comment2.destroy
      render json: { status: 200, id: comment2.id }
    else
      render json: { errors: comment2.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  private

  def comment2_params
    params.require(:comment2).permit(:content, :movie_id, :reviewer_id)
  end
end
