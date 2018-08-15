require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')

artist1 = Artist.new({
  'name' => 'My Baby'
})

artist1.save

artist2 = Artist.new({
  'name' => 'The Who'
})

artist2.save

binding.pry
nil
