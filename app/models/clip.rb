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

    string :library_id do
      library.id.to_s
    end
  end

  def file_path
    file.url
  end

  def as_json *args
    super(:methods => [:file_path])
  end

end
