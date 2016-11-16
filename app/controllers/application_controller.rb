class ApplicationController < ActionController::API
  respond_to :html, :xml, :json
  include ActionController::RespondWith

  def required(params, *paramlst)
    blanks = paramlst - paramlst.reject {|x| params[x] == "" or params[x].nil? }
    if blanks.empty?
      parameters = paramlst.map {|x| params[x] }
      parameters.count == 1 ? parameters.first : parameters
    else
      return nil
    end
  end

  def show_response(**args)
    render json: args
  end
end
