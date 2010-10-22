# Helps to add/remove Postgres specific database constraints
module ActiveRecord
  module ConnectionAdapters
    module SchemaStatements
      def add_foreign_key_constraint(from_table, from_column, to_table)
        constraint_name = get_constraint_name('fk',from_table,to_table)
        
        sql = %{ALTER TABLE #{from_table}
                ADD CONSTRAINT #{constraint_name}
                FOREIGN KEY (#{from_column})
                REFERENCES #{to_table}(id);
                CREATE INDEX #{constraint_name}
                ON #{from_table}(#{from_column});} 
        execute sql
      end
      
      def drop_foreign_key_constraint(from_table, from_column, to_table)
        
        sql = %{ALTER TABLE #{from_table}
                DROP CONSTRAINT #{get_constraint_name('fk',from_table,to_table)}}
        execute sql
      end
      
    private
    
      def get_constraint_name(prefix, from_table, to_table)
        "#{prefix}_#{from_table}_#{to_table}"
      end
      
    end
  end
end
