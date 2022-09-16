//
//  SeekingAlphaViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/15.
//

import Foundation

struct SeekingAlphaItem: Hashable {
    var title: String
    var link : String
    var pubDate: Date

    init(details: [String: Any]) {
        title = details["title"] as? String ?? ""
        link = details["link"] as? String ?? ""
        pubDate = details["pubDate"] as? Date ?? Date.now
    }
}

class SeekingAlphaViewModel: NSObject, ObservableObject {
    
    @Published var items = [SeekingAlphaItem]()
    
    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var pictureCount = 1
    
    func loadData(symbol: String) {
        let urlString = URL(string: "https://seekingalpha.com/api/sa/combined/\(symbol).xml")!
    
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

extension SeekingAlphaViewModel: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {

        if elementName == "item" {
            xmlDict = [:]
        }
        else {
            currentElement = elementName
        }
        
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if xmlDict[currentElement] == nil {
                xmlDict.updateValue(string, forKey: currentElement)
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        //The closing tag is presented as `elementName` in this function
        if elementName == "item" {
            xmlDictArr.append(xmlDict)
        }
        
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        //Called when the parsing is complete
        parsingCompleted()
    }

    func parsingCompleted() {
        DispatchQueue.main.async {
            self.items = self.xmlDictArr.map { SeekingAlphaItem(details: $0) }
        }
    }
}
