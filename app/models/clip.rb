class Clip
  include Mongoid::Document
  include Mongoid::Paperclip
  include Sunspot::Mongoid2
  

  has_mongoid_attached_file :file

  belongs_to :library
  has_many :sayings, dependent: :destroy

  validates_presence_of :library

  searchable do
    text :sayings do
      sayings.map {|s| s.text}
    end

    string :library_title do
      library.title
    end
  end

end
