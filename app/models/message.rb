class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :clip

  field :content, type: String

  embedded_in :room

  def user_email
    user.email
  end

  def as_json *args
    {
      :id => id,
      :user_id => user.id,
      :user_email => user.email,
      :content => content,
      :created_at => created_at,
      :clip => clip.as_json
    }
  end
end
