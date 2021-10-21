

import Foundation
import Alamofire
import SwiftyJSON

class SearchViewModel {
    
    var searchResults = [MovieResult]()
        
    
    var pageNumbers = 1
    var currentPage = 0
    
    // for table view cell didselect
    var searchResult : MovieResult?
    
    
    let sqlite = SQLiteManager()
    
    
    func fetchMovies(url: String, identifier: String, lblPageNumber: UILabel, tableView: UITableView, btnPrevious: UIButton, btnNext: UIButton, view: ViewController, completion: @escaping (Bool) -> Void ) {
        
        DispatchQueue.main.async {
            view.customComponents.showLoadingDialog(view: view.view, show: true, alpha: 0.0)
            
        }
        
        getWebservice(url: url, completion: { res, error in
            
            
            
            
            if let res = res {
                let search = res["Search"]
                
                let totalResults = res["totalResults"].doubleValue
                
                
                self.pageNumbers = Int((totalResults / 10).rounded(.awayFromZero))
                
                if totalResults < 10 {
                    view.footerView.isHidden = true
                }
                
                
                // hide footer pages view when no result found
                if search.count == 0 {
                    view.footerView.isHidden = true
                    
                    // create the alert
                    let alert = UIAlertController(title: "Failed", message: "Nothing Found", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    view.present(alert, animated: true, completion: nil)
                    
                }
                
                for i in 0...search.count {
                    
                    let searchResult = MovieResult(title: search[i]["Title"].stringValue, year: search[i]["Year"].stringValue, type: search[i]["Type"].stringValue, imdbID: search[i]["imdbID"].stringValue)
                    
                    self.searchResults.append(searchResult)
                    
                    if search[i]["imdbID"].stringValue != "" {
                        self.sqlite.insertToTableHeartRate(imdbID: search[i]["imdbID"].stringValue, title: search[i]["Title"].stringValue, year: search[i]["Year"].stringValue, type: search[i]["Type"].stringValue)
                    }
                    
                    
                    
                }
                
                
                if search.count == 0 {
                    
                    self.searchResults = []
                    
                    self.searchResults.append(MovieResult(title: "Nothing Found", year: "", type: "", imdbID: ""))
                }
                
                
                // The last statement in the method reloads the table view to make the new rows visible, which means you have to adapt the data source methods to read from this array as well.
                tableView.reloadData()
                
                
                
                
                if search.count != 0 &&  self.pageNumbers > 1 {
                    
                    
                    lblPageNumber.isHidden = false
                    
                    
                    if identifier == "plus" || identifier == "firsttime" {
                        
                        lblPageNumber.text = "Page " + String(self.currentPage + 1)
                        
                        
                        btnNext.isHidden = false
                        
                        
                        self.currentPage = self.currentPage + 1
                        
                        
                    }
                    
                    
                    if identifier == "minus" {
                        
                        lblPageNumber.text = "Page " + String(self.currentPage - 1)
                        
                        
                        
                        self.currentPage = self.currentPage - 1
                        
                        if self.currentPage == 1 {
                            
                            btnPrevious.isHidden = true
                            
                        }
                        
                    }
                    
                    
                    if self.pageNumbers == self.currentPage {
                        
                        btnNext.isHidden = true
                        
                        return
                    }
                    
                    
                }
                
                completion(true)
                
            } else {
                
                view.footerView.isHidden = true
                
                if let error = error {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Failed", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    view.present(alert, animated: true, completion: nil)
                    
                }
                
                completion(false)
                
            }

        })

    }
}


