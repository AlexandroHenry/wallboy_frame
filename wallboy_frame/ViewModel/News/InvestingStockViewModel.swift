//
//  InvestingStockViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/05.
//

// MARK: Investing.com rss
// reference address : https://www.investing.com/webmaster-tools/rss

import Foundation

struct InvestingStock: Hashable {
    var enclosure: String
    var title: String
    var pubDate: Date
    var author: String
    var link: String

    init(details: [String: Any]) {
        enclosure = details["enclosure"] as? String ?? ""
        title = details["title"] as? String ?? ""
        pubDate = details["pubDate"] as? Date ?? Date.now
        author = details["author"] as? String ?? ""
        link = details["link"] as? String ?? ""
    }
}

class InvestingStockViewController: NSObject, ObservableObject {
    
    @Published var items = [InvestingStock]()
    
    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var pictureCount = 1
    
    var imageURL = ""
    
    func loadData() {
        let urlString = URL(string: "https://www.investing.com/rss/news_25.rss")!
//        let urlString = URL(string: "https://www.investing.com/rss/news_285.rss")!
//        let urlString = URL(string: "https://www.investing.com/rss/news.rss")!
    
        let request = URLRequest(url: urlString)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("dataTaskWithRequest Error: \(error)")
                return
            }

            guard let data = data else {
                print("dataTaskWithRequest data is nil")
                return
            }

            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()

        }
        task.resume()
    }
    
}

extension InvestingStockViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {

        if elementName == "item" {
            xmlDict = [:]
        }
        else {
            currentElement = elementName
        }
        
        if elementName == "enclosure"{
            self.imageURL = attributeDict["url"]!
        }

    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //The value of current parsed tag is presented as `string` in this function
        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if xmlDict[currentElement] == nil {
                xmlDict.updateValue(string, forKey: currentElement)
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        //The closing tag is presented as `elementName` in this function
        if elementName == "item" {
            xmlDict["enclosure"] = self.imageURL
            xmlDictArr.append(xmlDict)
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        //Called when the parsing is complete
        parsingCompleted()
    }

    func parsingCompleted() {
        DispatchQueue.main.async {
            self.items = self.xmlDictArr.map { InvestingStock(details: $0) }
        }
    }
}
