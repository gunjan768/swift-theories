import Cocoa

func variables()
{
    var greeting = "Hello, playground"
    //greeting = 31     // Can't assign int type to string type

    // let is used to define the constants
    let age = 32
    //age = 32      // error

    var height: Int = 173;      // explictly defining Int

    print(height, age, greeting)
    
    // Optionas: We can define optionals either using ? or !
    
    // a) c can store a string or nil, but it is wrapped
    var c: String?
    
    // b) d can store a string or nil, but it is already unwrapped
    var d: String!
}

func conditions()
{
    let a: Int = 44;

    if (a <= 10) {          // if a <= 10
        print("Hey")
    } else if a >= 10 && a <= 20{
        print("Hey 1")
    } else if (a >= 44 && a <= 55) {
        print("Hey 2")
    } else {
        print("Hey 3")
    }
    
    switch (a) {
        case 40:
            print("Hey 40")
        case 41, 44:
            print("41 or 44")
        default:
            print("Hey default")
    }
    
    // switch case
    switch (a) {
        case 1...4:
            print("Hey 40")
        case 6...7:
            print("Hey 40")
        case 41, 44:
            print("41 or 44")
        default:
            print("Hey default")
    }
}

func loops()
{
    // for loop
    for i in 1...5  {
        print(i)
    }

    var i = 10

    // while loop
    while i >= 6 {
        print(i)
        
        i -= 1
    }

    i = 12

    // repeat while loop
    repeat {
        print(i)
        i += 1
    } while i > 13
}

func functions()
{
    // argument labels are optional and they are used for giving description. You can use same arg lables for more than one variables.
    func addTwoNumbersWithArgumentLabels(arg1 num1: Int, arg2 num2: Int) -> Int {
        return num1 + num2;
    }

    // argument labels are optional so we can even remove them
    func addTwoNumbersWithoutArgumentLabels(num1: Int, num2: Int) -> Int {
        return num1 + num2;
    }

    // argument labels as underscore can enable us to call function without specifying anything (neither arg label nor the name of the parameters)
    func addTwoNumbers(_ num1: Int, _ num2: Int) -> Int {
        return num1 + num2;
    }

    print(addTwoNumbersWithArgumentLabels(arg1: 4, arg2: 6))
    print(addTwoNumbersWithoutArgumentLabels(num1: 16, num2: 8))
    print(addTwoNumbers(5, 10))
}

func classes()
{
    class Employee {
        var name = "Gunjan"
        var salary = 10
        var role = "Teacher"
        
        func doWork() {
            print("I am doing work")
        }
    }

    let a: Int = 1000
    let b: String = "Ted"
    let c: Employee = Employee()

    c.name = b;
    c.salary = a
    print(c.salary, c.name, c.doWork())
}

func inheritance()
{
    class Person {
        var name = "Gunjan"
        
        // Default initializer
        init() {
            print("Default initializer")
        }
        
        // initializer with parameters
        init(_ name: String) {
            print("Parametrized initializer with value: " + name)
            self.name = name
        }
    }
    
    class Employee: Person {
        var salary = 10
        var role = "Teacher"
        
        override init(_ name: String) {
            super.init(name)
            print("overriden Parametrized initializer with value: " + name)
            self.name = name
        }
        
        func doWork() {
            print("I am doing work")
        }
    }
    
    class Manager: Employee {
        var x = 4
        
        // Computed property: property with curly braces where we run some code and returns the value which will then get stored in the 'bonus' property.
        var bonus: Int {
            // This is a computed property. When it's accessed, the code here will run. Then at last we will return the value
            
            return x * 10;
        }
        
        init(_ name: String, _ team: Int) {
            // Calls the init of Employee class
            super.init(name)
            
            x = team
        }
        
        override func doWork() {
            super.doWork()  // optional (calling Base class doWork())
            print("Overriding doWork function")
        }
    }
    
//    let c: Manager = Manager()
//    print(c.salary, c.name, c.doWork())
//
    Person()
    let p = Person("Prabhat")
    print(p.name)
    
    // initializers also get inherited in Employee class from Person class
    let e = Employee("Shiwani")
    print(e.name)
    
    let m = Manager("Emilia", 12)
    print(m.bonus)
}

func optionals()
{
    // We can't assign nil (means empty) to the variables.
    // var a:Int = nil      // error
    
    let a1 = Int("49")
    print(a1)
    
    if let b = Int("49") {
        print(b)
    }
    
    // If we want to assign nil to variale, we use optional (?). Optional data allows "nil" to be value for that variable or constant. Below variable 'a' is optional that means it either contains integer or nil
    var a:Int? = nil
    
    class DeepawaliPresent {
        func surprise(_ val: Int) -> Int {
            return Int.random(in: 4...10)
        }
    }
    
    // present is not DeepawaliPresent type but Optional(DeepawaliPresent) type
    let present: DeepawaliPresent? = DeepawaliPresent();
    
    if (present != nil) {
        
        // should be unwrapped first. You can unwrap using exclamation sign (!). Unwrapping means removing the optional part and taking the DeepawaliPresent instance out.
        print(present!.surprise(5));
        
        // Using optional so returned answer will be wrapped inside Optional. Expression implicitly coerced from 'Int?' to 'Any'.
        
        // Optional chaining (Output: Optiona(ans)). x?.y() ---> ? will check that whether x is null and if it is not then call the method y()
        print(present?.surprise(20));
        
        // Expression implicitly coerced from 'Int?' to 'Any' --- to avoid this warning.
        print(present?.surprise(20) ?? 7);
        
        // Output: Optiona(ans)
        print(present?.surprise(20) as Any);
        
        // Optional binding. This will take out the DeepawaliPresent instance and store in actualPresent i.e. do the unwrapping.
        if let actualPresent = present {
            print(actualPresent.surprise(5))
        }
    }
    
    // present1 is optional but unwrapped
    var present1: DeepawaliPresent! = nil;
    var present2: DeepawaliPresent? = nil;
    
    print(present1, present2)
    
    present1 = DeepawaliPresent()
    present2 = DeepawaliPresent()
    
    print(present1)
    print(present2)
    
    // As present1 is unwrapped optional so we can directly call the method
    print("Optional using !: ", present1.surprise(7))
    
    // Expression implicitly coerced from 'Int?' to 'Any': To prevent this warning we can use the followings
    
    // 1) Force unwrap the Optional value. Result of present2?.surprise(7) is Optional(Int) so unwrap it use the ! sign at the last
    print("Optional using ?: ", (present2?.surprise(7))!)
    
    // 2) Provide a default value to avoid this warning
    print("Optional using ?: ", (present2?.surprise(7)) ?? 8)
    
    // 3) Explicitly cast to 'Any' with 'as Any' to silence this warning. We have not unwrapped it so result will also be Optional(Int) as we just made it silent by casting it into Any
    print("Optional using ?: ", (present2?.surprise(7)) as Any)
    
    print("Optional using ?: ", present2!.surprise(7))
}

func designated_and_convenience_initializers()
{
    class Person {
        var name: String
        var x: Int?     // By default Optional will point to nil
        var y: String!  // By default Optional will point to nil
        
        // Default initializer. Proper name of initializer is Designated initializer and it ensures that the object is ready to be used and all its properties are initialized
        init() {
            print("Default initializer")
            name = "Gunjan"
        }
        
        // initializer with parameters
        init(_ name: String) {
            print("Parametrized initializer with value: " + name)
            self.name = name
        }
        
        // Convenience initializers are for you to pre-configure the object in a certain way. This may rely on a designated initializer to ensure that the object is ready to be used.
        
        // We create Convenience initializer using convenience keyword
        convenience init(_ gender: String, _ netWorth: Int) {
            self.init()     // must call designated initializer
            
            self.y = gender
            self.x = netWorth
            
            print("convenience initializer is called for creating object")
        }
    }
    
    let a = Person()
    print(a.name, a.x as Any, a.y ?? "female")
    
    let _ = Person("Male", 24)
}

func arrays()
{
    let homegenousArray = ["Cat", "Horse", "Wolf"]
    let _:[String] = ["Cat", "Horse", "Wolf"]     // explicitly mentioned the type of an array
    
    for counter in 0...homegenousArray.count-1 {
        print(homegenousArray[counter])
    }
    
    let hetrogenousArray = ["Dog", 2, "Bird"] as [Any]
    
    for counter in 0...hetrogenousArray.count-1 {
        print(hetrogenousArray[counter])
    }
    
    for item in hetrogenousArray{
        print(item)
    }
    
    // How to declare an empty array
    var emptyArray: [String] = []
    var emptyArray1 = [String]()    // Creating empty array object
    
    emptyArray.insert("Gunjan", at: 0)
    emptyArray.insert("Shiwani", at: 1)
    
    // Will add at the back of the array
    emptyArray += ["Prabhat", "NoOne"]
    emptyArray.append("Aniketan")   // append means at the last of an array
    print(emptyArray)
    
    emptyArray.remove(at: 2)
    print(emptyArray)
    emptyArray.removeAll()
    print(emptyArray)
}

func dictionaries()
{
    var dic = [String: String]()      // Creating dictionary object
    dic["Gun 111"] = "Red"
    dic["Shi 23"] = "Blue"
    dic["Prabhat"] = "Green"
    
    print("Printing the value of dic: \(dic["Shi 23"]!)")
    
    dic.removeValue(forKey: "Gun 111")
    
    // Will print in any order (it is a hash map)
    for (key, value) in dic {
        print("\(key) is \(value)")
    }
    
    var dic1: [String: String] = ["Gunjan": "Mummy", "Bhaiya": "Nani"]
    print(dic1)
}

func tupels_and_set()
{
    let tuple = ("gunjan", 12.44)
    let tuple1: (Double, Bool) = (42.351, true)
    print(tuple.0, tuple.1)
    print(tuple1.0, tuple1.1)
    print("Printing the tuple \(tuple)")
    
    let set: Set = [12, 2, 45, 2, 56, 21, 2, 2, 1, 87]
    print(set)
}

func structs()
{
    struct Struct {
        var a: Int
        var b: String
        var c: Float = 2.451    // Provided the initial value
        
        func doWork() {
            print("Doing work")
        }
    }
    
    // We have not provided the initial value to our properties (a and b) except 'c' so we need to pass the value of a properties as a arguments
    var obj1: Struct = Struct(a: 5, b: "It is bro")
    let obj2: Struct = Struct(a: 56, b: "Ganju", c: 5.43)
    
    obj1.a = 67
    // obj2.a = 43          // Error: Cannot assign to property: 'obj2' is a 'let' constant
    
    // But we assign the value to a property even if the calling object is declared as let and this is the diff b/w struct and class
    
    class Class {
        var a: Int = 0
        var b: String = ""
        var c: Float = 2.451    // Provided the initial value
        
        func doWork() {
            print("Doing work")
        }
    }
    
    let obj3: Class = Class()
    obj3.a = 67
}

func enums()
{
    enum myEnum {
        case North
        case South
        case West
        case East
    }
    
    var insEnum: myEnum = myEnum.East
    print(insEnum)
    insEnum = .North
    print(insEnum)
    
    // We can direclty access using dot (.) operator
    let insEnum1: myEnum = .West
    print(insEnum1)
    
    if insEnum == .West {
        
    }
}

enums()
