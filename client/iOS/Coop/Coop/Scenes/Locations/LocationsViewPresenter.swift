//
//  LocationsViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsViewPresenter: LocationsViewInteractorOutput {
    
    fileprivate var output: LocationsViewPresenterOutput!
    fileprivate var loadingView = UIAlertController(title: NSLocalizedString("Fetching locations", comment: ""), message: nil, preferredStyle: .alert)
    fileprivate var errorView = UIAlertController(title: NSLocalizedString("Could not load locations", comment: ""), message: NSLocalizedString("Make sure that you are connected to the internet.", comment: ""), preferredStyle: .alert)

    init() {
        errorView.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .default, handler: { (action) in
            self.errorView.dismiss(animated: true, completion: nil)
            self.output.fetchLocations()
        }))
    }
    
    func setOutput(_ output: LocationsViewPresenterOutput) {
        self.output = output
    }
    
    func showLoading() {
        UIApplication.shared.delegate!.window!!.rootViewController?.present(loadingView, animated: true, completion: nil)
    }
    
    func hideLoading() {
        loadingView.dismiss(animated: true, completion: nil)
    }
    
    func showError() {
        if !loadingView.isBeingPresented {
            return hideLoading()
        }
        
        loadingView.dismiss(animated: true) { 
            UIApplication.shared.delegate!.window!!.rootViewController?.present(self.errorView, animated: true, completion: nil)
        }
    }
    
    func updateLocations(_ locations: [Location]) {
        output.showLocations(locations.sorted(by: { $0.getName() < $1.getName() }))
    }
}
