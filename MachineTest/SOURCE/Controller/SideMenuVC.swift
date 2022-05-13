//
//  SideMenuVC.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import UIKit


class SideMenuVC: UIViewController {
    

    @IBOutlet weak var table:UITableView!

    let imageArray = ["house.fill","photo.on.rectangle.angled","rectangle.portrait.and.arrow.right"]
    let nameArray = ["Dashboard","Album","Logout"]
    let identifiers = [Constants.Identifiers.homeVc,Constants.Identifiers.albumVC,Constants.Identifiers.loginNav]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView(){
        self.table.dataSource = self
        self.table.delegate = self
        self.table.tableFooterView = UIView()
        self.table.register(UINib(nibName: Constants.Identifiers.sideMenuCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.sideMenuCell)
    }
    
    func logOut(){
        
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.Identifiers.loginNav)
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()

        }
        
    
}
extension SideMenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: Constants.Identifiers.sideMenuCell) as! SideMenuCell
        cell.iconImageView.image = UIImage(systemName: imageArray[indexPath.row])
        cell.titleLabel.text = nameArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            self.logOut()
        
    }else {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifiers[indexPath.row])
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    }
    
}
