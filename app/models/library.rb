class Library
  include Mongoid::Document
  field :title, type: String

  has_many :clips
end
