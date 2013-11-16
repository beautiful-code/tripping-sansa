class Message
  include Mongoid::Document

  belongs_to :user
  has_one :clip

  field :content, type: String

  embedded_in :room
end
