class BaseController < ActionController::Base
  respond_to :html

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: t('not_found') }, status: 404
    nil
  end

  rescue_from NameError, with: :error_occurred
  rescue_from ActionController::RoutingError, with: :error_occurred
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  protected

  def error_occurred(exception)
    render json: { error: exception.message }.to_json, status: 500
    nil
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
    nil
  end
end
