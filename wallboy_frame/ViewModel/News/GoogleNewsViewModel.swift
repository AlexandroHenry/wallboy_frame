//
//  GoogleNewsViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/05.
//

import Foundation
import NaturalLanguage

struct GoogleNews: Hashable {
    var title: String
    var link: String
    var pubDate: Date
    var source: String
    
    init(details: [String: Any]) {
        title = details["title"] as? String ?? ""
        link = details["link"] as? String ?? ""
        pubDate = details["pubDate"] as? Date ?? Date.now
        source = details["source"] as? String ?? ""
    }
}

class GoogleNewsViewModel: NSObject, ObservableObject {
    
    @Published var news = [GoogleNews]()
    
    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var pictureCount = 1
    
    func loadUSNews(searchText: String) {
        
        // 새로운 검색시 모든 거 다 지워줌
        xmlDictArr.removeAll()
        let request = URLRequest(url: URL(string: "https://news.google.com/rss/search?q=\(searchText)&hl=en&gl=EN&ceid=EN:en")!)
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
    
    func loadKRNews(searchText: String) {
        
        // 새로운 검색시 모든 거 다 지워줌
        xmlDictArr.removeAll()
        let request = URLRequest(url: URL(string: "https://news.google.com/rss/search?q=\(searchText)&hl=ko&gl=KR&ceid=KR:ko")!)

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

extension GoogleNewsViewModel: XMLParserDelegate {
    
    // 태그의 시작
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        if elementName == "item" {
            xmlDict = [:]
        }
        else {
            currentElement = elementName
        }
    }

    // 태그 사이의 문자열
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //The value of current parsed tag is presented as `string` in this function

        var languageDetector = detectedLanguage(for: string)
        
        if languageDetector == Optional("한국어") {
         
            xmlDict.updateValue(string, forKey: currentElement)
            
        } else {

            if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                if xmlDict[currentElement] == nil {
                    xmlDict.updateValue(string, forKey: currentElement)
                }
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
            self.news = self.xmlDictArr.map { GoogleNews(details: $0) }
        }
    }
    
    func detectedLanguage<T: StringProtocol>(for string: T) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(String(string))
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
    }
}
