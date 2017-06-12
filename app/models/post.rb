class Post < ApplicationRecord
  validates :location, :author_id, presence: true
  validates_presence_of :body, :unless => :image_url?

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"

  has_many :notes

end
