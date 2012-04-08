class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :description, type: String
  field :private, type: Boolean, default: false
  field :thumbnail_url, type: String, default: '/assets/placeholder.png'
  field :image_count, type: Integer, default: 0
  index :image_count

  validates_presence_of :title

  default_scope asc(:title)

  slug :title

  belongs_to :user
  embeds_many :images

  scope :with_images, excludes(image_count: 0)
  scope :users_albums, ->(user) { where(user_id: user.id) }

  def set_thumbnail_url
    update_attribute(:thumbnail_url, images.sample.image_url(:thumb)) unless images.empty?
  end
end
