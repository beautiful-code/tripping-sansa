class Clip
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :file

  belongs_to :library

  validates_presence_of :library
end
