
import UIKit

class MemberViewController: UIViewController {


    @IBOutlet weak var nameLbl: UITextField!
    var member: ConfigItem?

    @IBOutlet weak var editedData: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = member?.a
    }


    override func viewDidLayoutSubviews() {

    }
    
}

