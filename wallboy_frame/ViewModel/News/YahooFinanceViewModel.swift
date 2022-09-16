//
//  YahooFinanceViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/05.
//

// MARK: 여기서 야후 rss 주소 찾음
// reference address : https://blog.feedspot.com/yahoo_rss_feeds/

import Foundation

struct YFItem: Hashable {
    var title: String
    var link : String
    var pubDate: Date
    var source: String
    var media: String

    init(details: [String: Any]) {
        title = details["title"] as? String ?? ""
        link = details["link"] as? String ?? ""
        pubDate = details["pubDate"] as? Date ?? Date.now
        source = details["source"] as? String ?? ""
        media = details["media:content"] as? String ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6wHc3OzKebPw9iQ9NMcjKRHSxIFKN2Ds2LQ&usqp=CAU"
    }
}

class YahooFinanceViewModel: NSObject, ObservableObject {

    @Published var items = [YFItem]()
    
    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var pictureCount = 1
    
    var media = ""

    func loadData() {
        let urlString = URL(string: "https://finance.yahoo.com/news/rssindex")!
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

extension YahooFinanceViewModel: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {

        if elementName == "item" {
            xmlDict = [:]
        }
        else {
            currentElement = elementName
        }
        
        if elementName == "media:content" {
            self.media = attributeDict["url"]!
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
            xmlDict["media:content"] = self.media
            xmlDictArr.append(xmlDict)
        }
        
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        //Called when the parsing is complete
        parsingCompleted()
    }

    func parsingCompleted() {
        DispatchQueue.main.async {
            self.items = self.xmlDictArr.map { YFItem(details: $0) }
        }
    }
}
