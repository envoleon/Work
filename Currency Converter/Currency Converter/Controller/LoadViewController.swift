//
//  LoadViewController.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 31.07.2022.
//

import UIKit

class LoadViewController: UIViewController {

    private var loadSize = LoadSize.shared
    private var currencieTables = CurrencieTables.shared
    private var elementName: String?
    private var numValute = -1

    private lazy var navigation: (UIViewController, String, String) -> UINavigationController = { [self] in
        let navigation = UINavigationController(rootViewController: $0)
        navigation.tabBarItem.title = $1
        let font = UIFont(name: "Currency-Converter", size: loadSize.font)
        navigation.tabBarItem.image = $2.image(withAttributes: [ .foregroundColor: UIColor.red, .font: font as Any])
        return navigation
    }

    private let tabBar: (String, String, String, [UINavigationController]) -> UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = UIColor(named: $0)
        tabBar.tabBar.tintColor = UIColor(named: $1)
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: $2)
        tabBar.viewControllers = $3
        return tabBar
    }

    private let indicator = ActivityIndicator()

    override func loadView() {
        view = indicator
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "ColorGray3")

        loadFile()
    }

    func loadFile() {

        let url = URL(string: "http://www.cbr.ru/scripts/XML_daily.asp")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in

            if let error = error {
                print("Error took place \(error)")
                DispatchQueue.main.async { [self] in
                    loadFile()
                }
                return
            }

            let xml = XMLParser(data: data!)
            xml.delegate = self
            xml.parse()

            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: { [self] in
                    self.navigationController?.popViewController(animated: true)

                    UIApplication.shared.windows.first?.rootViewController = self.tabBar("ColorGray1", "ColorOrange", "ColorGray2", [
                        self.navigation(MainViewController(), "Converter", "A"),
                        self.navigation(NewsViewController(), "News", "E"),
                        self.navigation(FavouritesViewController(), "Favourites", "B"),
                        self.navigation(ProfileViewController(), "Profile", "C")
                    ])

                    currencieTables.initSettings()

                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                })
            }

        }
        task.resume()
    }

}

// MARK: - XMLParserDelegate

extension LoadViewController: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "Valute" {
            numValute += 1
            currencieTables.currencie?.append(CurrencieTables.CurrencieTable())
        }

        self.elementName = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        var data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if !data.isEmpty {
            if elementName == "NumCode" {
                currencieTables.currencie![numValute].numCode = Float(data)!
            } else if elementName == "CharCode" {
                currencieTables.currencie![numValute].charCode = data
            } else if elementName == "Nominal" {
                currencieTables.currencie![numValute].nominal = Float(data)!
            } else if elementName == "Name" {
                currencieTables.currencie![numValute].name = data
            } else if elementName == "Value" {
                data = data.replacingOccurrences(of: ",", with: ".")
                currencieTables.currencie![numValute].value = Float(data)!
            }
        }
    }
}
