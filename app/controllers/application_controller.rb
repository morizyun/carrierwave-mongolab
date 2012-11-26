class ApplicationController < ActionController::Base
  protect_from_forgery

  def image
    gridfs_path = env["PATH_INFO"].gsub("/images/", "")
    begin
      settings = Mongoid.load!("config/mongoid.yml")
      database_name = settings["sessions"]["default"]["database"].to_s
      uri = 'mongodb://' + settings["sessions"]["default"]["hosts"].first.to_s
      database = Mongo::Connection.from_uri(uri).db(database_name)
      gridfs_file = Mongo::GridFileSystem.new(database).open(gridfs_path, 'r')
      self.response_body = gridfs_file.read
      self.content_type = gridfs_file.content_type
    rescue
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = ''
    end
  end
end