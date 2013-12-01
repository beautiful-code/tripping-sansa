class SearchEnginesController < ApplicationController
  def index
    @files = Dir.glob("lib/search_engine/*.rb")
    @files = @files.map {|f| f.split('/').last}.map {|f| f.split('.').first}
    @files.delete('search_engine')
    @search_engines = @files
  end

  def apply
    @search_engine = params[:engine].camelize.constantize

    if params[:conv_id].present?
      @conversation = Conversation.find(params[:conv_id])
      @applied_lines = @conversation.apply(@search_engine)
    end
  end
end
