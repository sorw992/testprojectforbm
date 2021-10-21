

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblImdbID: UILabel!
    
     
    
    
    var title1 = ""
    var year = ""
    var imdbID = ""
    var type = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 89/255.0, green: 154/255.0, blue: 59/255.0, alpha: 1.0)
        
        // change bar button text color
        self.navigationController?.navigationBar.tintColor = .black
        
        
        
        
        lblTitle.text = "Title: " + title1
        lblYear.text = "Year: " + year
        lblType.text = "Type: " + type
        lblImdbID.text = "Imdb ID: " + imdbID
        
        
        
    }
    
    
    
    
    
}
