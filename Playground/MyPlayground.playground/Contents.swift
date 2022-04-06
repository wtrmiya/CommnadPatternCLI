import Cocoa

class Printer {
    func printMessage(message:String) {
        print(message)
    }
}


//let printObject = Printer()
//printObject.printMessage(message: "Hello")

let printObject = Printer()
Printer.printMessage(printObject)(message: "Hello")
// こんな呼び方できるのか。キモい!


