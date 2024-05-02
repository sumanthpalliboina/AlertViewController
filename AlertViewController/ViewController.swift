//
//  ViewController.swift
//  AlertViewController
//
//  Created by Palliboina on 01/05/24.
//

import UIKit

actor ItemData{   //actor keep waiting the tasks until it is freee to respond and process done by other task
    var name:String
    var count:Int
    
    init(name: String) {
        self.name = name
        self.count = 0
    }
    
    func changeName(newName:String){
        name = newName
        count += 1
    }
}

enum MyErrors:Error{
    case noData, NoImage
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signInTitle: UILabel!
    
    var thumbnail:String {
        get async {
            try? await Task.sleep(nanoseconds: 3*1000000000)
            return "myThumb"
        }
    }
    
    var item:ItemData!

    override func viewDidLoad() {
       item = ItemData(name: "Undefined")
       super.viewDidLoad()
       /*
        //app create task and apply to thread
        let task = Task(priority: .background){
            let imageName1 = await loadIamge(name: "sumanth") //3sec
            let imageName2 = await loadIamge(name: "sumanth") //3sec
            let imageName3 = await loadIamge(name: "sumanth") //3sec  -->total = 9sec
            print(imageName1,imageName2,imageName2)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: {timer in
            print("Time is Up")
            task.cancel()
        })
        
        */
        
        let current = Date()
        
        Task(priority: .background){
            do{
                await UpdateInterfaceTitle(name: "Hello, Welecome to our Community")
                
                //let imgName = await thumbnail  //this propert suspends task 3sec
                
                //concurrent processes
                async let msg1 = try await loadIamge(name: "potato")
                async let msg2 = try await loadIamge(name: "brijal")
                async let msg3 = try await loadIamge(name: "lady")
                
                let listMsg = try await "\(msg1) \(msg2) \(msg3)"
                print(listMsg)
                print("Date: \(Date().timeIntervalSince(current))")  //6sec -->3sec for async propert and 3sec for images load concurrently
            }catch MyErrors.NoImage {
                print("Image is not available")
            }
        }
    }
    
    func loadIamge(name:String) async throws -> String{
        //call asynchorous sleep methods, to ignore error thrown by sleep, we used try?
       /*
        try? await Task.sleep(nanoseconds: 3*1000000000)
        
        if !Task.isCancelled{
            return "Name: \(name)"
        }else{
            return "Task cancelled"
        }
        */
        
        let error = false
        let msg:String!
        
        if error {
            throw MyErrors.NoImage
        }else{
            
            let result = Task(priority: .background){() -> String in
                let size = await getMetaData()
                await item.changeName(newName: name)
                let count = await item.count
                return "\(name) \(count), "
            }
            
            msg = await result.value
        }
        return msg
    }
    
    func getMetaData() async -> Int {
        try? await Task.sleep(nanoseconds: 3*1000000000)
        return 50000
    }
    
   /*
    //execute whole method code in main thread
    @MainActor func UpdateInterfaceTitle(name:String) async{
        signInTitle.text = name
        let newTitle = signInTitle.text!
        print(newTitle)
    }
   */
    
    func UpdateInterfaceTitle(name:String) async{
        
        var newtitle:String
        
        ///execute in main thread
        await MainActor.run{
            signInTitle.text = name
        }
        
        ///execute in main thread
        newtitle = await MainActor.run{
            let newTitle = signInTitle.text
            return newTitle ?? ""
        }
        
        ///execute in current thread
        print(newtitle)
    }

    @IBAction func signIn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Login With Your Credentials", message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let login = UIAlertAction(title: "Login", style: .default, handler: { action in
            if let textFields = alert.textFields {
                let email = textFields[0].text
                let password = textFields[1].text
                
                if email == "sumanth@gmail.com" && password == "sum123" {
                    self.performSegue(withIdentifier: "showSuccess", sender: nil)
                }
            }
        })
        alert.addAction(login)
        
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "Enter yOUR eMail"
        })
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "Enter Your password"
            textField.isSecureTextEntry = true
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSuccess" {
            let controler = segue.destination as! SuccessViewController
            if let sheet = controler.sheetPresentationController{
                sheet.detents = [.medium()]
            }
        }
    }
    
}

