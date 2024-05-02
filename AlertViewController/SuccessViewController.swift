//
//  SuccessViewController.swift
//  AlertViewController
//
//  Created by Palliboina on 01/05/24.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var successImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        successImage.layer.cornerRadius = 50
    
    }
    
    @IBAction func `continue`(_ sender: UIButton) {
        performSegue(withIdentifier: "showHome", sender: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
