class Indexes < ActiveRecord::Migration
  def up
  end
  execute <<-SQL
    CREATE INDEX
      places_names_lowercase
    ON
      places (lower(name) varchar_pattern_ops);
  SQL

  execute <<-SQL
    CREATE INDEX
      places_cities_lowercase
    ON
      places (lower(city) varchar_pattern_ops);
  SQL

  def down
    execute <<-SQL
      DROP INDEX places_names_lowercase;
      DROP INDEX places_cities_lowercase;
    SQL
  end
end
