

import UIKit

class SavedItemsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // for table view cell didselect
    var searchResult : MovieResult?
    
    
    
    var title1 = ""
    
    let sqlite = SQLiteManager()
    
    var values = [MovieResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sqlite.openDataBase()
        
        values.append(contentsOf: sqlite.readDatas())
        
        
        values = values.sorted { $0.title < $1.title }
        
        // remove bottom empty cells in table view
        tableView.tableFooterView = UIView()
        
        self.view.backgroundColor = UIColor(red: 89/255.0, green: 154/255.0, blue: 59/255.0, alpha: 1.0)
        
        // change bar button text color
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    
}


extension SavedItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if values.count == 0 {
            
            return 1
            
        } else {
            
            return values.count
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a UITableViewCell by hand to display the table rows.
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedItemCell", for: indexPath) as! SavedItemTableViewCell
        
        
        
        if values.count == 0 {
            
            cell.movieTitleLabel.text = "Nothing found"
            
            
        } else {
            
            cell.movieTitleLabel.text = values[indexPath.row].title
            
            
        }
        
        cell.selectionStyle = .none
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if values.count == 0 {
            return
        }
        
        
        
        let searchResult = values[indexPath.row]
        
        
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
