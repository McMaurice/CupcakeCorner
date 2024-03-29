//
//  Oder.swift
//  CupcakeCorner
//
//  Created by Macmaurice Osuji on 4/13/23.
//

import Foundation

//struct Request: Codable {
//     var type = 0
//     var quantity = 3
//     var extraFrosting = false
//     var addSprinkles = false
//
//     var name = ""
//     var streetAddress = ""
//     var city = ""
//     var zip = ""
//
//     var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//     }
//
//     var validAddress: Bool {
//        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            return false
//        }
//        return true
//    }
//
//    var cost: Double {
//        var cost = Double(quantity) * 2
//        cost += (Double(type) / 2)
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//        return cost
//    }
//}
//
//class Order: ObservableObject {
//    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
//
//    @Published var requests: [Request] {
//        didSet {
//            if let encoded = try? JSONEncoder().encode(requests) {
//                UserDefaults.standard.set(encoded, forKey: "requests")
//            }
//        }
//    }
//
//    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "requests") {
//            if let decodedItems = try? JSONDecoder().decode([Request].self, from: savedItems) {
//                requests = decodedItems
//                return
//            }
//        }
//
//        requests = []
//    }
//
//}

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }

    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]

    @Published var type = 0
    @Published var quantity = 3
    @Published var extraFrosting = false
    @Published var addSprinkles = false

    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""

    var validAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }

    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }

    init() { }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}
