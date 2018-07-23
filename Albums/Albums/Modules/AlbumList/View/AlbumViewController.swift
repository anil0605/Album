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
    @IBOutlet weak var activityIndicatorView: UIView!

    var presenter: AlbumPresenter?

    private var footerHeight: CGFloat = 0

    var isFetchingData = false
    var isFullScreenLayout = false
    
    var gridLayout: UICollectionViewFlowLayout = GridLayout()
    var tabularLayout: UICollectionViewFlowLayout = TabularLayout()

    var dataSource = [AlbumModel]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
        presenter?.fetchAlbumData()
    }
    
    override func didReceiveMemoryWarning() {
    }
    
    private func setup(){
        collectionView.isPagingEnabled = isFullScreenLayout
        self.collectionView.collectionViewLayout = gridLayout
    }
    
    private func displayAlertMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func registerNib(){
        collectionView.register(UINib(nibName: PhotoFooterView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoFooterView.className)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()

        let offset = collectionView.contentOffset;
        let width  = collectionView.bounds.size.width;
        let index     = round(offset.x / width);
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        collectionView.setContentOffset(newOffset, animated: false)
 
        coordinator.animate(alongsideTransition: { (context) in
            collectionView.reloadData()
        }, completion: nil)
    }
}

extension AlbumViewController: UICollectionViewDelegate {
    private func getNewLayout(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewFlowLayout {
        let layout = isFullScreenLayout ?  gridLayout : tabularLayout
        let offsetPoint = CGPoint(x: 0.0, y: collectionView.frame.size.height*CGFloat(indexPath.row))
        layout.targetContentOffset(forProposedContentOffset: offsetPoint)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // To set up the new layout
        let layout = getNewLayout(collectionView, indexPath)
        collectionView.isPagingEnabled = !isFullScreenLayout

        // Animate cell as per layout
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell{
            isFullScreenLayout ?  cell.makeSmall() : cell.makeFull()
        }

        // To animate the collection view from completely invisible to visible in 0.5 seconds
        collectionView.fadeOut(duration: 0.0)
        collectionView.fadeIn(duration: 0.5)
        
        // To change layout the collection view
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
 
        isFullScreenLayout = !isFullScreenLayout
        
        // To reload the cell with new sizes now
        collectionView.reloadData()

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
        cell.setPhotoCellWith(model: dataSource[indexPath.row], showPhotoDescription: isFullScreenLayout)
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
    
    //Start the pagingation when 98% of the screen has been viewed
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        let threshold : CGFloat = scrollView.frame.size.height * 0.02
        let totalContentScrollview : CGFloat = scrollView.contentSize.height
        let breachingPoint = totalContentScrollview - threshold
        let currentOffset = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if currentOffset > breachingPoint ,breachingPoint > 0, isFetchingData == false  {
            isFetchingData = true
            presenter?.fetchAlbumData()
            collectionView.reloadData()
            footerHeight = 50
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
         return CGSize(width: collectionView.bounds.size.width, height: footerHeight)
    }
}


extension AlbumViewController : AlbumViewProtocol {
    // To display alert message when the connection loaded data
    func showAlertMessage(_ message: String) {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.displayAlertMessage(message)
            
            // Reload collection view to limit the footer height
            self.footerHeight = 0
            self.collectionView.reloadData()
        }
        
        // To stop subsequent pagination call as reload collectionview will change content size and leads to calling network calls again
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isFetchingData = false
        }
    }

    func showPhotos(list: [AlbumModel]) {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.dataSource = list
            self.isFetchingData = false
        }
    }
}
