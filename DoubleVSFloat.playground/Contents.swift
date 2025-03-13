import UIKit

struct FloatValueModel {
    var value: Float
}

extension Float {
    var cleanValue: String {
        return Int(self.truncatingRemainder(dividingBy: 1)) == 0 ? String(format: "%.2f", self) : String(self)
    }
}

func exampleOne() {
    let valueOne = FloatValueModel(value: 10.99)
    print(valueOne)
    print(valueOne.value.cleanValue)
}


exampleOne()
