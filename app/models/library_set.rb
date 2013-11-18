class LibrarySet
  include Mongoid::Document
  field :title, type: String

  has_many :libraries
end
