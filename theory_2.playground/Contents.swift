import Cocoa

import Cocoa

func raw_string()
{
    // ###############################
    // Raw Strings
    // ###############################

    // In simple string, you need backslah to escape sequence.
    let quote = "As my friend\\coworker always said, \"Don't let the truth get in the way of telling good story\"!"

    // Raw string: we use # at the start and the end of the string to make it raw string. We no longer need backslah to escape sequence.
    let rawQuote = #"As my friend\coworker always said, "Don't let the truth get in the way of telling good story"!"#

    print(rawQuote)
    print(##"My friend says:"#" hey"##)
    
    // How to print raw string using string interpolation
    print(#"My friend says: \#(rawQuote)"#)
}

class Dog {
    var age = 0
    var name = ""
}

// Altering string interpolation value
extension String.StringInterpolation {
    mutating func appendInterpolation(_ dog: Dog) {
        appendInterpolation("\(dog.name) - \(dog.age)")
    }
    
    mutating func appendInterpolation(_ x: Int) {
        appendInterpolation("Gunjan is a good boy")
    }
}

func string_interpolation()
{
    // ###############################
    // String Interpolation
    // ###############################
   
    let myDog = Dog()
    myDog.age = 22
    myDog.name = "Blackie"
    
    let x: Int = 6745
    
    // Print the interpolated value of Dog type
    print("Hello, \(myDog)")
    
    // Now, instead of printing the value of 'x', it will print the interpolated value of integer
    print("Integer interpolation, \(x)")
}

func result_type()
{
    // ###############################
    // Result Type
    // ###############################

    enum APIError: Error {
        case badURL
        case rateLimitHit
        case other(reason: String)
    }
    
    func hitApiSuccess() -> Result<String, Error> {
        return .success("It worked")
    }
    
    func hitApiFailure() -> Result<String, Error> {
        return .failure(APIError.badURL)
    }
    
    print(hitApiSuccess())
    print(hitApiFailure())
//    print(hitApi().get())
}

func set_dictionary()
{
    // ###############################
    // Set and Dictionary Order
    // ###############################

    let a: Set<Int> = [1, 2, 3, 4, 5]
    let b: Set<Int> = [1, 2, 3, 4, 5]
    a == b
    print(a)
    print(b)

    let aDic: Dictionary<String,Int> = ["Fido":8,"Sarah":13,"Judlah":6]
    let bDic: Dictionary<String,Int> = ["Fido":8,"Sarah":13,"Judlah":6]
    aDic == bDic
    print(aDic)
    print(bDic)
}

func compact_map()
{
    // In a named function, we declare the parameters and return type in the func declaration line like below
    
    func say(s:String) -> Int {
        // body
        return 1
    }
    
    // In an anonymous function, there is no func declaration line - it's anonymous! So we do it with an in line at the start of the body instead.
    
//    {
//        (s:String)->() in
//        // body
//    }
    
    // in is a keyword defined in the Swift closure syntax as a separator between the function type and the function body in a closure: { /parameters and type/ in /function body/ }
    let allDogs = ["Fido":8,"Sarah":13, "Emilia":6]
    
    let dogsYoungerThan10 = allDogs.compactMapValues { (age) -> Int? in
        if age < 10 {
            return age
        }
        return nil
    }
    
    print(dogsYoungerThan10)
    
    // We can even make the above compactMapValues more shorter
    let dogsYoungerThan_10 = allDogs.compactMapValues {$0 < 10 ? $0 : nil}
    print(dogsYoungerThan_10)
    
    let allDogs1 = ["Fido":8,"Sarah":13, "Emilia":6, "Lonela": nil]
    print(allDogs1.compactMapValues({$0}))
}

func enums()
{
    // ###############################
    // Enum Fix
    // ###############################
    
    enum Games {
        case DMC
        case Assassins
    }
    
    // As we already stated the type of a as Games (a: Games) so we can use shorthand (.DMC) instead of long way (Games.DMC)
    let a: Games = .DMC
    print(a)
    
    // Like class and struct, enum can also inherit. Names inherit String class, so we can initialize the properties of Names
    enum Names: String {
        case officeName = "Gunjan"
        case schoolName = "Ganju"
    }
    
    print(Names.officeName, Names.officeName.rawValue)
    
    enum Food {
        case friedRice
        case milkshake
        case pizza(toppings: [String])
    }
    
    let x = Food.pizza(toppings: ["Pepperoni","Cheese","Olives"])
    print(type(of: Food.friedRice))
    print(type(of: 5))
    print(type(of: x))
    
    print(x)
}

func future_enum()
{
    // ###############################
    // Future Enums
    // ###############################
    
    enum Food {
        case friedRice
        case milkshake
        case pizza(toppings: [String])
        case paneer
    }
    
    let lunch = Food.friedRice
    
    // Error: Switch must be exhaustive i.e. it must cover all the cases but here we are missing the case for 'paneer'. To overcome this proble,
    // we can simply add the case for paneer or write the default case. We can change the tag from error to warning by using @@unknown before
    // default case. "Warning: Switch must be exhaustive... Do you want to add missing cases?"
    switch lunch {
    case .friedRice:
        print("Cool lunch fam")
    case .milkshake:
        print("Is this really a meal?")
    case .pizza(let toppings):
        print("Your toppings: \(toppings)")
    @unknown default:
        print("A new food")
    }
}

func simplied_the_optional() -> Void
{
    // ###############################
    // Optional Simplified
    // ###############################

    func translate(original: String) throws -> String? {
        return "ok"
    }
    
    let x = try? translate(original: "Hello")
    print(x!)
}

func is_multiple_of()
{
    // ###############################
    // Is Multiple Of
    // ###############################

    let number = 204

    print(number % 6 == 0)
    print(number.isMultiple(of: 6))
}

func references_and_keypaths()
{
    struct Crew {
        var name: String
        var rank: String
    }
    
    struct Starship {
        var name: String
        var maxWrap: Double
        var Captain: Crew
        
        func goToMax() {
            print("\(name) is now travelling at wrap \(maxWrap)")
        }
    }
    
    let janeway = Crew(name: "Gunjan", rank: "Captain")
    let voyager = Starship(name: "Prabhat", maxWrap: 9.976, Captain: janeway)
    
    // Grap the reference to gotToMax
    let enterWrap = voyager.goToMax
    
    // Calling the reference
    enterWrap()
    
    // KeyPath is represented using backslash. Syntax: \Type.property
    let nameKeyPath = \Starship.name
    let maxWrapKey = \Starship.maxWrap
    let captainName = \Starship.Captain.name
    
    let starshipName = voyager[keyPath: nameKeyPath]
    let maxWrapKeyPath = voyager[keyPath: maxWrapKey]
    let startshipCaptain = voyager[keyPath: captainName]
    
    print(startshipCaptain)
}

func class_struct()
{
    class A {
        
    }
    
    struct S {
        
    }
    
    let a = A()
    let s = S()
    
    // Class is a reference type where as Struct is a value type
    let a1 = a      // a1 and a both points to same object and any changes made to either of them will be refelected to the other
    let s1 = s      // We created a new object 's1'. s1 and s are two different instances
}
