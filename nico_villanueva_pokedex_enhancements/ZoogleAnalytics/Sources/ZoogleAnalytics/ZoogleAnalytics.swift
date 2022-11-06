public struct ZoogleAnalyticsEvent {
    let key: String
    let parameters: [String: String]

    public init(key: String, parameters: [String : String] = [:]) {
        self.key = key
        self.parameters = parameters
    }
}


public final class ZoogleAnalytics {

    public static let shared = ZoogleAnalytics()

    private init() {}

    public func log(event: ZoogleAnalyticsEvent) {
        print("Logging to Zoogle analytics: \(event)")
    }
}
