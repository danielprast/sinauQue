//
//  AddItemViewController.swift
//  
//
//  Created by Daniel Prastiwa on 14/07/22.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  )
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishEditing item: ChecklistItem
  )
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!
  
  weak var delegate: AddItemViewControllerDelegate?
  var itemToEdit: ChecklistItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    handleEditingItem()
    navigationItem.largeTitleDisplayMode = .never
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func tableView(
    _ tableView: UITableView,
    willSelectRowAt indexPath: IndexPath
  ) -> IndexPath? {
    return nil
  }
  
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(
      in: stringRange,
      with: string
    )
    doneBarButton.isEnabled = !newText.isEmpty
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneBarButton.isEnabled = false
    return true
  }
  
  fileprivate func handleEditingItem() {
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.isEnabled = true
    }
  }
  
  @IBAction func cancel() {
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    print("Contents text field: \(textField.text!)")
    
    if let itemToEdit = itemToEdit {
      itemToEdit.text = textField.text!
      delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
      return
    }
    
    let item = ChecklistItem()
    item.text = textField.text!
    delegate?.itemDetailViewController(self, didFinishAdding: item)
  }
  
}
