//
//  ChecklistTableController.swift
//  Created by Daniel Prastiwa on 08/07/22.
//


import UIKit


final public class ChecklistTableController: UITableViewController {
  
  public static func createFromStoryboard() -> ChecklistTableController {
    let storyboard = UIStoryboard(name: "CheckListScene", bundle: Bundle.module)
    let controller = storyboard.instantiateViewController(withIdentifier: "ChecklistTableController")
    return controller as! ChecklistTableController
  }
  
  var items = [ChecklistItem]()
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    let item1 = ChecklistItem()
    item1.text = "Walk the dog"
    items.append(item1)
    
    let item2 = ChecklistItem()
    item2.text = "Brush my teeth"
    item2.checked = true
    items.append(item2)
    
    let item3 = ChecklistItem()
    item3.text = "Learn iOS development"
    item3.checked = true
    items.append(item3)
    
    let item4 = ChecklistItem()
    item4.text = "Soccer practice"
    items.append(item4)
    
    let item5 = ChecklistItem()
    item5.text = "Eat ice cream"
    items.append(item5)
    
    let item6 = ChecklistItem()
    item6.text = "What"
    items.append(item6)
    
    let item7 = ChecklistItem()
    item7.text = "The view"
    items.append(item7)
    
    let item8 = ChecklistItem()
    item8.text = "Hack"
    items.append(item8)
    
    let item9 = ChecklistItem()
    item9.text = "Android Development"
    items.append(item9)
    
  }
  
  fileprivate func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    if item.checked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
  
  // MARK: - TableView dataSource
  
  public override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return items.count
  }
  
  public override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChecklistItem",
      for: indexPath
    )
    
    let item = items[indexPath.row]
    
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
    configureCheckmark(for: cell, with: item)
    return cell
  }
  
  // MARK: - TableView Delegate
  
  public override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.checked.toggle()
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
