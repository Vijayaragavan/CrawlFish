class CreateFunctionStripString < ActiveRecord::Migration
  def up
    execute <<-SQL
    CREATE FUNCTION f_stripstring (str VARCHAR(255))
    RETURNS VARCHAR(255)
    DETERMINISTIC
    BEGIN
     DECLARE LowerStr, strippedStr VARCHAR(255);
     SET LowerStr = lower(str);
     SET strippedStr =  replace(replace(replace(replace(replace(replace(LowerStr,'-',''),',',''),'.',''),'!',''),'?',''),' ','');
     RETURN strippedStr;
    END
    SQL
  end

  def down
    execute "DROP FUNCTION f_stripstring"
  end
end

