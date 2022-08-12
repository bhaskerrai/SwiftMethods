import UIKit

// https://cocoacasts.com/swift-fundamentals-what-is-the-difference-between-instance-methods-and-type-methods-in-swift

//difference b/w instance method and type method


class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

/*
The Counter class defines three instance methods:

increment() increments the counter by 1.
increment(by: Int) increments the counter by a specified integer amount.
reset() resets the counter to zero.
*/


//The Self Property:
/*
 “The increment() method in the example above could have been written like this:
 func increment() {
     self.count += 1
 }

 In practice, you don’t need to write self in your code very often. If you don’t explicitly write self, Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method.
*/


//The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance.

struct New {
    var x = 78
    
    func myFunc(x: Int) -> Int {
        
//        return self.x   //this prints 78
        return x         //this prints 55
    }
}

let abc = New()
print(abc.myFunc(x: 55))




//Modifying Value Types from Within Instance Methods

//Structures and enumerations are value types. By default, the properties of a value type can’t be modified from within its instance methods.

//However, if you need to modify properties of a struct or enumeration, you can do it by placing "mutating" keyword before the "func" keyword in instance method.


struct New2 {
    
    var x: Int = 55
    var y: Int = 44
    
    mutating func modif(a:Int, b:Int) {
        x += a
        y += b
    }
}

var s = New2()
s.modif(a: 45, b: 56)

print("changed x is: \(s.x) and changed y is: \(s.y)")

//Instead of returning a new point, this method actually modifies the point on which it’s called. The mutating keyword is added to its definition to enable it to modify its properties.

//“Note that you can’t call a mutating method on a constant of structure type, because its properties can’t be changed, even if they’re variable properties”

//let s2 = New2()
//s2.modif(a: 45, b: 56) //this will give error.


//Assigning to self Within a Mutating Method
//Mutating methods can assign an entirely new instance to the implicit self property. The New2 example shown above could have been written in the following way instead:

struct New3 {
    var x = 55, y = 44
    
    mutating func myFunc(a: Int, b: Int) {
        self = New3(x: x + a, y: y + b)
    }
}

var s3 = New3()
s3.myFunc(a: 25, b: 46)

print(s3.x, s3.y)
//This version of the mutating moveBy(x:y:) method creates a new structure whose x and y values are set to the target location. The end result of calling this alternative version of the method will be exactly the same as for calling the earlier version.



//Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

//This example defines an enumeration for a three-state switch. The switch cycles between three different power states (off, low and high) every time its next() method is called.





//Type Methods
//You indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.

//Type methods are called with dot syntax, like instance methods. However, you call type methods on the type, not on an instance of that type. Here’s how you call a type method on a class called SomeClass:

class SomeClass {
    class func myFunc() {
        print("Hello")
    }
}

SomeClass.myFunc() //no need to creat a instance

struct SomeStruct {
    static func myFunc() {  //static for struct and enumerations
        print("Hello there!")
    }
}

SomeStruct.myFunc()



struct LevelTracker {
static var highestUnlockedLevel = 1
var currentLevel = 1

static func unlock(_ level: Int) {
    if level > highestUnlockedLevel { highestUnlockedLevel = level }
}

static func isUnlocked(_ level: Int) -> Bool {
    return level <= highestUnlockedLevel
}

@discardableResult
mutating func advance(to level: Int) -> Bool {
    if LevelTracker.isUnlocked(level) {
        currentLevel = level
        return true
    } else {
        return false
    }
}
}
