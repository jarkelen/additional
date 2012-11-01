class AddType2 < ActiveRecord::Migration
   def up
     add_column :relations, :relation_type, :string
     end

     def down
       remove_column :relations, :relation_type
  end
end
