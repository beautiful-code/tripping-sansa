class ExactMatch
  extend SearchEngine

  def self.search query
    query.strip!
    Saying.where(:text => query.downcase).collect(&:clip).compact
  end

end
