class MainController < ApplicationController
  def index
    @news= News.find(1);
  end
end


