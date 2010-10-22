# Helps to add/remove Postgres specific database constraints
module ActiveRecord
  module ConnectionAdapters
    module SchemaStatements
      def add_foreign_key_constraint(from_table, from_column, to_table)
        constraint_name = "fk_#{from_table}_#{to_table}"
        
        sql = %{ALTER TABLE #{from_table}
                ADD CONSTRAINT #{constraint_name}
                FOREIGN KEY (#{from_column})
                REFERENCES #{to_table}(id)}
        execute sql
      end
      
#      def drop_foreign_key_constraint(from_table, from_column, to_table)
#        constraint_name = "fk_#{from_table}_#{to_table}"
#        
#        execute %{ALTER TABLE #{from_table}
#                  DROP CONSTRAINT #{constraint_name}}
#      end
    end
  end
end
