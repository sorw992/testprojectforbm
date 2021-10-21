
import Foundation
import UIKit


final class CustomComponents {
    
    static var customComponents = CustomComponents()
    
    //declaring activity indicator
    let ActivityIndicatorBackground = UILabel()
    //let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let activityIndicator = UIActivityIndicatorView()
    let label = UILabel()
    //view1 for background with alpha for alert
    let view1 = UIView()
    
    func showLoadingDialog(view: UIView, show: Bool, alpha: CGFloat){
        
        
        if show == true {
            
            view.addSubview(view1)
            
            view1.translatesAutoresizingMaskIntoConstraints = false
            
            
            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            view1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            view1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            view1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            
            view.addSubview(ActivityIndicatorBackground)
            
            view1.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: alpha)
            
            ActivityIndicatorBackground.isHidden = false
            activityIndicator.isHidden = false
            activityIndicator.color = .black
            label.isHidden = false
            
            ActivityIndicatorBackground.backgroundColor = .white
            ActivityIndicatorBackground.translatesAutoresizingMaskIntoConstraints = false
            ActivityIndicatorBackground.heightAnchor.constraint(equalToConstant: 131).isActive = true
            ActivityIndicatorBackground.widthAnchor.constraint(equalToConstant: 208).isActive = true
            ActivityIndicatorBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            ActivityIndicatorBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            ActivityIndicatorBackground.layer.masksToBounds = true
            ActivityIndicatorBackground.layer.cornerRadius = 4
            
            
            ActivityIndicatorBackground.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Please Wait"
            label.textAlignment = .center
            label.textColor = .black
            label.font = label.font.withSize(14)
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            //label.widthAnchor.constraint(equalToConstant: 180).isActive = true
            label.topAnchor.constraint(equalTo: ActivityIndicatorBackground.topAnchor, constant: 8).isActive = true
            label.leftAnchor.constraint(equalTo: ActivityIndicatorBackground.leftAnchor, constant: 6).isActive = true
            label.rightAnchor.constraint(equalTo: ActivityIndicatorBackground.rightAnchor, constant: -6).isActive = true
            label.backgroundColor = UIColor(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 0.0)
            
            ActivityIndicatorBackground.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.startAnimating()
            activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
            activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: ActivityIndicatorBackground.centerXAnchor).isActive = true
            activityIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16).isActive = true
            
            
        } else {
            
            view1.removeFromSuperview()
            view1.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: alpha)
            
            ActivityIndicatorBackground.isHidden = true
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            label.isHidden = true
            
        }
        
        
    }
    
}

