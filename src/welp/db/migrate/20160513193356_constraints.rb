class Constraints < ActiveRecord::Migration
  def up
    execute <<-SQL
    create or replace function is_superuser(int) returns boolean as $$
      select exists (
        select 1
        from users
        where user_id = $1
          and is_admin = true
      );
      $$ language sql;

      ALTER TABLE
        places
      ADD CONSTRAINT
        place_constructed_by_admin
      CHECK (is_superuser(creator_id));
    SQL

    execute <<-SQL
      create or replace function comment_after_creation(date, int) returns boolean as $$
        select exists (
          select 1
          from places
          where place_id = $2
            and creation_date <= $1
        );
        $$ language sql;

        ALTER TABLE
          comments
        ADD CONSTRAINT
          comment_created_after_place_creation
        CHECK (comment_after_creation(creation_date, place_id));
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE places DROP CONSTRAINT place_constructed_by_admin;
      ALTER TABLE comments DROP CONSTRAINT comment_created_after_place_creation;
    SQL
  end
end
