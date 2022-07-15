//
//  ChecklistTableController.swift
//  Created by Daniel Prastiwa on 08/07/22.
//


import UIKit


final public class ChecklistTableController: UITableViewController {
  
  static let storyboardName = "CheckListScene"
  
  public static func createFromStoryboard() -> ChecklistTableController {
    let storyboard = UIStoryboard(name: Self.storyboardName, bundle: Bundle.module)
    let controller = storyboard.instantiateViewController(withIdentifier: "ChecklistTableController")
    return controller as! ChecklistTableController
  }
  
  public static func createWithEmbeddedNavigationController() -> UINavigationController {
    let storyboard = UIStoryboard(name: Self.storyboardName, bundle: Bundle.module)
    let controller = storyboard.instantiateViewController(withIdentifier: "ChecklistNavController")
    return controller as! UINavigationController
  }
  
  var items = [ChecklistItem]()
  var didFinishAddingItem = false
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    setupDummyItems()
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if didFinishAddingItem {
      let lastRowIndex = items.count - 1
      let indexPath = IndexPath(row: lastRowIndex, section: 0)
      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
      didFinishAddingItem = false
    }
  }
  
  fileprivate func setup100Items() {
    for v in 1...100  {
      let item = ChecklistItem()
      item.text = "Item \(v)"
      item.checked = v % 2 == 1
      items.append(item)
    }
  }
  
  fileprivate func setupDummyItems() {
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
  }
  
  fileprivate func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let checklistLabel = cell.viewWithTag(1000) as! UILabel
    let label = cell.viewWithTag(1001) as! UILabel
    checklistLabel.text = item.text
    label.text = item.checked ? "√" : ""
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
    configureText(for: cell, with: item)
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
      configureText(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  public override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    items.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  public override func prepare(
    for segue: UIStoryboardSegue,
    sender: Any?
  ) {
    if segue.identifier == "AddItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let controller = segue.destination as! ItemDetailViewController
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }
  
}

extension ChecklistTableController: AddItemViewControllerDelegate {
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  ) {
    let newRowIndex = items.count
    items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    didFinishAddingItem = true
    
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem
  ) {
    if let index = items.firstIndex(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    navigationController?.popViewController(animated: true)
  }
  
}
