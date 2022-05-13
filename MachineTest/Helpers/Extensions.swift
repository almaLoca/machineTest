//
//  Extensions.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import Foundation
import UIKit
import SideMenu


extension UIViewController {
    
    //MARK:- ALERT
    func showDefaultAlert(with title:String?,message:String?){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Navigation
    func pushTo(vc:String){
        let vc = storyboard?.instantiateViewController(identifier: vc)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func present(vc:String){
        let vc = self.storyboard?.instantiateViewController(identifier: vc)
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    
    //MARK:- Side Menu
    func setLeftMenuBarButton(){
        self.addLeftBarButton(action: #selector(self.setSideMenu))
    }
    func addLeftBarButton( action:Selector){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                                style: .plain,
                                                                target: self,
                                                                action: action)
    }
    @objc func setSideMenu(){
        let menu = storyboard!.instantiateViewController(withIdentifier: Constants.Identifiers.sideMenuVC) as! SideMenuNavigationController
        menu.statusBarEndAlpha = 0
        present(menu, animated: true, completion: nil)
    }

    
    
}
extension UIImageView {

    
        func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {

        self.image = nil
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                       
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
