import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
     remapKeys()
  }

  func remapKeys() {
    let aKey: UInt64 = 0x700000004
    let bKey: UInt64 = 0x700000005
    
    let map: [[String: UInt64]] = [
      [kIOHIDKeyboardModifierMappingSrcKey:aKey,
       kIOHIDKeyboardModifierMappingDstKey:bKey],
      [kIOHIDKeyboardModifierMappingSrcKey:bKey,
       kIOHIDKeyboardModifierMappingDstKey:aKey],
    ]
    
    let system = IOHIDEventSystemClientCreateSimpleClient(kCFAllocatorDefault)
    let services = IOHIDEventSystemClientCopyServices(system)
    
    for service in services as! [IOHIDServiceClient] {
      if((IOHIDServiceClientConformsTo(service, UInt32((kHIDPage_GenericDesktop)), UInt32(kHIDUsage_GD_Keyboard))) != 0) {
        IOHIDServiceClientSetProperty(service, kIOHIDUserKeyUsageMapKey as CFString, map as CFArray)
      }
    }
  }
}

