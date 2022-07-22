//
//  DeviceState+CoreDataProperties.swift
//  Test Two Collection Views
//
//  Created by Developer Skromanglobal on 22/07/22.
//
//

import Foundation
import CoreData


extension DeviceState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceState> {
        return NSFetchRequest<DeviceState>(entityName: "DeviceState")
    }

    @NSManaged public var deviceUid: String?
    @NSManaged public var unique_id: String?
    @NSManaged public var modelNo: String?
    @NSManaged public var deviceType: String?
    @NSManaged public var dest_button: String?
    @NSManaged public var config_dim: String?
    @NSManaged public var config_buttons: String?
    @NSManaged public var master: String?
    @NSManaged public var l_state: String?
    @NSManaged public var l_speed: String?
    @NSManaged public var f_state: String?
    @NSManaged public var f_speed: String?

}

extension DeviceState : Identifiable {

}
