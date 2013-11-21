class Room
  include Mongoid::Document
  field :name, type: String

  embeds_many :messages

  def as_json *args
    {
      :id => id,
      :name => name,
      :messages => messages.as_json
    }
  end
end
