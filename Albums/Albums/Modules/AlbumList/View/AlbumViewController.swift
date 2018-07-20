//
//  AlbumWireFrame.swift
//  YasMobileSDK
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//


import UIKit

/**
 AlbumViewController shows the random photos data in collection view.
 */

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: AlbumPresenter?
    
    // MARK: - Properties
    private let sectionInsets = UIEdgeInsets(top: 8, left: 8 , bottom: 8, right: 8)
    private let itemsPerRow: CGFloat = 2
    private let footerHeight: CGFloat = 50

    var isFetchingData:Bool = false

    var dataSource = [AlbumModel]() {
        didSet{
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        presenter?.fetchAlbumData()
    }
    
    override func didReceiveMemoryWarning() {
    }
    
    func registerNib(){
        collectionView.register(UINib(nibName: PhotoFooterView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoFooterView.className)

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
}


extension AlbumViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
 
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.className, for: indexPath) as! PhotoCell
        cell.setPhotoCellWith(model: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            let photoFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotoFooterView.className, for: indexPath) as! PhotoFooterView
            return photoFooterView
        }else{
           return UICollectionReusableView()
        }
    }
    
}

extension AlbumViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // New code
        
        let paddingSpace = sectionInsets.left * (itemsPerRow )
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = (availableWidth - paddingSpace) / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    
    //Start the pagingation when 90% of the screen has been viewed
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold : CGFloat = view.frame.size.height * 0.1
        let contentOffset : CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        let contentHeight : CGFloat = scrollView.contentSize.height
        let diffHeight = contentHeight - contentOffset
        
        if contentHeight > 0 , diffHeight < threshold, isFetchingData == false  {
            isFetchingData = true
            collectionView.reloadData()
            self.presenter?.fetchAlbumData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isFetchingData {
            return CGSize(width: collectionView.bounds.size.width, height: footerHeight)
        }
        return CGSize.zero

    }
}


extension AlbumViewController : AlbumViewProtocol {
    
    func showPhotos(list: [AlbumModel]) {
        DispatchQueue.main.async {
            self.dataSource = list
            self.isFetchingData = false
        }
    }

}
