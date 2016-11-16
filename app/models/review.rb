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

  def self.get_paginated_reviews(movie_id, page_size = nil, cur_page = nil)
    return nil unless (movie_id or movie_id.is_a?(Integer))

    if cur_page.to_i > 0 and page_size.to_i > 0
      payload = Review.where(movie_id: movie_id.to_i).limit(page_size).offset(cur_page)
      total_count = Review.where(movie_id: movie_id.to_i).count
    else
      payload = Review.where(movie_id: movie_id.to_i)
      total_count = payload.count
    end

    return { status: true, msg: "#{total_count} reviews found!", payload: payload, current_page: cur_page, page_size: page_size }
  end

end
