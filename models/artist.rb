require_relative('../db/sqlrunner.rb')

class Artist
  attr_accessor :name, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "
      INSERT INTO artists
        (name)
      VALUES
        ($1)
      RETURNING id;
    "
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update
    sql = "
      UPDATE artists
      SET name = $1
      WHERE id = $2
    "
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums
    sql = "
      SELECT *
      FROM albums
      WHERE artist_id = $1
    "
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album| Album.new(album)}
  end

  def Artist.delete_all
    sql = "
      DELETE FROM artists;
    "
    SqlRunner.run(sql)
  end

  def Artist.get_all
    sql = "
      SELECT * FROM artists;
    "
    SqlRunner.run(sql).map {|artist| Artist.new(artist)}
  end

  def Artist.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    found_artist = SqlRunner.run(sql, values)[0]
    return Artist.new(found_artist)
  end
end
