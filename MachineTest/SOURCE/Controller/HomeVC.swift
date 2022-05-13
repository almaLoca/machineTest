//
//  HomeVC.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import UIKit

class HomeVC: UIViewController {

    var loggedUser:UsersModelElement!
    var userPosts:[PostModelElement]?
    
    @IBOutlet weak var table:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setLeftMenuBarButton() // add side menu bar button
        self.getUserPosts()

    }
    //MARK:- function
    func setupView(){
        self.table.dataSource = self
        self.table.delegate = self
        self.table.register(UINib(nibName: Constants.Identifiers.postsCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.postsCell)
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.title = "Dashboard"
        self.table.rowHeight = UITableView.automaticDimension


    }
        
    
}

//MARK:- API
extension HomeVC {
    // get posts of logged in user
    func getUserPosts() {
        let userId = UserDefaults.standard.integer(forKey: Constants.DefaultKeys.userId)
    
        APIManager.doRequest(API_CONSTANTS.BASE_SERVICES.GET_USERS_POST + String(userId), method: .get, success: {(response) -> Void in
            let decoder = JSONDecoder()
            
            let jsonData = Data(response.description.utf8)
            do {
                let posts = try decoder.decode(PostModel.self, from: jsonData)
                print(posts)
                self.userPosts = posts
                self.table.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            
        }, failure: {(error) -> Void in
            self.showDefaultAlert(with: "oops!", message: "Something went wrong")})
        
    }
    
    // get post details user selected
    func getPostDetails(for id:Int) {
        
        APIManager.doRequest(API_CONSTANTS.BASE_SERVICES.GET_POST_COMMENTS + String(id), method: .get, success: {(response) -> Void in
            let decoder = JSONDecoder()
            
            let jsonData = Data(response.description.utf8)
            do {
                let comments = try decoder.decode(CommentsModel.self, from: jsonData)
                print(comments)
                let vc = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.postDetailsVC) as! PostDetailsVC
                vc.commentsArray = comments
                vc.post = self.userPosts?.first(where: {$0.id==id})
                self.navigationController?.pushViewController(vc, animated: true)
            } catch {
                print(error.localizedDescription)
            }
            
        }, failure: {(error) -> Void in
            self.showDefaultAlert(with: "oops!", message: "Something went wrong")})
    }
    
}
//MARK:-  UITableView

extension HomeVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: Constants.Identifiers.postsCell, for: indexPath) as! PostsCell
        cell.titleLabel.text = userPosts?[indexPath.row].title
        cell.descLabel.text = userPosts?[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getPostDetails(for: (userPosts?[indexPath.row].id)!)
    }
    
}

