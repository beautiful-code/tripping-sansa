class Clip
  include Mongoid::Document
  include Mongoid::Paperclip
  include Sunspot::Mongoid2

  field :dimensions, type: Array

  before_save :extract_dimensions

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
    super(:methods => [:file_path, :dimensions])
  end

  private

  def extract_dimensions
    return unless file
    tempfile = file.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end

end
