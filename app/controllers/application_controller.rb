# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :json
  include ApiException::Handler

  # rubocop:disable Style/ConditionalAssignment, Metrics/ParameterLists
  def render_json(data: {}, serializer: '', message: '', code: :ok, extra: {}, use_extra: false)
    json = {}
    json[:meta] = { message: }
    if params[:page].present? && params[:per_page].present?
      json[:meta][:page] = params[:page].to_i if params[:page].present?
      json[:meta][:per_page] = params[:per_page].to_i if params[:per_page].present?
      json[:meta][:total_data] = data.count
    end

    if use_extra
      json[:data] = extra
    else
      json[:data] = serialize(data, serializer).as_json
    end

    render json:, status: code
  end
  # rubocop:enable Style/ConditionalAssignment, Metrics/ParameterLists

  private

  def serialize(data, serializer)
    serializer_class = "#{serializer}Serializer".constantize

    if params[:page].present? && params[:per_page].present?
      data = data.paginate(page: params[:page], per_page: params[:per_page])
      return ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer_class)
    end
    if data.is_a? ActiveRecord::Relation
      return ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer_class)
    end

    ActiveModelSerializers::SerializableResource.new(data, serializer: serializer_class)
  end
end
