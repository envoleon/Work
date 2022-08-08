//
//  CurrencieTable.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 30.07.2022.
//

import UIKit

final class CurrencieTables {

    static let shared = CurrencieTables()

    struct CurrencieTable {
        var numCode: Float = 0.0
        var charCode = ""
        var nominal: Float = 0.0
        var name = ""
        var value: Float = 0.0
        var isFavourite = false

    }

    struct InputTableSetting {
        var table: CurrencieTable
        var isCurrent = false
        var num = "0"
    }

    var currencie: [CurrencieTable]? = []
    var filtered: [CurrencieTable]? = []
    var favourites: [CurrencieTable]? = []

    var inputCurrencie: [InputTableSetting]? = []


    func initSettings() {
        // loadSettings

        if let tables = UserDefaults.standard.array(forKey: "favourites") {
            for name in tables {
                for i in 0..<currencie!.count {
                    if currencie![i].name == name as! String {
                        currencie![i].isFavourite = true
                    }
                }
            }
        }

        favourites = currencie!.filter{ $0.isFavourite }
        inputCurrencie?.append(InputTableSetting(table: currencie![0], isCurrent: true, num: "0"))
        inputCurrencie?.append(InputTableSetting(table: currencie![1], isCurrent: false, num: "0"))
    }

    func xmlToTable() {

    }

    func calcCurrency() -> String {

        lazy var index = inputCurrencie![0].isCurrent ? 0 : 1
        let outher = inputCurrencie![1].isCurrent ? 0 : 1

        let cur1 = inputCurrencie![index].table.value / inputCurrencie![index].table.nominal * Float(inputCurrencie![index].num)!
        let cur2 = inputCurrencie![outher].table.nominal / inputCurrencie![outher].table.value
        let num = cur2 * cur1
        

        return "\(inputCurrencie![index].num) \(inputCurrencie![index].table.charCode) = \(num) \(inputCurrencie![outher].table.charCode)"
    }

    private init() {}
}





