import UIKit

struct FloatValueModel {
    var value: Float
}

extension Float {
    var cleanValue: String {
        return Int(self.truncatingRemainder(dividingBy: 1)) == 0 ? String(format: "%.2f", self) : String(self)
    }
}

func exampleFloatOne() {
    let valueOne = FloatValueModel(value: 10.9999)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

func exampleFloatTwo() {
    let valueOne = FloatValueModel(value: 9999.9999)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

func exampleFloatThree() {
    let valueOne = FloatValueModel(value: 698799.33)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

func exampleFloatFour() {
    let valueOne = FloatValueModel(value: 9999999.99)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

struct DoubleValueModel {
    var value: Double
}

extension Double {
    var cleanValue: String {
        return Int(self.truncatingRemainder(dividingBy: 1)) == 0 ? String(format: "%.2f", self) : String(self)
    }
}

func exampleDoubleOne() {
    let valueOne = DoubleValueModel(value: 9999999.99)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

func exampleDoubleTwo() {
    let valueOne = DoubleValueModel(value: 698799.33)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

func exampleDoubleThree() {
    let valueOne = DoubleValueModel(value: 8888888.88)
    print(valueOne)
    print(valueOne.value.cleanValue)
}

func exampleDoubleFour() {
    let valueOne = DoubleValueModel(value: 999999999999999999999999.99)
    print(valueOne)
    print(valueOne.value.cleanValue)
}



//exampleFloatOne()
//exampleFloatTwo()
//exampleFloatThree()
//exampleFloatFour()

//exampleDoubleOne()
//exampleDoubleTwo()
//exampleDoubleThree()
//exampleDoubleFour()
