//
//  Recent+CoreDataProperties.swift
//  
//
//  Created by ThanhHai on 9/25/18.
//
//

import Foundation
import CoreData


extension Recent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recent> {
        return NSFetchRequest<Recent>(entityName: "Recent")
    }

    @NSManaged public var keyword: String?

}

extension Recent{
    static func insertKeyword(_ keyword: String) -> Recent? {
        
        Recent.deleteHave(keyword)
        
        let recent = NSEntityDescription.insertNewObject(forEntityName: "Recent", into: AppDelegate.managedObjectContext!) as! Recent
        recent.keyword = keyword
        
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch (let error){
            print(error)
            return nil
        }
        print("insert \(keyword) Successfull")
        return recent
    }
    
    static func getAllRecentKeyword() -> [Recent] {
        var result: [Recent] = []
        
        do {
            result = try AppDelegate.managedObjectContext?.fetch(Recent.fetchRequest()) as! [Recent]
            return result
        }catch {
            print("Fetch Data Error")
        }

        return result
    }
    
    static func deleteAll() -> Bool {
        let recents = Recent.getAllRecentKeyword()
        for recent in recents {
            AppDelegate.managedObjectContext?.delete(recent)
        }
        do {
            try AppDelegate.managedObjectContext?.save()
            return true
        } catch {
            print("delete all recent failed")
            return false
        }
    }
    
    static func deleteHave(_ keyword: String) -> Bool{
        let recents = Recent.getAllRecentKeyword()
        for recent in recents {
            if recent.keyword == keyword{
                AppDelegate.managedObjectContext?.delete(recent)
            }
        }
        do {
            try AppDelegate.managedObjectContext?.save()
            return true
        } catch {
            print("delete \(keyword) recent failed")
            return false
        }
    }
}
