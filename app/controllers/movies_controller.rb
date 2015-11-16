class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:ratings] != nil
      @selected_ratings = params[:ratings]
      @movies = Movie.where(:rating => @selected_ratings.keys)
    else
      @movies = Movie.all
    end 
    
    @all_ratings = Movie.all_ratings
    
    if params[:sort] != nil 
      field = params[:sort]
      @movies = Movie.order(field)
    end
    
    @saved_ratings = {}
    
    @all_ratings.each do |rating|
      if @selected_ratings != nil && @selected_ratings[rating] != nil
        @saved_ratings[rating] = true
      else
        @saved_ratings[rating] = false
      end
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def get
    
  end


end
