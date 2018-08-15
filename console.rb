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

artist3 = Artist.new({
  'name' => 'Neil Young'
})
artist3.save

album1 = Album.new({
  'title' => 'Shamanaid',
  'genre' => 'Psychedelic Blues',
  'release_date' => '2015-03-11',
  'artist_id' => artist1.id
})
album1.save

album2 = Album.new({
  'title' => 'Loves Voodoo',
  'genre' => 'Psychedelic Blues',
  'release_date' => '2013-11-13',
  'artist_id' => artist1.id
})
album2.save

album3 = Album.new({
  'title' => "Who's Next",
  'genre' => 'R&B',
  'release_date' => '1971-08-14',
  'artist_id' => artist2.id
})
album3.save

album4 = Album.new({
  'title' => 'The Who Sell Out',
  'genre' => 'R&B',
  'release_date' => '1967-12-15',
  'artist_id' => artist2.id
})
album4.save

album5 = Album.new({
  'title' => 'Harvest',
  'genre' => 'Folk',
  'release_date' => '1972-02-14',
  'artist_id' => artist3.id
})
album5.save

album6 = Album.new({
  'title' => 'Rust Never Sleeps',
  'genre' => 'Folk/Rock',
  'release_date' => '1979-06-22',
  'artist_id' => artist3.id
})
album6.save

album7 = Album.new({
  'title' => 'The Monsanto Years',
  'genre' => 'Folk/Rock',
  'release_date' => '2015-06-29',
  'artist_id' => artist3.id
})
album7.save

binding.pry
nil
