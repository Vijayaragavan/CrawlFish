class CallProcedureToDeleteProductsFromPart1 < ActiveRecord::Migration
  def up

  execute "call p_Delete_products_from_Part1()" 
  end

  def down
  end
end
