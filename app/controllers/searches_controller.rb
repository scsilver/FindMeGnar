class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new(params[:search])
    @resorts = @search.resorts
    render action: 'show'
  end
end
