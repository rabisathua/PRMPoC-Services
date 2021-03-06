module Api
  class ApiController < ApplicationController
  	skip_before_action :verify_authenticity_token, if: Proc.new{|c| c.request.format == "application/json"}
  	respond_to :json
	
		protected
			def self.set_pagination_headers(name, options)
				after_action(options) do |controller|
		      results = instance_variable_get("@#{name}")
		      response.headers["X-pagination"] = {
		        total: results.total_entries,
		        total_pages: results.total_pages,
		        previous_page: results.previous_page,
		        next_page: results.next_page,
		        out_of_bounds: results.out_of_bounds?,
		        offset: results.offset
		      }.to_json
		    end
	    end
  end
end	