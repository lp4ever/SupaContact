//
//  ContactModel.swift
//  SupaContact
//
//  Created by Adrian Lodge on 8/19/15.
//  Copyright (c) 2015 Supatone Innovation. All rights reserved.
//

import Foundation
import CoreData

@objc(ContactModel)

class ContactModel: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var company: String
    @NSManaged var phone: String
    @NSManaged var email: String
    @NSManaged var date: String
    @NSManaged var response: Bool
    @NSManaged var percent: Float
    @NSManaged var interested: String
    @NSManaged var other: String

}
