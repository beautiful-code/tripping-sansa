class Saying
  include Mongoid::Document
  field :text, type: String

  belongs_to :clip

  validates_presence_of :clip

end
