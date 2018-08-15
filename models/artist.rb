require_relative('../db/sqlrunner.rb')

class Artist
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "
      INSERT INTO artists
        (name)
      VALUES
        ($1)
      RETURNING *;
    "
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

end
