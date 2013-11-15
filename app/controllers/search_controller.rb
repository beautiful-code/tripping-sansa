class SearchController < ApplicationController
  def index
    if request.post?
      queries = params[:q].split(' ')

      all_results = {}

      queries.each do |q|
        search = Clip.search {
                    fulltext q
                  }
        search.hits.each do |hit|
          all_results[hit.result] = (all_results[hit.result] || 0) + hit.score
        end
      end

      @results = all_results.sort_by{ |key, value| -value }
    end

  end
end
