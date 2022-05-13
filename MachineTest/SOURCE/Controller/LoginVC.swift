//
//  LoginVC.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import UIKit

class LoginVC: UIViewController {
    //MARK:-  IBOutlet 
    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var userIdText:UITextField!

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK:-  button Action
    @IBAction func loginAction(_ sender:Any){
     
        loginRequest()
    }

    
}

//MARK:- API
extension LoginVC{
    func loginRequest(){
        APIManager.doRequest(API_CONSTANTS.BASE_SERVICES.USERS, method: .get, success: {(response) -> Void in
            let decoder = JSONDecoder()
           
            let jsonData = Data(response.description.utf8)
            do {
                let people = try decoder.decode(UsersModel.self, from: jsonData)
                print(people)
                let loggedUser = people.first(where: {$0.username==self.userIdText.text ?? ""})

                            if let loggedUser = loggedUser {
                                  let vc = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.homeVc) as! HomeVC
                                 vc.loggedUser = loggedUser
                                 UserDefaults.standard.set(loggedUser.id, forKey: Constants.DefaultKeys.userId)
                                 UserDefaults.standard.set(loggedUser.name, forKey: Constants.DefaultKeys.UserName)
                                 self.navigationController?.pushViewController(vc, animated: true)

                             }else{
                                  self.showDefaultAlert(with: "oops!", message: "User not found")
                             }
            } catch {
                print(error.localizedDescription)
            }
           
            
        }, failure: {(error) -> Void in
            self.showDefaultAlert(with: "Something went wrong", message: "please try again later")
        })
        
    
    }
    
}
