class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
  
  def add
    @x = Director.new
    @x.name = params.fetch(:query_name)
    @x.dob = params.fetch(:query_dob)
    @x.bio = params.fetch(:query_bio)
    @x.image = params.fetch(:query_image)
    @x.save
    redirect_to("/directors")
  end

  def update
    path_id = params.fetch("path_id").to_i
    matching_directors = Director.where({ :id => path_id })
    director = matching_directors.at(0)
  
    director.name = params.fetch("query_name")
    director.dob = params.fetch("query_dob")
    director.bio = params.fetch("query_bio")
    director.image = params.fetch("query_image")
    director.save
  
    redirect_to("/directors/#{ director.id }")
  end

  def delete
    the_id = params.fetch("path_id")
    matching_directors = Director.where({ :id => the_id })
    director = matching_directors.at(0)
  
    director.destroy
  
    redirect_to("/directors")
    end

end
