//
//  SwipeTVC.swift
//  OneMomForAll
//
//  Created by K1 Park on 3/2/20.
//  Copyright © 2020 K1 Park. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTVC: UITableViewController, SwipeTableViewCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfiguration()
    }
    // DashboardVC can't inherit this class because it's UIVC not UITVC.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // IMPORTANT - If downcasted to SwipeTableViewCell, Go to story board to assign the cell to this class and module also. Otherwise, app crashes.
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusingCell, for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        return cell
    }
    
    func viewConfiguration() {
//        tableView.backgroundColor = UIColor.clear
        tableView.backgroundColor = UIColor(hexString: K.C.green)
        tableView.rowHeight = 80
    }

    //MARK: - SwipeCellKit pod
    // Lecture 286
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion            
            self.updateModel(at: indexPath)
        }
        // customize the action appearance
        if #available(iOS 13.0, *) {
            deleteAction.image = UIImage(systemName: "trash.fill")
        } else {
            deleteAction.image = UIImage(named: "Trash Icon")
        }
        
        return [deleteAction]
    }
    
    // This method is for expansion style. e.g. swipe further to delete.
    //     https://github.com/SwipeCellKit/SwipeCellKit
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    // Lecture 287 - deleting process for dynamic purpose.
    func updateModel(at indexPath: IndexPath) {
        // This method will be over ridden by child controllers.
        // Anything here will be ignored <#UNLESS#> override method specifically <#CALLS#> this function.
        // e.g. super.updateModel(at: indexPath)
    }
}
