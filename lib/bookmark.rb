require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all(id = nil)
    if id == nil
      statement = "SELECT * FROM bookmarks;"
    else
      statement = "SELECT * FROM bookmarks WHERE id = '#{id}';"
    end
    result = self.connect.exec(statement)
    result.map do |bookmark|
    Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end

  def self.add_new(url, title)
    p result = connect.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id)
    self.connect.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id, new_title, new_url)
    p 'update'
    self.connect.exec("UPDATE bookmarks SET
                        title = '#{new_title}',
                        url = '#{new_url}'
                        WHERE id = '#{id}'
                        RETURNING id, url, title;")
  end

  private_class_method

  def self.connect
    return PG.connect(dbname: 'bookmark_manager_test') if ENV['ENVIRONMENT'] == 'test'
    PG.connect(dbname: 'bookmark_manager')
  end
end
