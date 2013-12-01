class Conversation
  include Mongoid::Document
  field :title, type: String
  field :content, type: String

  def lines
    content.split("\r\n")
  end

  def apply search_engine
    applied_lines = []

    lines.each do |line|
      user = line.split(',').shift
      msg = line.split(',')[1,line.length].join(',')

      results = search_engine.search(msg)
      applied_lines << (results.present? ? [results, line]: line)
    end

    applied_lines
  end

  def applied_count search_engine
    apply(search_engine).select {|al| al.class == Array}.count
  end
end
