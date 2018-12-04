//
//  Client+CoreDataProperties.swift
//  MinhaSearchBarMinhaVida
//
//  Created by Lucas Pinheiro Almeida on 04/12/2018.
//  Copyright © 2018 Lucas Pinheiro Almeida. All rights reserved.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var name: String?
    @NSManaged public var fone: String?

}
