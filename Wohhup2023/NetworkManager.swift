//
//  NetworkManager.swift
//  Wohhup2023
//
//  Created by William Kendrick on 6/7/23.
//

import Foundation
import SwiftUI
import UIKit
import Network
import CoreData

class NetworkManager {
    let session = URLSession.shared
    static let shared = NetworkManager()
    let monitor = NWPathMonitor()

    func initialise() {
        monitor.pathUpdateHandler = { path in
            // Handle network path update here
            self.handleNetworkPath(path)
        }
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        monitor.start(queue: queue)
    }
    
    


     func handleNetworkPath(_ path: NWPath) {
        if path.status == .satisfied {
            // Network is reachable
            // send data to server via an API
            
            print("path status is satisfied") // test if network is detected.
            
            DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
            let predicate = NSPredicate(format: "synchronised == false")
            let managedContext = appDelegate.persistentContainer.viewContext
            fetchRequest.predicate = predicate
            do {
                // replace url with actual URL !!!
                guard let url = URL(string: "https://main.d2tx8mrw7p4gq8.amplifyapp.com/") else {
                    print("Invalid URL")
                    return
                }

                var request = URLRequest(url: url)
                request.httpMethod = "POST" // set the appropriate HTTP method (e.g., GET, POST, PUT, DELETE)
                // Set any additional headers or request parameters as needed
                
                let fetchedResults = try managedContext.fetch(fetchRequest)
                for Project in fetchedResults {
                    if let name = Project.name {
                        print(name)
                        request.httpBody = name.data(using: .utf8)
                        print("name sent to url")
                    }
                    if let id = Project.id {
                        print(id)
                        request.httpBody = id.data(using: .utf8)
                        print("id sent to url")
                    }
                    if let address = Project.address {
                        print(address)
                        request.httpBody = address.data(using: .utf8)
                        print("address sent to url")
                    }
                    if let manager = Project.manager {
                        print(manager)
                        request.httpBody = manager.data(using: .utf8)
                        print("manager sent to url")
                    }
                    
                    let session = URLSession.shared
                    let task = session.dataTask(with: request) { (data, response, error) in
                        // Process the response or handle any errors
                        if let error = error {
                            print(error)
                            return
                        }

                        guard let data = data else {
                            return
                        }

                        // Parse and process the response data
                    }
                    Project.setValue(true, forKey: "synchronised")

                    task.resume()
                    // Access other properties as needed
                }
            }
            catch {
                // Handle the fetch error
            }
            
            }
        }
            
        else {
            print("Network not connected") //test if network is connecting.
        }
    }
}


