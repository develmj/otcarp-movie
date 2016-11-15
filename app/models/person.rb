class Person < ActiveRecord::Base
  has_and_belongs_to_many :movies, join_table: :persons_movies

  def self.new_cast(params)
    return nil if params.to_a.empty? or not params.is_a?(Hash)
    return nil unless (params[:first_name] and params[:last_name])

    attr_list = [:first_name, :last_name, :country, :language, :dob]
    attr_map = attr_list.inject({}) { |acc,attr| acc[attr] = params[attr] if params[attr]; acc }

    attr_map[:person_class] = "cast"
    attr_map[:person_type] = "actor"

    return Person.find_or_create_by(attr_map)
  end

  def self.new_crew(params)
    return nil if params.to_a.empty? or not params.is_a?(Hash)
    return nil unless (params[:first_name] and params[:last_name]) and params[:person_type]

    attr_list = [:first_name, :last_name, :country, :language, :dob]
    attr_map = attr_list.inject({}) { |acc,attr| acc[attr] = params[attr] if params[attr]; acc }

    attr_map[:person_class] = "crew"

    return Person.find_or_create_by(attr_map)
  end

end
