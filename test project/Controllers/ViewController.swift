
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblPageNumber: UILabel!
    
    
    @IBOutlet weak var footerView: UIView!
    
    var glURL = ""
    
    let customComponents = CustomComponents()
    
    
    let sqlite = SQLiteManager()
    
    var searchViewModel = SearchViewModel()
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        
        // empty the list for new search
        searchViewModel.searchResults = []
        
        let newURL = glURL + "page=\(searchViewModel.currentPage - 1)"
        
        DispatchQueue.global().async {
            
            self.searchViewModel.fetchMovies(url: newURL, identifier: "minus", lblPageNumber: self.lblPageNumber, tableView: self.tableView, btnPrevious: self.btnPrevious, btnNext: self.btnNext, view: self, completion: { _ in
                
                DispatchQueue.main.async {
                    self.customComponents.showLoadingDialog(view: self.view, show: false, alpha: 0.0)
                }
                
            })
            
        }
        
        
        if (searchViewModel.currentPage - 1) < searchViewModel.pageNumbers {
            btnNext.isHidden = false
            return
        }
        
        
        btnNext.isHidden = true
        
    }
    
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        
        // empty the list for new search
        searchViewModel.searchResults = []
        
        let newURL = glURL + "page=\(searchViewModel.currentPage + 1)"
        
        
        DispatchQueue.global().async {
            
            self.searchViewModel.fetchMovies(url: newURL, identifier: "plus", lblPageNumber: self.lblPageNumber, tableView: self.tableView, btnPrevious: self.btnPrevious, btnNext: self.btnNext, view: self, completion: { _ in
                
                DispatchQueue.main.async {
                    self.customComponents.showLoadingDialog(view: self.view, show: false, alpha: 0.0)
                }
                
            })
            
        }
        
        btnPrevious.isHidden = false
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPrevious.isHidden = true
        btnNext.isHidden = true
        lblPageNumber.isHidden = true
        
        // remove bottom empty cells in table view
        tableView.tableFooterView = UIView()
        
        
        footerView.isHidden = true
        
        self.view.backgroundColor = UIColor(red: 89/255.0, green: 154/255.0, blue: 59/255.0, alpha: 1.0)
        
    }
    
}


extension ViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            
             print("UISearchBar.text cleared!")
            
            self.searchViewModel.searchResults.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if searchBar.text == "" {
            //please type something
            let alert = UIAlertController(title: "Failed", message: "Please Type Something", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if searchBar.text != "" {
            footerView.isHidden = false
        }

        
        // empty the list for new search
        searchViewModel.searchResults = []
        btnPrevious.isHidden = true
        searchViewModel.currentPage = 0
        
        if let searchBarText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            
            glURL = "\(urlSearch)\(searchBarText)&"
            
            // print("glurl", glURL)
            
            DispatchQueue.global().async {
                
                self.searchViewModel.fetchMovies(url: self.glURL, identifier: "firsttime", lblPageNumber: self.lblPageNumber, tableView: self.tableView, btnPrevious: self.btnPrevious, btnNext: self.btnNext, view: self, completion: { _ in
                    
                    DispatchQueue.main.async {
                        self.customComponents.showLoadingDialog(view: self.view, show: false, alpha: 0.0)
                    }
                    
                })
                
            }
        }
        
        
        
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchViewModel.searchResults.count == 0 {
            
            return 1
            
        } else {
            
            return searchViewModel.searchResults.count - 1
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        // create a UITableViewCell by hand to display the table rows.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! MovieTitleTableViewCell
       
        
        
        if searchViewModel.searchResults.count == 0 {
            
            cell.movieTitleLabel!.text = "Please Type Something in Search Bar"
            
            
        } else {
            
            let searchResult = searchViewModel.searchResults[indexPath.row]
            cell.movieTitleLabel!.text = searchResult.title
            
            
        }
        
        cell.selectionStyle = .none
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchViewModel.searchResults.count == 0 {
            return
        }
        
        if searchViewModel.searchResults.count == 1 && searchViewModel.searchResults[0].title == "Nothing Found" {
            return
        }
        
        let searchResult = searchViewModel.searchResults[indexPath.row]
        
        
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailViewController.title1 = searchResult.title
        detailViewController.type = searchResult.type
        detailViewController.imdbID = searchResult.imdbID
        detailViewController.year = searchResult.year
        
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
