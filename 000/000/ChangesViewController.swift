import UIKit

class ChangesViewController: UIViewController {
    
    @IBOutlet weak var addNew: UITextField!
    var users = [Person]()
    let database = DatabaseHandler()
    //    refrence to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Person]?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPeople()
    }

    
    func fetchPeople() {
        //        fetch the data from core data to display in the tableView
        do {
            self.items = try context.fetch(Person.fetchRequest())
            
            DispatchQueue.main.async {
                self.reloadInputViews()
            }
        } catch {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let results = database.fetch(Person.self)
        print(results.map {$0.name1 })
    }
    @IBAction func saveData(_ sender: UIButton) {
        
        guard var user = database.add(Person.self) else { return }
        guard let name1 = addNew.text else { return }
        
        user.name1 = name1
        database.save()
    
    }
}
