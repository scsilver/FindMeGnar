class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def self.default
    @search = Search.new(['110 ski Hill rd, Breckenridge'])
    @resorts = @search.resorts
    render action: 'show'
  end

  def create
    @search = Search.new(params[:search])
    @resorts = @search.resorts
    render action: 'show'
  end
end
