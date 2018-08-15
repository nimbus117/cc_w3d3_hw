require('pg')

class SqlRunner

  def SqlRunner.run(sql, values = [])
    db = PG.connect({dbname: 'music_collection', host: ''})
    db.prepare('run', sql)
    result = db.exec_prepared('run', values)
    db.close
    return result
  end

end
