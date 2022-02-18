import Cocoa

func dictionaries()
{
    // Swift 4 allows you to create Dictionary from arrays (Key-Value Pairs.)
    var cities = ["Delhi", "Denmark", "Bombay", "Bangalore","Hyderabad"]
    
    // You can use the following simple syntax to group the values of dictionary according to first alphabet.
    let GroupedCities = Dictionary(grouping: cities ) { $0.first! }
    print("Grouping by first character: ", GroupedCities)
    print("Grouping by legth of string: ", Dictionary(grouping: cities, by: {$0.count}))
    
    var Distance = [2000,10, 620]
    // Will create a dictionary with Cities as key and Distance as Value
    let cityDistanceDict = Dictionary(uniqueKeysWithValues: zip(cities, Distance))
    print(cityDistanceDict)
    
    // Swift 4 allows you to filter values from a dictionary.
    let closeCities = cityDistanceDict.filter { $0.value < 1000 }
    print(closeCities, closeCities["Hyderabad"])
    
    for (key, keyValue) in cityDistanceDict {
       print("Key \(key) - Value \(keyValue)")
    }
    
    // Use enumerate() function which returns the index of the item along with its (key, value) pair
    for (ind, keyValue) in cityDistanceDict.enumerated() {
       print("Index \(ind) - Dictionary key - value \(keyValue)")
    }
    
    // .keys and .values will return array of keys and values respectively
    print("cityDistanceDict.keys: ", cityDistanceDict.keys)
    print("cityDistanceDict.values: ", cityDistanceDict.values)
    
    print(closeCities["Delhi"] ?? 2)
    
    var newDic = [String: Int]()
    
    for (key, _) in newDic {
        newDic[key, default: 0] += 1
    }
}

func closures()
{
    let divide = {
       (val1: Int, val2: Int) -> Int in
       return val1 / val2
    }
    
    let divide1: (Int, Int) -> Int = {x, y in x / y}
    
    let result = divide(200, 20)
    print (result)
    print(divide1(40, 8))
}

func enums()
{
    // CaseIterable will allow us to use enum as collection. This is using enum as raw value
    enum Platoform: String, CaseIterable {
        case fb = "Facebook"
        case LinkedIn = "This is linkedIn"
        case insta = "Instagram"
    }
    
    print(Platoform.allCases.count)
    
    for value in Platoform.allCases {
        print(value.rawValue)
    }
    
    // Associate enums
    enum SocialPlatform {
        case twitter(followers: Int)
        case youtube(subscribers: Int)
        case fb, linkedIn
    }
    
    // 10_0_0: underscore b/w digits is used to give redability to developers
    func check(_ val: SocialPlatform) {
        switch val {
        case .twitter(let followers) where followers > 10_000:
            print("Eligible for twitter")
            
        case .youtube(let subscribers) where subscribers > 25_000:
            print("Eligible for youtube")
            
        case .fb, .linkedIn, .youtube, .twitter:
            print("Not Eligible")
        }
    }
    
    check(.twitter(followers: 100_000))
    check(.twitter(followers: 10_000))
    check(.youtube(subscribers: 10_0_0_0_0))
    check(.linkedIn)
}

func computed_property()
{
    class sample {
        var no1 = 0.0, no2 = 0.0
        var length = 300.0, breadth = 150.0
        
        // A read-only property in computed property is defined as a property with getter but no setter.
        var middle: (Double, Double) {
            get {
                return (length / 2, breadth / 2)
            }
          
            // If you write only the 'set' keyword without parenthesis then default name which stores your new value will be 'newValue'.
            set(axis){
                no1 = axis.0 - (length / 2)
                no2 = axis.1 - (breadth / 2)
            }
        }
    }

    var result = sample()
    print(result.middle)
    result.middle = (0.0, 10.0)

    print(result.no1)
    print(result.no2)
    
    // A read-only property in computed property is defined as a property with getter but no setter. It is always used to return a value.
    // The variables are further accessed through a '.' Syntax but cannot be set to another value.
    class film {
       var head = ""
       var duration = 0.0
       var metaInfo: [String:String] {
          return [
             "head": self.head,
             "duration":"\(self.duration)"
          ]
       }
    }

    var movie = film()
    movie.head = "Swift 4 Properties"
    movie.duration = 3.09

    print(movie.metaInfo["head"]!)
    print(movie.metaInfo["duration"]!)
}

func computed_property_as_observer()
{
    // In Swift 4 to observe and respond to property values Property Observers are used. Each and every time when property values are set property observers are called.
    // Except lazy stored properties we can add property observers to 'inherited' property by method 'overriding'.
    // Property Observers can be defined by either
    // .Before Storing the value - willset
    // . After Storing the new value - didset
    
    class Samplepgm {
       var counter: Int = 0 {
          willSet(newTotal){
             print("Total Counter is: \(newTotal)")
          }
          
          didSet {
              if counter > oldValue {
                print("Newly Added Counter \(counter - oldValue)")
              }
              
              counter -= 1
          }
       }
    }

    let NewCounter = Samplepgm()
    NewCounter.counter = 100
    NewCounter.counter = 800
    print(NewCounter.counter)
}

func mutating_keyword()
{
    // structures and enumerations belong to value types which cannot be altered by its instance methods. However, Swift 4 language provides
    // flexibility to modify the value types by 'mutating' behavior. Mutate will make any changes in the instance methods and will return back
    // to the original form after the execution of the method. Also, by the 'self' property new instance is created for its implicit function
    // and will replace the existing method after its execution
    struct area {
       var length = 1
       var breadth = 1
       
       func area() -> Int {
          return length * breadth
       }
       mutating func scaleBy(res: Int) {
          length *= res
          breadth *= res
          print(length, breadth)
       }
    }

    var val = area(length: 3, breadth: 5)   // If use let, error: Cannot use mutating member on immutable value: 'val' is a 'let' constant
    val.scaleBy(res: 3)
    print(val.length, val.breadth)
}

func type_methods()
{
    // Type or static method, both are same
    class Math {
        // Instead of class, you could have used static
       class func abs(number: Int) -> Int {
          if number < 0 {
             return (-number)
          } else {
             return number
          }
       }
    }

    struct absno {
       static func abs(number: Int) -> Int {
          if number < 0 {
             return (-number)
          } else {
             return number
          }
       }
    }

    let no = Math.abs(number: -35)
    let num = absno.abs(number: -5)

    print(no)
    print(num)
}

func subscripts()
{
    // Defining multiple subscripts are termed as 'subscript overloading' where a class or structure can provide multiple subscript definitions as required.
    // These multiple subscripts are inferred based on the types of values that are declared within the subscript braces.
    
    class Choose {
        let rows: Int, columns: Int
        var values: [Int] = [1, 67, -223, 12, 56, 23, 0, 743]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
        }
        
        subscript(index: Int) -> Int {
            get {
                return values[index]
            }
            
            set(myNewValue) {
                self.values[index] = myNewValue
            }
        }
        
        subscript(row: Int, column: Int) -> Int {
            get {
                return values[(row * columns) + column]
            }
            set {
                values[(row * columns) + column] = newValue
            }
        }
    }
    
    let mat = Choose(rows: 3, columns: 3)
    
    print("\(mat[1,2])")
    mat[1,2] = 45
    print("\(mat[1,2])")
    
    print(mat[2])
    mat[2] = 64
    print(mat[2])
}

extension Int {
    var add: Int {return self + 100 }
    var sub: Int { return self - 10 }
    var mul: Int { return self * 10 }
    var div: Int { return self / 5 }
    
    func topics(summation: () -> ()) {
        for _ in 0..<self {
            summation()
        }
    }
    
    subscript(multtable: Int) -> Int {
        return (self / multtable) % 10
    }
}

func addingUsingExtensions()
{
    let addition = 3.add
    print("Addition is \(addition)")
    
    let subtraction = 120.sub
    print("Subtraction is \(subtraction)")
    
    let multiplication = 39.mul
    print("Multiplication is \(multiplication)")
    
    let division = 55.div
    print("Division is \(division)")
    
    let mix = 30.add + 34.sub
    print("Mixed Type is \(mix)")
    
    4.topics(summation: {
        print("Inside Extensions Block")
    })
    
    3.topics(summation: {
        print("Inside Type Casting Block")
    })
    
    print(12[0])
    print(7869[1])
    print(786543[2])
}

extension Double {
    mutating func square() {
        let pi = 3.1415
        self = pi * self * self
    }
}

func mutating_using_extensions()
{
    var Trial1 = 3.3
    Trial1.square()
    print("Area of circle is: \(Trial1)")
    
    var Trial2 = 5.8
    Trial2.square()
    print("Area of circle is: \(Trial2)")
    
    var Trial3 = 120.3
    Trial3.square()
    print("Area of circle is: \(Trial3)")
}

class Exx {
    var a: Int = 0
    var b: Int = 0
}

extension Exx {
    // Refer: https://stackoverflow.com/questions/26877314/why-cant-we-add-designated-initialisers-in-extensions-in-swift
    // Designated initializer cannot be declared in an extension of 'Exx';
//    init(a: Int, b: Int) {
//        self.a = a
//        self.b = b
//    }
    
    
    convenience init(a: Int, b: Int) {
        self.init()
        self.a = a
        self.b = b
        print("Calling the convenience init defined using extension")
    }
}

func extensions()
{
    // Functionality of an existing class, structure or enumeration type can be added with the help of extensions. Type functionality can be
    // added with extensions but overriding the functionality is not possible with extensions.
    
    // Swift Extension Functionalities −
    // . Adding computed properties and computed type properties
    // . Defining instance and type methods.
    // . Providing new initializers.
    // . Defining subscripts
    // . Defining and using new nested types
    // . Making an existing type conform to a protocol
    // . Extensions are declared with the keyword 'extension'
    
    let eX = Exx(a: 5, b: 6)
}

func new_way()
{
    let arr = ["Gun", "hey", "prb", "Ani", "Shi"]
    print(arr[3...])
    print(arr[...3])
    print(arr[..<3])
}

new_way()
