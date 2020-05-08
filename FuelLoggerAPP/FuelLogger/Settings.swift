//
//  Settings.swift
//  App
//
//  Created by Admin on 22.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData

class Settings: UIViewController {

    var delete: Bool?
    var managedStops: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delete = false
        sortType.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "sortItems")
        // Do any additional setup after loading the view.
    }
    @IBAction func exportPressed(_ sender: Any) {
        // began .csv export
        print("exporting to CSV")
        saveAndExport(exportString: createExportString())
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        // show user a notification here
        confirmDelete()
    }
    
    @IBOutlet weak var sortType: UISegmentedControl!
    
    @IBAction func selected(_ sender: UISegmentedControl) {
        // get called when sort by changes
        UserDefaults.standard.set(sortType.selectedSegmentIndex, forKey: "sortItems")
        // 0 = Date, 1 = State
        performSegue(withIdentifier: "unwindFromSettings", sender: self)
    }
    
    func createExportString() -> String {
         var export : String = NSLocalizedString("loc, time, gal, extra \n", comment: "")
         for stop in managedStops {
             
             let loc = stop.value(forKey: "location") ?? ""
             let time = stop.value(forKey: "time") ?? ""
             let gal = stop.value(forKey: "gallons") ?? ""
             let extra = stop.value(forKey: "extra") ?? ""
             
             export += "\(loc)" + "," + "\(time)" + "," + "\(gal)" + "," + "\(extra)" + "\n"
         }
         return export
     }
     
    func saveAndExport(exportString: String) {
         let exportFilePath = NSTemporaryDirectory() + "export.csv"
         let exportFileURL = NSURL(fileURLWithPath: exportFilePath)
        FileManager.default.createFile(atPath: exportFilePath, contents: NSData() as Data, attributes: nil)
         var fileHandleError: NSError? = nil
         var fileHandle: FileHandle? = nil
         do {
            fileHandle = try FileHandle(forWritingTo: exportFileURL as URL)
         } catch {
             print("Error with fileHandle")
         }
         
         if fileHandle != nil {
             fileHandle!.seekToEndOfFile()
             let csvData = exportString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            fileHandle!.write(csvData!)
             
             fileHandle!.closeFile()
             
             let firstActivityItem = NSURL(fileURLWithPath: exportFilePath)
             let activityViewController : UIActivityViewController = UIActivityViewController(
                 activityItems: [firstActivityItem], applicationActivities: nil)
             
             activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                 UIActivity.ActivityType.postToFlickr,
                 UIActivity.ActivityType.postToVimeo,
                 UIActivity.ActivityType.postToTencentWeibo
             ]
             
             self.present(activityViewController, animated: true, completion: nil)
         }
     }
    
    func confirmDelete() {
        // this shows a notification to allow the user to confirm deletion
        let alert = UIAlertController(title: "Delete all Stop Data?",
                                          message: "This action cannot be undone. We recommend you export data first.", preferredStyle: .alert)
            let goAction = UIAlertAction(title: "Delete", style: .default,
                handler: { (action) in
                self.delete = true
                // if user clicks yes then delete data and go back to home view
                self.performSegue(withIdentifier: "unwindFromSettings", sender: self)
            })
            let stopAction = UIAlertAction(title: "Cancel", style:
                .destructive,
                handler: { (action) in
            })
            alert.addAction(goAction)
            alert.preferredAction = goAction // only affects .alert style
            alert.addAction(stopAction)
            self.present(alert, animated: true, completion: nil)
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
