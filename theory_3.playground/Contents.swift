import Cocoa
import CoreGraphics

func references_and_keypaths()
{
    // . Keypaths enable us to store a reference to a property, which then lets us retrieve it's value from any instance
    // of it's enclosing type
    // . They come in 3 main variants: KeyPath (readonly), WritableKeyPath (writable with value semantics), and
    // ReferenceWritableKeyPath (writable with reference semantics)
    // . KeyPaths can automatically be converted into functions that accept their enclosing type as input and return their
    // property as output
}

func guards()
{
    // guard is similar to if else
    func check(num: Int) -> Bool {
        // If conditions after guard satisfied then it will execute the statement after 'else' otherwise 'else' will be executed
        guard (num == 4 || num == 7) else {return false}
        
        return true
    }
    
    // guard is similar to if else
    func check1(num: Int) -> Bool {
        // If conditions after guard satisfied then it will execute the statement after 'else' otherwise 'else' will be executed
        guard (num == 4 && num == 7) else {return false}
        
        return true
    }
    
    // guard is similar to if else
    func check2(num: Int) -> Bool {
        // If conditions after guard satisfied then it will execute the statement after 'else' otherwise 'else' will be executed.
        // Comma separated means &&
        guard num != 4, num == 7 else {return false}
        
        return true
    }
    
    print(check(num: 4))
    print(check(num: 5))
    
    print(check1(num: 4))
    print(check1(num: 5))
    
    print(check2(num: 4))
    print(check2(num: 7))
    
    // We can use guard to unwrap the optional
    var s: String?
    s = "Gunjan"
    guard let x = s else {print("Value is nil"); return}
    print("Value is: \(x)")
}

// Protocols holds the declaration (along with getter and setter for variable) of functions and variables and not their definition.
// Protocol is very similar as interface in Java
protocol CarProtocol {
    // property in protocol must have explicit { get } or { get set } specifier
    var color: String {get set}
    
    func drive()
    func isAllowed(val: Int) -> Bool
}

func protocols()
{
    class Car {
        
    }
    
    class BMW: Car, CarProtocol {
        var color: String = "Red"
        
        func drive() {
            print("Driving")
        }
        
        func isAllowed(val: Int) -> Bool {
            return val == 3
        }
    }
    
    // CarProtocol()    // Error: 'CarProtocol' cannot be constructed because it has no accessible initializers
    let bmw = BMW()
    print(bmw.color)
    bmw.color = "Blue"
    print(bmw.color)
}

func strong_weak_variable()
{
    // By default variables are strong. To declare a variable as weak, use 'weak' keyword. Strong variable holds onto the weak variable
    // which means if there is no strong variable, then weak variable will be deleted from the memory. Its like child (strong) holding
    // the baloon (weak). When child disappears, baloonn will also disappear but vice versa is not true.
    let strongVar = 44
    
    // weak var weakVal = 56   // Error: 'weak' may only be applied to class and class-bound protocol types, not 'Int'
    
    class Engine {
        
    }
    
    class Car {
        // 'weak' variable should have optional type 'Engine?'
        weak var engine: Engine?
        
        init(engine: Engine) {
            self.engine = engine
        }
    }
    
    let engine = Engine()
    let x = Car(engine: engine)
    print(x.engine)
}

func closures()
{
    func normalAdd(a: Int, b: Float) -> Double {
        return (Double)(Float(a) + b)
    }
    
    let closureAdd: ((Int, Float) -> Double) = {a, b in
        return (Double)(Float(a) + b)
    }
    
    let closureAddAndReturnVoid: ((Int, Float) -> Void) = {a, b in
        print((Double)(Float(a) + b))
    }
    
    // If the return type is void, then we can directly put parenthesis instead of writing Void
    let closureAddAndReturnVoid1: ((Int, Float) -> ()) = {a, b in
        print((Double)(Float(a) + b))
    }
    
    print(closureAdd(2, 5.4))
    closureAddAndReturnVoid(2, 5.4)
    closureAddAndReturnVoid1(2, 5.4)
    
    // Closure name (variable) is optional
    let closureAddWithOptional: ((Int, Float) -> Double)? = {a, b in
        return (Double)(Float(a) + b)
    }
    
    // Variable 'closureAddWithOptional' is optional whose type is '((Int, Float) -> Double)?' so we put ! sign just after the variable name
    print("Variable 'closureAddWithOptional' is optional: ", closureAddWithOptional!(2, 5.4))
    print("Variable 'closureAddWithOptional' is optional: ", closureAddWithOptional?(2, 5.4) as Any)
    
    // Return type is optional
    let closureAddWithOptional1: ((Int, Float) -> Double?) = {a, b in
        return (Double)(Float(a) + b)
    }
    
    // Return type is optional so we put ! after the function call (after the parenthesis)
    print(closureAddWithOptional1(2, 5.4)!)
    
    // Both Variable 'closureAddWithOptional' is optional and Return type is optional
    let closureAddWithOptional2: ((Int, Float) -> Double?)? = {a, b in
        return (Double)(Float(a) + b)
    }
    
    // Both Variable 'closureAddWithOptional' is optional and Return type is optional so we put two ! signs: after the variable name and
    // after the function call (after the parenthesis)
    print(closureAddWithOptional2!(2, 5.4)!)
}

func closures_1()
{
    // Function types cannot have argument labels so use _
    let additionClosure: (_ x: Int, _ y: Int) -> Int = {
        (x: Int, y: Int) -> Int in return x + y
    }

    // Function types cannot have argument labels so use _
    let additionClosure1: (Int, Int) -> Int = {
        (x: Int, y: Int) -> Int in return x + y
    }

    // Function types cannot have argument labels so use _
    let additionClosure2: (Int, Int) -> Int = {
        (x, y) in return x + y
    }

    // Function types cannot have argument labels so use _
    let additionClosure3: (Int, Int) -> Int = {
        (x, y) in x + y
    }

    additionClosure(4, 5)
    additionClosure1(6, 8)
    additionClosure2(7, 20)
    additionClosure3(30, 20)
}

func closure_callback_with_argument()
{
    func printMsg(isMorning: Bool, nameCallback: (Float) -> String, noUse: Int)
    {
        debugPrint("Inside printMsg function")
        
        if isMorning {
            debugPrint("isMorning is true: \(nameCallback(4))")
        }
    }

    func assignName(name: String) -> String
    {
        debugPrint("AssignName is called")
        return name
    }

    let callback: (Float) -> String = {(x) in
        assignName(name: "Gunjan")      // return is not explicitly required in a single line statement
    }

    // Different ways of passing closure as a callback
    printMsg(isMorning: true, nameCallback: callback, noUse: 4)
    printMsg(isMorning: true, nameCallback: {(x) in assignName(name: "Prabhat")}, noUse: 4)

    printMsg(isMorning: true, nameCallback: { x in
        print("Inside closure")
        return assignName(name: "Shiwani")
    }, noUse: 76)
}

func closure_callback_without_any_argument()
{
    func printMsg(isMorning: Bool, nameCallback: () -> String, noUse: Int)
    {
        debugPrint("Inside printMsg function")
        
        if isMorning {
            debugPrint("isMorning is true: \(nameCallback())")
        }
    }

    func assignName(name: String) -> String
    {
        debugPrint("AssignName is called")
        return name
    }

    let callback: () -> String = {() in
        assignName(name: "Gunjan")      // return is not explicitly required in a single line statement
    }
    
    let callback1: () -> String = {
        assignName(name: "Aniketan")      // return is not explicitly required in a single line statement
    }

    // Different ways of passing closure as a callback when no callback receives no argumenent
    printMsg(isMorning: true, nameCallback: callback, noUse: 4)
    printMsg(isMorning: true, nameCallback: callback1, noUse: 4)
    
    printMsg(isMorning: true, nameCallback: {() in assignName(name: "Prabhat")}, noUse: 4)

    printMsg(isMorning: true, nameCallback: {
        print("Inside closure")
        return assignName(name: "Shiwani")
    }, noUse: 76)
}

func closure_callback_as_last_paramter()
{
    func printMsg(isMorning: Bool, nameCallback: (Float) -> String)
    {
        debugPrint("Inside printMsg function")
        
        if isMorning {
            debugPrint("isMorning is true: \(nameCallback(4))")
        }
    }

    func assignName(name: String) -> String
    {
        debugPrint("AssignName is called")
        return name
    }

    let callback: (Float) -> String = {(x) in
        assignName(name: "Gunjan")      // return is not explicitly required in a single line statement
    }

    // Different ways of passing closure as a callback
    printMsg(isMorning: true, nameCallback: callback)
    printMsg(isMorning: true, nameCallback: {(x) in assignName(name: "Prabhat")})

    printMsg(isMorning: true, nameCallback: { x in
        print("Inside closure")
        return assignName(name: "Shiwani")
    })
    
    // See, how we passed closure to a function as a callback. We are passing closure to a printMsg() function as a
    // last argument, so it is possible to write in a different way. This is called trailing closure.
    printMsg(isMorning: true) { x in
        print("Last parameter")
        return assignName(name: "Aniketan")
    }
}

closure_callback_as_last_paramter()

func typealiases()
{
    // [String]: means array of strings
    typealias ClosureFunctionType = ([String]) -> (Void)
    
    func normalFunction(callback: ClosureFunctionType) -> Void {
        callback(["Gunjan", "Mummy"])
    }
    
    let callback: ClosureFunctionType = {name in
        print("Executing the closure as callback: ", name)
    }
    
    normalFunction(callback: callback)
}
