//
//  RealmConfig.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/07.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    static var runDataConfig: Realm.Configuration {
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
        let config = Realm.Configuration(
            fileURL: realmPath,
            readOnly: false,
            schemaVersion: REALM_SCHEMA_VERSION,
            migrationBlock: { (migration, oldSchemaVersion) in
                if(oldSchemaVersion < REALM_SCHEMA_VERSION) {
                    
                }
            },
            deleteRealmIfMigrationNeeded: false)
        
        return config
    }
}
