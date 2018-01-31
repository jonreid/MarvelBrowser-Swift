//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

import UIKit

// swiftlint:disable trailing_closure

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = FetchCharactersMarvelService(session: URLSession.shared, authParametersGenerator: {
            return MarvelAuthentication().urlParameters()
        })
        let requestModel = FetchCharactersRequestModel(namePrefix: "Spider", pageSize: 1, offset: 0)
        service.fetchCharacters(requestModel: requestModel, networkRequest: NetworkRequest())
    }

}
