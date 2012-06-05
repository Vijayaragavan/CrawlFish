class CreateFunctionRemoveStopWords < ActiveRecord::Migration
  def up
    execute "DROP FUNCTION IF EXISTS f_remove_stopwords"

    execute <<-SQL
    CREATE FUNCTION f_remove_stopwords (str VARCHAR(255))
    RETURNS INT
    DETERMINISTIC
    BEGIN
    DECLARE strippedStr,word,stripStr VARCHAR(255);
    DECLARE finalStr VARCHAR(255) DEFAULT '';
    DECLARE finalCount,wordCount,quantity INT;
    DECLARE loopcounter1,loopcounter2 INT DEFAULT 1;
    DECLARE space VARCHAR(2) DEFAULT ' ';

    SET wordCount = (LENGTH(str) - LENGTH(REPLACE(str,' ',''))+1);     
    SELECT MAX(stopword_id) INTO quantity FROM stopwords;

    carrier_loop1: LOOP
      IF loopcounter1 <= wordCount THEN
		SET stripStr = SUBSTRING_INDEX(SUBSTRING_INDEX(lower(str),space,loopcounter1),space,-1);
	       carrier_loop2: LOOP
		IF loopcounter2 <= quantity THEN
			SELECT stopword INTO word FROM stopwords WHERE stopword_id=loopcounter2;

			IF stripstr = word THEN
				SET stripstr = replace(stripstr,word,'');
	             		LEAVE carrier_loop2;
			END IF;
		ELSE
             		LEAVE carrier_loop2;
		END IF;
		SET loopcounter2 = loopcounter2 + 1;
	       END LOOP carrier_loop2;
		SET finalStr = concat(finalStr," ",stripStr);
		SET finalStr = replace(finalStr,'  ',' ');
		SET loopcounter2 = 1;
      ELSE
              LEAVE carrier_loop1;
      END IF;
      SET loopcounter1 = loopcounter1 + 1;
    END LOOP carrier_loop1;
	
      SET strippedStr = RTRIM(LTRIM(finalStr));
      IF strippedStr = '' THEN
      SET finalCount = 0;
      ELSE
      SET finalCount = (LENGTH(strippedStr) - LENGTH(REPLACE(strippedStr,' ',''))+1);
      END IF;

    RETURN finalCount;
    END
    SQL
  end

  def down
    execute "DROP FUNCTION f_remove_stopwords"
  end
end
