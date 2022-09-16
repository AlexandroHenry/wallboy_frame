//
//  StockInfo.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/16.
//

import Foundation

struct StockInfo: Codable {
    let zip: String
    let sector: String
    let fullTimeEmployees: Int
    let longBusinessSummary: String
    let city: String
    let phone: String
    let state: String
    let country: String
    let website: String
    let address1: String
    let industry: String
    let ebitdaMargins: Double
    let profitMargins: Double
    let grossMargins: Double
    let operatingCashflow: Int
    let revenueGrowth: Double
    let operatingMargins: Double
    let ebitda: Int
    let targetLowPrice: Int
    let recommendationKey: String
    let grossProfits: Int
    let freeCashflow: Int
    let targetMedianPrice: Int
    let currentPrice: Double
    let earningsGrowth: Double
    let currentRatio: Double
    let returnOnAssets: Double
    let numberOfAnalystOpinions: Int
    let targetMeanPrice: Double
    let debtToEquity: Double
    let returnOnEquity: Double
    let targetHighPrice: Int
    let totalCash: Int
    let totalDebt: Int
    let totalRevenue: Int
    let totalCashPerShare: Double
    let financialCurrency: String
    let revenuePerShare: Double
    let quickRatio: Double
    let recommendationMean: Double
    let exchange: String
    let shortName: String
    let longName: String
    let exchangeTimezoneName: String
    let exchangeTimezoneShortName: String
    let isEsgPopulated: Bool
    let gmtOffSetMilliseconds: String
    let quoteType: String
    let symbol: String
    let messageBoardID: String
    let market: String
    let enterpriseToRevenue: Double
    let enterpriseToEbitda: Double
    let the52WeekChange: Double
    let forwardEps: Double
    let sharesOutstanding: Int
    let bookValue: Double
    let sharesShort: Int
    let sharesPercentSharesOut: Double
    let lastFiscalYearEnd: Int
    let heldPercentInstitutions: Double
    let netIncomeToCommon: Int
    let trailingEps: Double
    let sandP52WeekChange: Double
    let priceToBook: Double
    let heldPercentInsiders: Double
    let nextFiscalYearEnd: Double
    let mostRecentQuarter: Double
    let shortRatio: Double
    let sharesShortPreviousMonthDate: Double
    let floatShares: Double
    let beta: Double
    let enterpriseValue: Double
    let lastSplitDate: Int
    let lastSplitFactor: String
    let earningsQuarterlyGrowth: Double
    let priceToSalesTrailing12Months: Double
    let dateShortInterest: Int
    let pegRatio: Double
    let forwardPE: Double
    let shortPercentOfFloat: Double
    let sharesShortPriorMonth: Double
    let impliedSharesOutstanding: Double
    let previousClose: Double
    let regularMarketOpen: Double
    let twoHundredDayAverage: Double
    let trailingAnnualDividendYield: Double
    let payoutRatio: Double
    let regularMarketDayHigh: Double
    let averageDailyVolume10Day: Int
    let regularMarketPreviousClose: Double
    let fiftyDayAverage: Double
    let trailingAnnualDividendRate: Double
//    let stockInfoOpen: Double
    let averageVolume10Days: Double
    let dividendRate: Double
    let regularMarketDayLow: Double
    let currency: String
    let trailingPE: Double
    let regularMarketVolume: Int
    let marketCap: Int
    let averageVolume: Int
    let dayLow: Double
    let ask: Int
    let askSize: Int
    let volume: Int
    let fiftyTwoWeekHigh: Double
    let fiftyTwoWeekLow: Double
    let bid: Int
    let tradeable: Bool
    let bidSize: Int
    let dayHigh: Double
    let regularMarketPrice: Double
    let logo_url: String
    let trailingPegRatio: Double

//    enum CodingKeys: String, CodingKey {
//        case zip, sector, fullTimeEmployees, longBusinessSummary, city, phone, state, country, website, maxAge, address1, industry, ebitdaMargins, profitMargins, grossMargins, operatingCashflow, revenueGrowth, operatingMargins, ebitda, targetLowPrice, recommendationKey, grossProfits, freeCashflow, targetMedianPrice, currentPrice, earningsGrowth, currentRatio, returnOnAssets, numberOfAnalystOpinions, targetMeanPrice, debtToEquity, returnOnEquity, targetHighPrice, totalCash, totalDebt, totalRevenue, totalCashPerShare, financialCurrency, revenuePerShare, quickRatio, recommendationMean, exchange, shortName, longName, exchangeTimezoneName, exchangeTimezoneShortName, isEsgPopulated, gmtOffSetMilliseconds, quoteType, symbol
//        case messageBoardID = "messageBoardId"
//        case market, enterpriseToRevenue, enterpriseToEbitda
//        case the52WeekChange = "52WeekChange"
//        case forwardEps, sharesOutstanding, bookValue, sharesShort, sharesPercentSharesOut, lastFiscalYearEnd, heldPercentInstitutions, netIncomeToCommon, trailingEps
//        case sandP52WeekChange = "SandP52WeekChange"
//        case priceToBook, heldPercentInsiders, nextFiscalYearEnd, mostRecentQuarter, shortRatio, sharesShortPreviousMonthDate, floatShares, beta, enterpriseValue, lastSplitDate, lastSplitFactor, earningsQuarterlyGrowth, priceToSalesTrailing12Months, dateShortInterest, pegRatio, forwardPE, shortPercentOfFloat, sharesShortPriorMonth, impliedSharesOutstanding, previousClose, regularMarketOpen, twoHundredDayAverage, trailingAnnualDividendYield, payoutRatio, regularMarketDayHigh, averageDailyVolume10Day, regularMarketPreviousClose, fiftyDayAverage, trailingAnnualDividendRate
//        case stockInfoOpen = "open"
//        case averageVolume10Days = "averageVolume10days"
//        case exDividendDate, regularMarketDayLow, currency, trailingPE, regularMarketVolume, marketCap, averageVolume, dayLow, ask, askSize, volume, fiftyTwoWeekHigh, fiftyTwoWeekLow, bid, tradeable, bidSize, dayHigh, regularMarketPrice, preMarketPrice
//        case logoURL = "logo_url"
//        case trailingPegRatio
//    }
    
    init() {
        zip = ""
        sector = ""
        fullTimeEmployees = 0
        longBusinessSummary = ""
        city = ""
        phone = ""
        state = ""
        country = ""
        website = ""
        address1 = ""
        industry = ""
        ebitdaMargins = 0
        profitMargins = 0
        grossMargins = 0
        operatingCashflow = 0
        revenueGrowth = 0
        operatingMargins = 0
        ebitda = 0
        targetLowPrice = 0
        recommendationKey = ""
        grossProfits = 0
        freeCashflow = 0
        targetMedianPrice = 0
        currentPrice = 0
        earningsGrowth = 0
        currentRatio = 0
        returnOnAssets = 0
        numberOfAnalystOpinions = 0
        targetMeanPrice = 0
        debtToEquity = 0
        returnOnEquity = 0
        targetHighPrice = 0
        totalCash = 0
        totalDebt = 0
        totalRevenue = 0
        totalCashPerShare = 0
        financialCurrency = ""
        revenuePerShare = 0
        quickRatio = 0
        recommendationMean = 0
        exchange = ""
        shortName = ""
        longName = ""
        exchangeTimezoneName = ""
        exchangeTimezoneShortName = ""
        isEsgPopulated = false
        gmtOffSetMilliseconds = ""
        quoteType = ""
        symbol = ""
        messageBoardID = ""
        market = ""
        enterpriseToRevenue = 0
        enterpriseToEbitda = 0
        the52WeekChange = 0
        forwardEps = 0
        sharesOutstanding = 0
        bookValue = 0
        sharesShort = 0
        sharesPercentSharesOut = 0
        lastFiscalYearEnd = 0
        heldPercentInstitutions = 0
        netIncomeToCommon = 0
        trailingEps = 0
        sandP52WeekChange = 0
        priceToBook = 0
        heldPercentInsiders = 0
        nextFiscalYearEnd = 0
        mostRecentQuarter = 0
        shortRatio = 0
        sharesShortPreviousMonthDate = 0
        floatShares = 0
        beta = 0
        enterpriseValue = 0
        lastSplitDate = 0
        lastSplitFactor = ""
        earningsQuarterlyGrowth = 0
        priceToSalesTrailing12Months = 0
        dateShortInterest = 0
        pegRatio = 0
        forwardPE = 0
        shortPercentOfFloat = 0
        sharesShortPriorMonth = 0
        impliedSharesOutstanding = 0
        previousClose = 0
        regularMarketOpen = 0
        twoHundredDayAverage = 0
        trailingAnnualDividendYield = 0
        payoutRatio = 0
        regularMarketDayHigh = 0
        averageDailyVolume10Day = 0
        regularMarketPreviousClose = 0
        fiftyDayAverage = 0
        trailingAnnualDividendRate = 0
//        stockInfoOpen = 0
        averageVolume10Days = 0
        dividendRate = 0
        regularMarketDayLow = 0
        currency = ""
        trailingPE = 0
        regularMarketVolume = 0
        marketCap = 0
        averageVolume = 0
        dayLow = 0
        ask = 0
        askSize = 0
        volume = 0
        fiftyTwoWeekHigh = 0
        fiftyTwoWeekLow = 0
        bid = 0
        tradeable = false
        bidSize = 0
        dayHigh = 0
        regularMarketPrice = 0
        logo_url = ""
        trailingPegRatio = 0
    }
}
