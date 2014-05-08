class AddWeeklyFunctionsToEvent < ActiveRecord::Migration
  def up
    execute(%Q{
      CREATE OR REPLACE FUNCTION next_timestamp(timestamp, boolean) RETURNS timestamp AS $$
        SELECT case when $2 then now()::date + (extract(dow from $1) - extract(dow from now()) + (case when extract(dow from $1) - extract(dow from now()) > 0 then 0 else 7 end) || ' days')::interval + $1::time else $1 end
      $$ LANGUAGE SQL;
    })

    execute(%Q{
      CREATE OR REPLACE FUNCTION next_starts_at(events) RETURNS timestamp AS $$
        SELECT next_timestamp($1.starts_at, $1.weekly)
      $$ LANGUAGE SQL;
    })

    execute(%Q{
      CREATE OR REPLACE FUNCTION next_ends_at(events) RETURNS timestamp AS $$
        SELECT next_timestamp($1.ends_at, $1.weekly)
      $$ LANGUAGE SQL;
    })
  end
  def down
    execute("DROP FUNCTION next_ends_at(events)")
    execute("DROP FUNCTION next_starts_at(events)")
    execute("DROP FUNCTION next_timestamp(timestamp, boolean)")
  end
end
