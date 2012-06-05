class Search < ActiveRecord::Migration
  def up
    execute <<-SQL
    create table searches(id INT);
    SQL

  end

  def down

    execute "drop table searches"

  end
end
