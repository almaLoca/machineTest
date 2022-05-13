//
//  AlbumVC.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import UIKit

class AlbumVC: UIViewController {
    //MARK:-  IBOutlet 
    @IBOutlet weak var collectionView:UICollectionView!
    
    var AlbumArray:AlbumModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Album"
        
        self.setupView()
        self.setLeftMenuBarButton() // add side menu bar button
        
    }
    //MARK:-  function
    func setupView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.getAlbumForUser()
        self.collectionView.register(UINib(nibName: Constants.Identifiers.albumCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Identifiers.albumCollectionViewCell)
        
    }
    
    
}

extension AlbumVC {
    
    func getAlbumForUser(){
        let userId = UserDefaults.standard.integer(forKey: Constants.DefaultKeys.userId)
        
        APIManager.doRequest(API_CONSTANTS.BASE_SERVICES.GET_ALBUM + String(userId), method: .get, success: {(response) -> Void in
            let decoder = JSONDecoder()
            
            let jsonData = Data(response.description.utf8)
            do {
                let albums = try decoder.decode(AlbumModel.self, from: jsonData)
                print(albums)
                self.AlbumArray = albums
                self.collectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            
        }, failure: {(error) -> Void in
            self.showDefaultAlert(with: "oops!", message: "Something went wrong")})
        
    }
    
    
}
//MARK:-  UICollectionView
extension AlbumVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/3, height: (collectionViewSize/5)+100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.AlbumArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.albumCollectionViewCell, for: indexPath) as! AlbumCollectionViewCell
        cell.titleLabel.text = AlbumArray?[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: Constants.Identifiers.photosVC) as! PhotosVC
        vc.selectedAlbum = AlbumArray?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
