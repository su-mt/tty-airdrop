import Foundation
import AppKit

let red = "\u{001B}[31m"
let green = "\u{001B}[36m"
let yellow = "\u{001B}[33m" 
let reset = "\u{001B}[0m"

func printHelp() {
    print("""
    \(yellow)Usage:\(reset) airdrop <file_path>

    \(yellow)Options:\(reset)
      -h, --help     Show this help message and exit

    \(yellow)Example:\(reset)
      airdrop ./example.pdf
    """)
}

// Обработка аргументов
let arguments = CommandLine.arguments

if arguments.contains("-h") || arguments.contains("--help") {
    printHelp()
    exit(0)
}

guard CommandLine.arguments.count > 1 else {
    print("\(yellow)Usage:\(reset) airdrop <file_path>\n       airdrop [-h | --help] show help")
    exit(1)
}

let filePath = CommandLine.arguments[1]
let fileURL = URL(fileURLWithPath: filePath)

guard FileManager.default.fileExists(atPath: filePath) else {
    print("\(yellow)No such file or directory: \(reset)\(filePath)")
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
            print("\(red)AirDrop is unavailable. exit...\(reset)")
            NSApp.terminate(nil)
            return
        }

        service.delegate = self
        service.perform(withItems: [fileURL])
        print("\(green)AirDrop transfer started.\(reset)")
    }

    func sharingService(_ sharingService: NSSharingService, didShareItems items: [Any]) {
        wasShared = true
        NSApp.terminate(nil)
    }

    func sharingService(_ sharingService: NSSharingService, didFailToShareItems items: [Any], error: Error) {
        print("\(red)Error: \(reset) \(error.localizedDescription)")
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
