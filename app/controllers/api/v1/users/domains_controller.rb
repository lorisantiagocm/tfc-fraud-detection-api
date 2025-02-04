module Api
  module V1
    module Users
      class DomainsController < Api::V1::BaseController
        def analyze
          WhoisInformation::Analyze.call(searched_url: permitted_params[:searched_url], ip: request.ip)
            .on_success { |result| render json: result[:lookup], serializer: DomainLookupSerializer }
            .on_failure { |result| render :results, errors: result[:message] }
        end

        private

        def permitted_params
          params.permit(:searched_url)
        end
      end
    end
  end
end
