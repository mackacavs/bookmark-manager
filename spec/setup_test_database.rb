require 'pg'

def truncate_table
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE TABLE bookmarks;")
end

def create_test_rows
  Bookmark.add_new(
    'http://www.makersacademy.com',
    'Makers Academy'
  )
  Bookmark.add_new(
    'http://www.google.com',
    'Google'
  )
  Bookmark.add_new(
    'http://www.destroyallsoftware.com',
    'Destroy All Software'
  )
end
# connection.exec("INSERT INTO bookmarks (url, title) VALUES (
#                 'http://www.makersacademy.com', 'Makers Academy');")
# connection.exec("INSERT INTO bookmarks (url, title) VALUES (
#                 'http://www.google.com', 'Google');")
# connection.exec("INSERT INTO bookmarks (url, title) VALUES (
#                 'http://www.destroyallsoftware.com', 'Destroy all software');")
