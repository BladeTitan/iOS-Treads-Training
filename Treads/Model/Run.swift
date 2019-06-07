//
//  Run.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/07.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    @objc dynamic public private(set) var date = NSDate()
    public private(set) var locations = List<Location>()
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["date", "pace", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
    }
    
    static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        REALM_QUEUE.async {
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)
            do {
                let realm = try Realm(configuration: RealmConfig.runDataConfig)
                
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite()
                }
            }
            catch {
                debugPrint("Error adding Run to Realm!")
            }
        }
    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            let runs = realm.objects(Run.self).sorted(byKeyPath: "date", ascending: false)
            return runs
        }
        catch {
            debugPrint("Error querying Realm!")
            return nil
        }
    }
}
