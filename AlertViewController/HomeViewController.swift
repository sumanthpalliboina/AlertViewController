//
//  HomeViewController.swift
//  AlertViewController
//
//  Created by Palliboina on 01/05/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var comment: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func send(_ sender: UIButton) {
        if comment.text == "" {
            showAlert()
        }else{
            comment.text = ""
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Empty comment is not sendable", message: "Please Provide Comment", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func openSheet(_ sender: UIButton) {
        let alert = UIAlertController(title: "Emails", message: "What do to with the email you want ?", preferredStyle: .actionSheet)
        
        
        //in ipads, action sheet display as poover, so we need to mention the directionm of arrow and sourceView to point and part of view to point
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
            popover.permittedArrowDirections = .up
        }
        
        let moveToBin = UIAlertAction(title: "Move To Bin", style: .default, handler: nil)
        alert.addAction(moveToBin)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
        alert.addAction(delete)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)

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
