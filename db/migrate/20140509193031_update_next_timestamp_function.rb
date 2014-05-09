class UpdateNextTimestampFunction < ActiveRecord::Migration
  def up
    execute(%Q{
      CREATE OR REPLACE FUNCTION next_timestamp(timestamp, boolean) RETURNS timestamp AS $$
        SELECT case when $2 then now()::date + (extract(dow from $1) - extract(dow from now()) + (case when extract(dow from $1) - extract(dow from now()) >= 0 then 0 else 7 end) || ' days')::interval + $1::time else $1 end
      $$ LANGUAGE SQL;
    })
  end
  def down
    execute(%Q{
      CREATE OR REPLACE FUNCTION next_timestamp(timestamp, boolean) RETURNS timestamp AS $$
        SELECT case when $2 then now()::date + (extract(dow from $1) - extract(dow from now()) + (case when extract(dow from $1) - extract(dow from now()) > 0 then 0 else 7 end) || ' days')::interval + $1::time else $1 end
      $$ LANGUAGE SQL;
    })
  end
end
