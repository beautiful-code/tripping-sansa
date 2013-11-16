class Room
  include Mongoid::Document
  field :name, type: String

  embeds_many :messages

  def as_json *args
    {
      :id => id,
      :messages => messages.as_json
    }
  end
end
