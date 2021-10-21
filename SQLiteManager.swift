
import Foundation

import SQLite3

final class SQLiteManager {
    
    
    static var database = SQLiteManager()
    
    var db: OpaquePointer?
    
    
    func openDataBase() {

        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("MoviesDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    func insertToTableHeartRate(imdbID: String, title: String, year: String, type: String) {
        
        openDataBase()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Movies (id Text PRIMARY KEY, title TEXT NOT NULL, year TEXT NOT NULL, type TEXT NOT NULL);", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
        if sqlite3_exec(db, "INSERT INTO Movies (id, title, year, type) VALUES ('\(imdbID)', '\(title)', '\(year)', '\(type)');", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
        
        
    }
    
    
    
    var movieResultInfos = [MovieResult]()
    
    //read data from Heart Rate database
    func readDatas() -> [MovieResult]{
         
        //first empty the list of users
        movieResultInfos.removeAll()
        
        //this is our select query
        let queryString = "SELECT * FROM Movies"
        
        //statement pointer
        var stmt:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //let id = sqlite3_column_int(stmt, 0)
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let year = String(cString: sqlite3_column_text(stmt, 2))
            let type = String(cString: sqlite3_column_text(stmt, 3))
            
            
            //adding values to list
            movieResultInfos.append(MovieResult(title: title, year: year, type: type, imdbID: id))
            
        }
        return movieResultInfos
    }
    
    
}
