class CreateProcedureSplitFeatureNames < ActiveRecord::Migration
  def up

    execute "DROP PROCEDURE IF EXISTS p_Split_feature_names"
    execute "DROP TEMPORARY TABLE IF EXISTS features"

    execute <<-SQL
    CREATE PROCEDURE p_Split_feature_names(IN v1_feature TEXT, IN v1_feature_name VARCHAR(255))
    BEGIN
    DECLARE loopcounter INT Default 1;
    DECLARE quantity, level_id INT Default 0;
    DECLARE v_refinedFeature TEXT;
    DECLARE v_name VARCHAR(255);
    DECLARE delimiter CHAR(1) Default ",";

    IF v1_feature_name != "genre" THEN

    SET v_refinedFeature = replace(replace(v1_feature,' and ',','),'&',',');

    ELSE

    SET v_refinedFeature = v1_feature;

    END IF;

     CREATE TEMPORARY TABLE features(id INT(11) NOT NULL AUTO_INCREMENT, features_id INT NOT NULL, name VARCHAR(255),PRIMARY KEY (id));


    IF v1_feature_name != "assorteds" AND v1_feature_name != "genre" THEN

    SELECT (LENGTH(v_refinedFeature) - LENGTH(REPLACE(v_refinedFeature, ',', ''))) + 1
    INTO quantity;

    ELSE

    SELECT (LENGTH(v_refinedFeature) - LENGTH(REPLACE(v_refinedFeature, '%', ''))) + 1
    INTO quantity;

    END IF;

    IF v1_feature_name = "genre" THEN

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SET v_name = SUBSTRING_INDEX(SUBSTRING_INDEX(v_refinedFeature,"%",loopcounter),"%",-1);
	      SET v_name = CONCAT(v_name,"$",level_id);
              INSERT INTO features(name) values(LOWER(LTRIM(v_name)));

	      SET level_id = level_id + 1;
      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    ELSEIF v1_feature_name = "assorteds" THEN

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SET v_name = SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(v_refinedFeature,"%",loopcounter),"%",-1),"$",1);
              INSERT INTO features(name) values(LOWER(LTRIM(v_name)));
      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    ELSE

    carrier_loop: LOOP
      IF loopcounter <= quantity THEN
              SET v_name = SUBSTRING_INDEX(SUBSTRING_INDEX(v_refinedFeature,delimiter,loopcounter),delimiter,-1);
              INSERT INTO features(name) values(LOWER(LTRIM(v_name)));
      ELSE
              LEAVE carrier_loop;
      END IF;
      SET loopcounter = loopcounter + 1;
    END LOOP carrier_loop;

    END IF;

     END;

    SQL

  end

  def down

    execute "DROP PROCEDURE p_Split_feature_names"
    execute "DROP TEMPORARY TABLE IF EXISTS features"

  end
end

