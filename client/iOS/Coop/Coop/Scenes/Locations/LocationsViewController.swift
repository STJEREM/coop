//
//  LocationsViewController.swift
//  Coop
//
//  Created by Jeremy Stucki on 12/05/16.
//  Copyright © 2016 Jeremy Stucki. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, LocationsViewPresenterOutput, LocationsTableViewOutput {
    
    private var output: LocationsViewControllerOutput!
    private var locations: [Location]?

    private var tableView: UITableView!
    private var tableViewDelegate: UITableViewDelegate?
    private var tableViewDataSource: UITableViewDataSource?
    
    func setOutput(_ output: LocationsViewControllerOutput) {
        navigationItem.title = NSLocalizedString("Locations", comment: "")
        self.output = output
    }
    
    override func loadView() {
        super.loadView()
        
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings(_:)))
        navigationItem.rightBarButtonItem = settingsButton
        
        tableView = UITableView(frame: view.frame, style: .plain)
        view.addSubview(tableView)
        
        if locations == nil {
            output.fetchLocations()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.frame
    }
    
    // gets called by the retry button in the error view
    func fetchLocations() {
        output.fetchLocations()
    }
    
    func showLocations(_ locations: [Location]) {
        self.locations = locations

        tableViewDelegate = LocationsTableViewDelegate(locations: locations, output: self)
        tableViewDataSource = LocationsTableViewDataSource(locations: locations)
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableView.reloadData()
    }
    
    @objc func showSettings(_ sender : UITapGestureRecognizer? = nil) {
        let viewController = ViewControllerFactory.createSettingsViewController()
        present(viewController, animated: true, completion: nil)
    }
    
    func didSelectLocation(_ location: Location) {
        let viewController = ViewControllerFactory.createMenusViewController(location)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
