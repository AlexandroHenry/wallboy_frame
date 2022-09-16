//
//  NewsView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI
import NaturalLanguage

struct NewsView: View {
    @StateObject var googleNewsVM = GoogleNewsViewModel()
    @StateObject var investingStockVM = InvestingStockViewController()
    @StateObject var yfVM = YahooFinanceViewModel()
    @State var showSafari = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                if searchText != "" {
                    ForEach(googleNewsVM.news, id: \.self) { item in
                        if item.title.count > 2 {
                            Button {
                                showSafari.toggle()
                            } label: {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text(item.source)
                                        Spacer()
                                    }
                                    .foregroundColor(.orange)
                                    
                                    Text(item.title)
                                        .foregroundColor(.primary)
                                        .lineSpacing(2)
                                    
                                    Text(convertDatetoString(date: item.pubDate))
                                        .foregroundColor(.secondary)
                                    
                                }
                                .foregroundColor(.primary)
                                .font(.callout)
                            }
                            .sheet(isPresented: $showSafari) {
                                SafariView(url: URL(string: item.link)!)
                            }
                        }
                    }
                } else {
                    
                    ForEach(investingStockVM.items, id: \.self) { item in
                        
                        Button {
                            self.showSafari = true
                        } label: {
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(item.author)
                                            .foregroundColor(.orange)
                                            .bold()
                                        Text(item.title)
                                        Text(convertDatetoString(date: item.pubDate))
                                            .foregroundColor(.secondary)
                                    }
                                    .foregroundColor(.primary)
                                    .font(.caption)
                                    
                                    Spacer()
                                    
                                    AsyncImage(
                                        url: URL(string: item.enclosure),
                                        content: { image in
                                            image
                                                .resizable()
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 120, maxHeight: 200)
                                        },
                                        placeholder: {
                                            ProgressView()
                                                .frame(maxWidth: 120, maxHeight: 200)
                                        }
                                    )
                                }
                            }
                        }
                        
                    }
                    
                    ForEach(yfVM.items, id: \.self) { item in
                        Button {
                            showSafari.toggle()
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text(item.source)
                                        Spacer()
                                    }
                                    .foregroundColor(.orange)
                                    
                                    Text(item.title)
                                        .foregroundColor(.primary)
                                    
                                    Text(convertDatetoString(date: item.pubDate))
                                        .foregroundColor(.secondary)
                                        
                                }
                                .foregroundColor(.primary)
                                .font(.caption)
                                
                                AsyncImage(
                                    url: URL(string: item.media),
                                    content: { image in
                                        image
                                            .resizable()
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 120, maxHeight: 200)
                                    },
                                    placeholder: {
                                        ProgressView()
                                            .frame(maxWidth: 120, maxHeight: 200)
                                    }
                                )
                                .padding(.leading, 10)
                            }
                        }
                        .sheet(isPresented: $showSafari) {
                            SafariView(url: URL(string: item.link)!)
                        }
                    }
                    
                }
            }
            .navigationTitle("뉴스")
        }
        .onAppear {
            investingStockVM.loadData()
            yfVM.loadData()
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            
            let lang = detectedLanguage(for: searchText)
            // 한글을 전송해줄경우 addingPercentEncoding 을 활용하자!!
            // 참고 : https://eeyatho.tistory.com/130
            if lang != Optional("Korean") {
                googleNewsVM.loadUSNews(searchText: searchText)
            } else {
                googleNewsVM.loadKRNews(searchText: searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            }
        }
    }
    
    func convertDatetoString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let convertDate = dateFormatter.string(from: date)
        
        return convertDate
    }
    
    func detectedLanguage<T: StringProtocol>(for string: T) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(String(string))
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
