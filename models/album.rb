require_relative('../db/sqlrunner.rb')

class Album
  attr_accessor :title, :genre, :release_date, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @release_date = options['release_date']
    @artist_id = options['artist_id']
  end

  def save
    sql = "
      INSERT INTO albums
        (title, genre, release_date, artist_id)
      VALUES
        ($1, $2, $3, $4)
      RETURNING id;
    "
    values = [@title, @genre, @release_date, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update
    sql = "
      UPDATE albums
      SET (
        title, genre, release_date, artist_id
      ) = (
        $1, $2, $3, $4
      )
      WHERE id = $5
    "
    values = [@title, @genre, @release_date, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist
    sql = "
      SELECT *
      FROM artists
      WHERE id = $1
    "
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)
    return Artist.new(artist[0])
  end

  def Album.delete_all
    sql = "
      DELETE FROM albums;
    "
    SqlRunner.run(sql)
  end

  def Album.get_all
    sql = "
      SELECT * FROM albums;
    "
    SqlRunner.run(sql).map {|album| Album.new(album)}
  end

  def Album.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    found_album = SqlRunner.run(sql, values)[0]
    return Album.new(found_album)
  end

  def Album.find_like_title(title)
    sql = "SELECT * FROM albums WHERE lower(title) LIKE $1"
    values = ["%#{title}%"]
    found_albums = SqlRunner.run(sql, values)
    return found_albums.map {|album| Album.new(album)}
  end
end
