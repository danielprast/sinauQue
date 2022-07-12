import SinauTableView
import UIKit

public class SinauQueApp {
  
  public init() {
  }
  
  public var rootController: UIViewController {
    return ChecklistTableController.createFromStoryboard()
  }
  
}


