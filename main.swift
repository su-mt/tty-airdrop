import Foundation
import AppKit

guard CommandLine.arguments.count > 1 else {
    print("Usage: airdrop <file>")
    exit(1)
}

let filePath = CommandLine.arguments[1]
let fileURL = URL(fileURLWithPath: filePath)

guard FileManager.default.fileExists(atPath: filePath) else {
    print("No such file or directory: \(filePath)")
    exit(1)
}

class AirDropDelegate: NSObject, NSApplicationDelegate, NSSharingServiceDelegate {
    let fileURL: URL
    var wasShared = false

    init(fileURL: URL) {
        self.fileURL = fileURL
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let service = NSSharingService(named: .sendViaAirDrop) else {
            print("AirDrop is unavailable.")
            NSApp.terminate(nil)
            return
        }

        service.delegate = self
        service.perform(withItems: [fileURL])
        print("AirDrop transfer started. Follow instructions in the AirDrop window.")
    }

    func sharingService(_ sharingService: NSSharingService, didShareItems items: [Any]) {
        wasShared = true
        NSApp.terminate(nil)
    }

    func sharingService(_ sharingService: NSSharingService, didFailToShareItems items: [Any], error: Error) {
        print("Error: \(error.localizedDescription)")
        NSApp.terminate(nil)
    }

    func sharingServiceDidCancel(_ sharingService: NSSharingService) {
        NSApp.terminate(nil)
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.accessory) 

let delegate = AirDropDelegate(fileURL: fileURL)
app.delegate = delegate
app.run()
