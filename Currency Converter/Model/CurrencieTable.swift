//
//  CurrencieTable.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 30.07.2022.
//

import UIKit

struct CurrencieTable {
    var numCode = 0
    var charCode = ""
    var nominal = 0
    var name = ""
    var value: Float = 0.0
    var isFavourite = false

}

struct InputTableSetting {
    var table: CurrencieTable
    var isCurrent = false
    var num = "1.0"
}

var currencieTables: [CurrencieTable]? = []
var filteredCurrencieTables: [CurrencieTable]? = []
var favouritesCurrencieTables: [CurrencieTable]? = []

var inputCurrencieTables: [InputTableSetting]? = []


func calcCurrency() -> String {

    let index = inputCurrencieTables![0].isCurrent ? 0 : 1
    let outher = inputCurrencieTables![1].isCurrent ? 0 : 1

    let cur1 = Float(inputCurrencieTables![index].table.value) / Float(inputCurrencieTables![index].table.nominal) * Float(inputCurrencieTables![index].num)!
    let cur2 = Float(inputCurrencieTables![outher].table.nominal) / Float(inputCurrencieTables![outher].table.value)
    let num = cur2 * cur1

    return "\(inputCurrencieTables![index].num) \(inputCurrencieTables![index].table.charCode) = \(num) \(inputCurrencieTables![outher].table.charCode)"
}
