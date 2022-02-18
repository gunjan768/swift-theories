import Cocoa
import Foundation

func autoclosure_with_no_return()
{
    // Argument type of @autoclosure parameter must be '()' i.e. takes no argument. Our closure has void return type: @autoclosure () -> () ..... nothing mentioned
    // parenthesis means void return type i.e. @autoclosure () -> (Void)
    func printMsg(isMorning: Bool, nameCallback: @autoclosure () -> (), noUse: Int)
    {
        debugPrint("Inside printMsg function")
        
        if isMorning {
            // When the return value of void function is printed then it outputs open-close parenthesis i.e. (). Here, nameCallback() has Void
            // return type so it outputs: ()
            debugPrint("isMorning is true: \(nameCallback())")
        }
    }

    // By declaring callback as autoclosure, now we don't need to write curly braces.
    // (print("First Line")) is the body of the autoclosure but you can't add more than one line and even you can't write return
    // keyword. As our autoclosure has void return type so compiler will not add any return statement inside the autoclosure body
    // i.e. our autoclosure body: (print("First Line")) will look like:
    // () -> () = {() in
    //    let x = 0     // Assume this line as single line statement is the return statement by default
    //    print("First Line")
    // }
    
    // Remember that in the closure (I am not talking about autoclosure) body, if there is a single statement, then it returns that
    // statement, so we had added two lines in the above closure body
    printMsg(isMorning: true, nameCallback: (print("First Line")), noUse: 5)
}

func autoclosure_with_return()
{
    // Argument type of @autoclosure parameter must be '()' i.e. takes no argument. Autoclosure with String as return type
    func printMsg(isMorning: Bool, nameCallback: @autoclosure () -> (String), noUse: Int)
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

    let callback: () -> String = {
        assignName(name: "Gunjan")      // return is not explicitly required in a single line statement
    }
    
    // By declaring callback as autoclosure, now we don't need to write curly braces.
    // As the return type of the autoclosure is String so our autoclosure body ("Prabhat")) will look like
    // () -> (String) = {() in return "Prabhat"}.
    
    // As return type of autoclosure is String so we have to mention String inside the parenthesis so that
    // compiler can return that String and fullfil the return tpye which is String
    printMsg(isMorning: true, nameCallback: ("Prabhat"), noUse: 5)
    
    // As we have not written the String hence it will throw an error. (print("Prabhat")) looks like:
    // () -> (String) = {() in return print("Prabhat")} ... which is an error as return type is string
    // and we are trying to return print() statment and we know that return type of print() is Void
    // hence ultimately we are trying to return the Void type.
    // printMsg(isMorning: true, nameCallback: (print("Prabhat")), noUse: 5)        // Error
    
    // Looks like: () -> (String) = {() in return callback()}.  As callback() returns String
    printMsg(isMorning: true, nameCallback: (callback()), noUse: 5)
    
    // Write either like (callback)() or (callback())
    printMsg(isMorning: true, nameCallback: (callback)(), noUse: 5)
    
    // Looks like we are passing string as second arg but actually it is autoclosure. So, don't overuse the autoclosure
    // else it makes the code hard to understand. We can directly write without any parenthesis also.
    // We changed from ("String") to "String"
    printMsg(isMorning: true, nameCallback: "Shiwani", noUse: 5)
    
    // Changed from (callback()) to callback(). Removed the parenthesis.
    printMsg(isMorning: true, nameCallback: callback(), noUse: 5)
}

func keyPath()
{
    let thirdIndexInteger = \[Int][3]
    let integers = [0, 1, 2, 3, 4]
    
    print(integers[keyPath: thirdIndexInteger])
    
    // We also have a special path that can refer to a whole instance instead of a property. We can create one with the following syntax, \.self.
    // The result of the identity key path is the WritableKeyPath of the whole instance, so you can use it to access and change all of the data
    // stored in a variable in a single step.

    var foo = "Foo"
    //  Identity key path to String.
    let stringIdentity = \String.self
    //  WritableKeyPath<String, String>

    foo[keyPath: stringIdentity] = "Bar"
    print(foo) // Bar

    struct User {
      let name: String
    }
    
    var user = User(name: "John")
    print(user) // User(name: "John")
    // Identity key path to User.
    let userIdentity = \User.self
    // WritableKeyPath<User, User>

    user[keyPath: userIdentity] = User(name: "Doe")
    print(user) // User(name: "Doe")
}

func keyPathsUsingClass()
{
    class User {
        let age: Int = 22
        var height: Int = 173
    }
    
    let user: User = User()
    let userAgeRole = \User.age
    let userHeightRole = \User.height
    
    print(user[keyPath: userAgeRole])
    print(user[keyPath: userHeightRole])
    
    // As age is defined as let so we can't change it
    // user[keyPath: userAgeRole] = 22      // Error: Cannot assign through subscript: 'userAgeRole' is a read-only key path
    user[keyPath: userHeightRole] = 174
    
    print(user[keyPath: userAgeRole])
    print(user[keyPath: userHeightRole])
}

func keyPathsUsingStruct()
{
    struct User {
        let age: Int = 22
        var height: Int = 173
    }
    
    let user: User = User()
    let userAgeRole = \User.age
    let userHeightRole = \User.height
    
    print(user[keyPath: userAgeRole])
    print(user[keyPath: userHeightRole])
    
    // We can't change the 'user' variable itself as it is defined as let.
    // user[keyPath: userAgeRole] = 22
    // user[keyPath: userHeightRole] = 174
    
    struct User1 {
        let age: Int = 22
        var height: Int = 173
    }
    
    var user1: User1 = User1()
    let userAgeRole1 = \User1.age
    let userHeightRole1 = \User1.height
    
    print(user1[keyPath: userAgeRole1])
    print(user1[keyPath: userHeightRole1])
    
    // As age is defined as let so we can't change it
    // user1[keyPath: userAgeRole1] = 22      // Error: Cannot assign through subscript: 'userAgeRole1' is a read-only key path
    user1[keyPath: userHeightRole1] = 174
}

func keyPathAsFunction()
{
    struct Person {
        var name: String
    }
    
    var person = Person(name: "gunjan")
    
    // In Swift, changing the value of a parameter passed into a function is not possible. This is because a function argument is a constant,
    // and constants cannot be modified. Swift inout parameters allow you to change an input passed into a function inside that function.
    // This is where inout parameters help: An inout parameter can be modified inside a function and the changes apply outside the function.
    // To turn a function parameter into a variable that can be changed inside a function: 1) Mark the parameter with inout. 2) Use & when passing
    // a parameter value into the function call. WritableKeyPath<Type, Value>
    func convertToUpperCase<T>(object: inout T, keypath: WritableKeyPath<T, String>) {
        print("Type of object: ", type(of: object))
        object[keyPath: keypath] = object[keyPath: keypath].uppercased()
    }
    
    // With struct
    print(person.name)
    convertToUpperCase(object: &person, keypath: \Person.name)      // WritableKeyPath<Person, String> as name is String
    print(person.name)
    
    // With String
    var x = "prabhat"
    print(x)
    convertToUpperCase(object: &x, keypath: \String.self)
    print(x)
}

keyPathAsFunction()

func argLabel_diff()
{
    // If you have two almost identical functions where the only difference is argument label, use only a function name would cause
    // an ambiguous error. You also need to specify argument labels along with function names.
    // In this example, we have two identical functions. The only difference is their argument label, score and alsoScore.
    let scores = [3, 8, 1, 7, 4, 2, 5, 6, 9, 10]
    func greaterThanFive(score: Int) -> Bool {
        return score > 5
    }

    func greaterThanFive(alsoScore: Int) -> Bool {
        return alsoScore > 5
    }

    // Use scores.filter(greaterThanFive) will cause Ambiguous use of 'filter' error. You need to use argument label in this case,
    // scores.filter(greaterThanFive(score:)).
    let _ = scores.filter(greaterThanFive(score:))
}

func closures()
{
    func getData(callBackClosure: (String) -> (Void)) {
        callBackClosure("Gunjan")
    }
    
    // Shorthand way of closure without parenthesis if function accepts the only arg which is closure
    getData { Name in
        print(Name)
    }
}

func lazy_variables()
{
    // Refer: https://www.avanderlee.com/swift/lazy-var-property/#:~:text=A%20lazy%20var%20is%20a,the%20first%20time%20it's%20called.&text=A%20lazy%20stored%20property%20is,lazy%20modifier%20before%20its%20declaration.
    // The word ‘lazy’ describes best what a lazy property means as the initial value of a lazy property is not calculated until the first
    // time it’s used. In other words: It’s lazy initialization. This could be a great way to optimize your code to prevent doing any
    // unnecessary work.
    
    struct Person {
        let name: String
        let age: Int
    }

    struct PeopleViewModel {
        let people: [Person]
        
        lazy var oldest: Person? = {
            print("Lazy var oldest initialized")
            return people.max(by: { $0.age < $1.age })
        }()
        
        init(people: [Person]) {
            self.people = people
            print("View model initialized")
        }
    }
    
    // Prints: "View model initialized"
    var viewModel = PeopleViewModel(people: [
        Person(name: "Antoine", age: 30),
        Person(name: "Jaap", age: 3),
        Person(name: "Lady", age: 3),
        Person(name: "Maaike", age: 27)
    ])

    // Prints: "Lazy var oldest initialized"
    // Prints: Person(name: "Antoine", age: 30)
    print(viewModel.oldest as Any)
    
    // A lazy variable which is only called once:
    print(viewModel.oldest)
}
