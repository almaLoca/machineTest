//
//  PostDetailsVC.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import UIKit

class PostDetailsVC: UIViewController {

    @IBOutlet weak var table:UITableView!

    var commentsArray:[CommentsModelElement]?
    var post:PostModelElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        self.table.dataSource = self
        self.table.delegate = self
        self.table.register(UINib(nibName: Constants.Identifiers.commentsCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.commentsCell)
        self.table.register(UINib(nibName: Constants.Identifiers.postDetailsCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.postDetailsCell)
    }
}
//MARK:-  UITableView
extension PostDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (commentsArray?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellpostDetails = table.dequeueReusableCell(withIdentifier: Constants.Identifiers.postDetailsCell, for: indexPath) as! PostDetailsCell
        let cellComments = table.dequeueReusableCell(withIdentifier: Constants.Identifiers.commentsCell, for: indexPath) as! CommentsCell

        switch indexPath.row {
        case 0:
            cellpostDetails.titleLabel.text = self.post?.title
            cellpostDetails.descLabel.text = self.post?.body
            
            return cellpostDetails

        default:
            cellComments.emailLabel.text = commentsArray?[indexPath.row-1].email
            cellComments.nameLabel.text = commentsArray?[indexPath.row-1].name
            cellComments.commentLabel.text = commentsArray?[indexPath.row-1].body
            return cellComments
            
        }
        
    }
    
    
}
