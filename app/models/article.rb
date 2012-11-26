class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  mount_uploader :thumbnail, ThumbnailUploader
end
