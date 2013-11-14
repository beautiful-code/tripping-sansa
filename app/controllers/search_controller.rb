class SearchController < ApplicationController
  def index
    if request.post?
      @results = Clip.search {
                  fulltext params[:q] {
                    phrase_slop   1
                  }
                }.results
    end
  end
end
