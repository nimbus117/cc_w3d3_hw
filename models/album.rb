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

  def Album.all(order_by:, desc: false)

    # can't use PG prepare for ORDER BY identifiers
    # https://www.postgresql.org/message-id/1421875206968-5834948.post%40n5.nabble.com

    # array of valid args for order_by
    valid_order_by = ['release_date', 'title', 'genre']
    # use release_date unless valid arg is given
    order_by = 'release_date' unless valid_order_by.include? order_by

    sql = "SELECT * FROM albums ORDER BY #{order_by}"
    sql << ' desc' if desc
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

  def Album.find_by_year(year)
    sql = "select * from albums WHERE EXTRACT(year FROM \"release_date\") = $1"
    values = [year]
    found_albums = SqlRunner.run(sql, values)
    return found_albums.map {|album| Album.new(album)}
  end

  def Album.find_like_genre(genre)
    sql = "SELECT * FROM albums WHERE genre ILIKE $1"
    values = ["%#{genre}%"]
    found_albums = SqlRunner.run(sql, values)
    return found_albums.map {|album| Album.new(album)}
  end

end
