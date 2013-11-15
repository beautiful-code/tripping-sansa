class SearchController < ApplicationController
  def index
    if params[:q].present?
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

    respond_to do |format|
      format.html {render action: "index"}
      format.json {render json: @results}
    end

  end
end
