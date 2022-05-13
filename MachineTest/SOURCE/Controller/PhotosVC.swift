//
//  PhotosVC.swift
//  MachineTest
//
//  Created by Reshma on 19/04/22.
//

import UIKit

class PhotosVC: UIViewController {
    //MARK:-  IBOutlet
    @IBOutlet weak var collectionView:UICollectionView!
    
    
    var selectedAlbum:AlbumModelElement?
    var photosArray:PhotosModel = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.getPhotosFromAlbum()
    }
}
//MARK:-  function
extension PhotosVC {
    
    func getPhotosFromAlbum(){
        
        APIManager.doRequest(API_CONSTANTS.BASE_SERVICES.GET_PHOTOS + String(selectedAlbum?.id ?? 0), method: .get, success: {(response) -> Void in
            let decoder = JSONDecoder()
            
            let jsonData = Data(response.description.utf8)
            do {
                let photos = try decoder.decode(PhotosModel.self, from: jsonData)
                print(photos)
                self.photosArray = photos
                self.collectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            
        }, failure: {(error) -> Void in
            self.showDefaultAlert(with: "oops!", message: "Something went wrong")})
        
    }
}

//MARK:-  UICollectionView
extension PhotosVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // In this function is the code you must implement to your code project if you want to change size of Collection view
        let width  = (view.frame.width)/3
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0.1
        UIView.animate(
            withDuration: 0.2,
            delay: 0.01 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.photoCollectionViewCell, for: indexPath ) as! PhotoCollectionViewCell
        cell.photo.imageFromServerURL((photosArray[indexPath.row].thumbnailUrl), placeHolder: UIImage(systemName: "photo"))
        return cell
    }
    
}
