import UIKit
import Foundation
import CoreData

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var Members = [ConfigItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "showDetails")
//        tableView.tableFooterView = UIView(frame: .zero)
        
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        insertNewTitle()
        
    }
    
    
    func insertNewTitle() {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil) 
        let member = Members[indexPath.row]
        cell.textLabel?.text = member.a.capitalized
        cell.accessoryType = member.i == true ? .checkmark : .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MemberViewController {
            destination.member = Members[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            
//            delete the row
            Members.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }

    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://hamrahplus23.bankmellat.ir/mcpn/config")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if data != nil, error == nil {
                guard let data = data else {return}
                print(String(data: data, encoding: .utf8)!)
                print("\n\n")
                do {
                    let res = try JSONDecoder().decode([String].self, from: data)
                    print("response: \(res)")
                    print("response: \(res.count)")
                    
                    for jsonString in res {
                        //                        Convert each string back into data
                        print("\n\n \(jsonString.count) \n\n")
                        if let jsonData = jsonString.data(using: .utf8) {
                            //                            attemp to decode ConfigCardPaymentDTO
                            if let configCardPaymentDTO = try? JSONDecoder().decode(ConfigCardPaymentDTO.self, from: jsonData) {
                                //                                successfully decoded ConfigCardPaymentDTO
                                print(configCardPaymentDTO.configItems)
                                self.Members.append(contentsOf:configCardPaymentDTO.configItems)
                            }
                            //                        attempt to decode BnkListDTO
                            else if let bankListDTO = try?
                                        JSONDecoder().decode(BankListDTO.self, from: jsonData) {
                                //                            successfully decoded BankListDTO
                                print(bankListDTO)
                            }
                        }
                    }
                    //                self.Members
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                
                catch {
                    print(String(describing: error))
                    print("\n\nError\n\n")
                    print(error.localizedDescription)
                }
            } else {
                print("error in if")
                print(error!)
                print("\n\n")
                print(data!)
            }
        }.resume()
    }
}
  

