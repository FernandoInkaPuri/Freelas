module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::ActiveRecordError, with: :render_generic_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      private

      def render_not_found(_e)
        render status: :not_found, json: '{ message: Objeto não encontrado }'
      end

      def render_generic_error(_e)
        render status: :internal_server_error, json: '{ message: Ocorreu um erro no sistema, tente novamente }'
      end
    end
  end
end
