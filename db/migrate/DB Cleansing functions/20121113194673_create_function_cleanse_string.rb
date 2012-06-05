class CreateFunctionCleanseString < ActiveRecord::Migration
  def up
    execute <<-SQL
    CREATE FUNCTION f_cleansestring (str TEXT)
    RETURNS TEXT
    DETERMINISTIC
    BEGIN
     DECLARE cleansedStr TEXT;
     SET cleansedStr = replace(replace(replace(replace(replace(replace(replace(replace(str,'â€™','\''),'â€¦','...'),'â€“','-'),'â€œ','\"'),'â€','\"'),'â€˜','\''),'â€¢','-'),'â€¡','c');
     RETURN cleansedStr;
    END
    SQL
  end

  def down
    execute "DROP FUNCTION f_cleansestring"
  end
end

