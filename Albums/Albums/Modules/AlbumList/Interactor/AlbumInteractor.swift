//
//  AlbumWireFrame.swift
//  YasMobileSDK
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//


import UIKit

// MARK: AlbumInteractor
/**
 *  AlbumInteractor is an interacter class of VIPER architecture
 *  It will fetch the tour objects from the configuration and pass them to the presentor classes of welcome tour
 */
class AlbumInteractor: AlbumTourInteracterInputProtocol {
    
    weak var presenter: AlbumPresenterOutputProtocol?
    
    var dataOperation = DataOperation()
    var pageCounter = 1
    private let baseUrl = "https://api.unsplash.com/photos/"
    private let clientId = "b590310bd7b4a24939406f852e42dd9b966fa54e261dd5fdd9ce106b8dccad3a"
    private let dataFormat = "json"
    private let fileName = "UserList"

    func setDataOperationRequest() {
        dataOperation.baseURL = baseUrl
        
        dataOperation.queryParam["page"] = "\(pageCounter)"
        dataOperation.queryParam["client_id"] = "\(clientId)"
        
    }
    
    func fetchAlbumData() {
        
        if let data = self.retrieveLocalJsonDataFromFile(fileName), let photoList = parseData(data) {
            self.presenter?.retrievedPhotoList(data: photoList)
        }else{
            setDataOperationRequest()
            dataOperation.makeNetworkCallWith { [unowned self] (data, error) in
                guard let _ = error else {
                    self.presenter?.retrievedPhotoList(data: self.parseData(data)!)
                    self.pageCounter += 1
                    return
                }
               
            }
        }
        
    }
    
    private func retrieveLocalJsonDataFromFile(_ filename: String) -> Data?{
        guard let path = Bundle.main.path(forResource: filename, ofType: dataFormat) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            //print("Error in reading local Data")
            return nil
        }
    }
    
    private func parseData(_ data: Data) -> [AlbumModel]?{
        do {
            let jsonDecoder = JSONDecoder()
            let list = try jsonDecoder.decode([AlbumModel].self, from: data)
            return list
        }
        catch  {
            //print("error trying to convert data to JSON")
            return nil
        }
    }
}
