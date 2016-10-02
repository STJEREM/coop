//
//  MenuDetailViewPresenter.swift
//  Coop
//
//  Created by Jeremy Stucki on 14/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import Foundation

class MenuDetailViewPresenter: MenuDetailViewInteractorOutput {

    fileprivate var output: MenuDetailViewPresenterOutput!
    
    func setOutput(_ output: MenuDetailViewPresenterOutput) {
        self.output = output
    }
    
}
