require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({
  'name' => 'My Baby'
})
artist1.save

artist2 = Artist.new({
  'name' => 'The Who'
})
artist2.save

album1 = Album.new({
  'title' => 'Shamanaid',
  'genre' => 'Psychedelic Blues',
  'artist_id' => artist1.id
})
album1.save

album2 = Album.new({
  'title' => 'Loves Voodoo',
  'genre' => 'Psychedelic Blues',
  'artist_id' => artist1.id
})
album2.save

album3 = Album.new({
  'title' => "Who's Next",
  'genre' => 'R&B',
  'artist_id' => artist2.id
})
album3.save

album4 = Album.new({
  'title' => "Sell Out",
  'genre' => 'R&B',
  'artist_id' => artist2.id
})
album4.save


binding.pry
nil
