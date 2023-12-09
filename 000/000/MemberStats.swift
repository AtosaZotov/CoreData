import UIKit
import Foundation

struct ConfigCardPaymentDTO: Codable {
    let configId: Int
    let configItems: [ConfigItem]
    
    
}

struct ConfigItem: Codable {
    let a: String
    let b: String?
    let c: String?
    let d: String?
    let e: String?
    let f: String?
    let g: Int
    let h: String?
    let i: Bool
    
}

struct BankListDTO: Codable {
    let bankList: [String]
}

