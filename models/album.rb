require_relative('../db/sqlrunner.rb')

class Album
  attr_accessor :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def save
    sql = "
      INSERT INTO albums
        (title, genre, artist_id)
      VALUES
        ($1, $2, $3)
      RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end
end
