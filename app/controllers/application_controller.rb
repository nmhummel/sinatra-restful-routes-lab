class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  # takes us to new form view
  get '/recipes/new' do
    erb :new                       
  end

  # takes us to index page to READ(CRUD) all recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end 

  # takes us to the show page for ONE recipe
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  # takes us to the edit form page
  get '/recipes/:id/edit' do  
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  # UPDATE(CRUD) a recipe on its own view
  patch '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end 

  # CREATE(CRUD) a new recipe 
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  # deletes a recipe - DESTROY(CRUD)
  delete '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
