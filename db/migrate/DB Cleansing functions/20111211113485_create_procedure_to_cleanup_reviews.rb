class CreateProcedureToCleanupReviews < ActiveRecord::Migration
  def up

 
	execute "DROP PROCEDURE IF EXISTS p_cleanup_reviews"

	execute <<-SQL
	CREATE PROCEDURE p_cleanup_reviews()
	BEGIN
	
		DECLARE v_DebugID VARCHAR(255) DEFAULT 'p_cleanup_reviews';

    		/*After declaring v_DebugID, the debug_on procedure is called which is insert a record in debug table */
	    	call debug.debug_on(v_DebugID);

		UPDATE books_reviews SET description = replace(description,'â€™','\'');
		UPDATE books_reviews SET description = replace(description,'â€¦','...');
		UPDATE books_reviews SET description = replace(description,'â€“','-');
		UPDATE books_reviews SET description = replace(description,'â€œ','\"');
		UPDATE books_reviews SET description = replace(description,'â€','\"');
		UPDATE books_reviews SET description = replace(description,'â€˜','\'');
		UPDATE books_reviews SET description = replace(description,'â€¢','-');
		UPDATE books_reviews SET description = replace(description,'â€¡','c');

		/* Insert a record in debug table for tracking the events */
		call debug.debug_insert(v_DebugID,'Replaced all special character with appropriate characters in books_reviews table');

		/*Turning off the debug insert*/
		call debug.debug_off(v_DebugID);

	END
	SQL  
  end

  def down
	execute "DROP PROCEDURE p_cleanup_reviews"
  end
end
