//
//  AlbumInteractor.swift
//  Module/Album
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//


import UIKit

// MARK: AlbumInteractor
/**
 *  AlbumInteractor is an interacter class of VIPER architecture
 *  It will fetch album data from the unsupply api and pass the data to the presenter
 */
class AlbumInteractor: AlbumTourInteracterInputProtocol {
    
    weak var presenter: AlbumPresenterOutputProtocol?
    
    var dataOperation = DataOperation()
    var pageCounter = 1
    private let baseUrl = "https://api.unsplash.com/photos/"
    private let clientId = "b590310bd7b4a24939406f852e42dd9b966fa54e261dd5fdd9ce106b8dccad3a"
    private let dataFormat = "json"
    private let fileName = "UserList"
    
    
    var urlDownloadingInProgress = [String]()

    // Set the data opertion object ( network request)
    func setDataOperationRequest() {
        dataOperation.baseURL = baseUrl
        
        dataOperation.queryParam["page"] = "\(pageCounter)"
        dataOperation.queryParam["client_id"] = "\(clientId)"
    }
    
    private func getStubFileName() -> String {
        let stubFile = fileName + "_" + "\(pageCounter)"
        return stubFile
    }
    
    func fetchAlbumData() {
        // To fetch the local data if present used in AlbumStub scheme
        if let data = self.retrieveLocalJsonDataFromFile(getStubFileName()), let photoList = parseData(data) {
            self.pageCounter += 1
            self.presenter?.retrievedPhotoList(data: photoList)
        }else{
        // It creates the network connection
            setDataOperationRequest()
            dataOperation.makeNetworkCallWith { [unowned self] (data, error) in
                guard let responseData = data, let albums = self.parseData(responseData) else {
                    self.presenter?.showAlertMessage()
                    return
                }
                self.pageCounter += 1
                self.presenter?.retrievedPhotoList(data: albums)
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
            return nil
        }
    }
}
