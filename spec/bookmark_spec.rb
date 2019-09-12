require 'bookmark'
require_relative '../database_connection_setup'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do

      bookmark = Bookmark.add_new("http://www.makersacademy.com", "Makers Academy")
      Bookmark.add_new("http://www.destroyallsoftware.com", "Destroy All Software")
      Bookmark.add_new("http://www.google.com", "Google")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks[0]).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe 'self.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.add_new("http://www.makersacademy.com", "Makers Academy")
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe 'self.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.add_new("http://www.makersacademy.com", "Makers Academy")
      new_title = 'Makers'
      Bookmark.update(bookmark.id, new_title, bookmark.url)
      bookmark = Bookmark.find(bookmark.id)
      expect(bookmark.title).to eq 'Makers'
    end
  end
end

 describe 'self.valid' do
   it 'validates a url' do
     expect(Bookmark.valid('htttp://ww.bbc.co.uk')).to be(false)
       expect(Bookmark.valid('http://www.bbc.co.uk')).to be(true)
   end
 end
