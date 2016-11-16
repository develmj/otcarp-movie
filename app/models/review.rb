class Review
  include Mongoid::Document
  field :user_id, type: Integer
  field :movie_id, type: Integer
  field :review, type: String
  field :vote, type: Integer

  def self.add_movie_review(params)
    begin
      return nil if params.to_a.empty? or not params.is_a?(Hash)
      return Review.create(user_id: params[:user_id], movie_id: params[:movie_id], review: params[:review], vote: 0)
    rescue Exception => e
      return nil
    end
  end

end
