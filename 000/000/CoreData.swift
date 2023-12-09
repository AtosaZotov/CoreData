import CoreData
import Foundation

extension Person {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
        
    }
    
    @NSManaged public var name: String?
}
