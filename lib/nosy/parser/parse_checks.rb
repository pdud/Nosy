module Nosy

  class Parser

    module ParseChecks

      def has_messages_table( database )
        begin
          database.execute2( "select rowid, date, address, text, flags, is_madrid, madrid_flags, madrid_handle from message" )
        rescue SQLite3::SQLException
          return false
        rescue SQLite3::NotADatabaseException
          return false
        end
      end

      def is_iphone_database( results )
        if ( results[0][0] == "ROWID" && results[0][1] == "date" && results[0][2] == "address" && results[0][3] == "text" && results[0][4] == "flags" && results[0][5] == "is_madrid" && results[0][6] == "madrid_flags" && results[0][7] == "madrid_handle") && results.count > 1
          return true
        else
          return false
        end
      end
    
    end
  end

end