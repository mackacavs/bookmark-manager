require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = self.connect.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
    Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end

  def self.find(id)
    result = self.connect.exec("SELECT * FROM bookmarks WHERE id = '#{id}';")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.add_new(url, title)
    result = connect.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id)
    connect.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id, new_title, new_url)
    result = connect.exec("UPDATE bookmarks SET
                        title = '#{new_title}',
                        url = '#{new_url}'
                        WHERE id = '#{id}'
                        RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])

  end

  private_class_method

  def self.connect
    return PG.connect(dbname: 'bookmark_manager_test') if ENV['ENVIRONMENT'] == 'test'
    PG.connect(dbname: 'bookmark_manager')
  end
end
