require_relative 'database_connection'
require 'uri'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
    Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = '#{id}';")
    create_bookmark_from(result)
  end

  def self.add_new(url, title)
    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")
    create_bookmark_from(result)
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id, new_title, new_url)
    result = DatabaseConnection.query("UPDATE bookmarks SET
                        title = '#{new_title}',
                        url = '#{new_url}'
                        WHERE id = '#{id}'
                        RETURNING id, url, title;")
    create_bookmark_from(result)
  end

  def self.valid(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/ ? true : false
  end

  private_class_method

  def self.create_bookmark_from(db_result)
    Bookmark.new(id: db_result[0]['id'], title: db_result[0]['title'], url: db_result[0]['url'])
  end

end
