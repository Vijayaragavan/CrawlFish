class CreateFunctionDropTemporaryTableFeatures < ActiveRecord::Migration
  def up

    execute "DROP FUNCTION IF EXISTS f_flushfeatures"

    execute <<-SQL

    CREATE FUNCTION f_flushfeatures()
    RETURNS BOOLEAN
    BEGIN
      DROP TEMPORARY TABLE features;
      RETURN true;
    END;
    SQL

  end

  def down

     execute "DROP FUNCTION f_flushfeatures"

  end
end

