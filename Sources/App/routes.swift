import Routing
import Vapor

public func routes(_ router: Router) throws {

    router.post("analyse") { req -> Future<PolicyResponse> in
        
        let privacyContent = try req.content.syncDecode(AnalysisRequest.self).content
        
        let itemOne = PolicyResponse.PolicyItem(
            title: "Microphone",
            iconURL: "https://image.flaticon.com/icons/svg/149/149427.svg",
            description: "Hello? Hello? Can you hear me?",
            priority: .red)
        
        let itemTwo = PolicyResponse.PolicyItem(
            title: "Contacts",
            iconURL: "https://image.flaticon.com/icons/svg/902/902765.svg",
            description: "Ollie has invited you to play FarmVille",
            priority: .amber)
        
        let headers: HTTPHeaders = HTTPHeaders([
            ("Content-Type", "application/json"),
            ("Ocp-Apim-Subscription-Key", "9f15461943a84e909570b6b44cefbf11")]
        )
        
        let client = HTTPClient.connect(
            hostname: "https://parker.cognitiveservices.azure.com",
            on: req)
        
        let batchedContent = StringBatchService.batch(string: privacyContent, batchLength: 1024)
        
        let requests = batchedContent.map(to: NLPRequest.self, on: <#T##Worker#>, <#T##callback: ([S]) throws -> T##([S]) throws -> T#>)
        
        let requests = batchedContent.map(to: NLPRequest.self) {
            return NLPRequest(documents: [
                NLPRequest.Document(language: "en", id: UUID().uuidString, text: $0)
            ])
            }
            .flatMap(to: Response.self) { request in

                let body = HTTPBody(data: try! JSONEncoder().encode(request))
                let httpReq = HTTPRequest(
                    method: .POST,
                    url: URL(string: "/text/analytics/v2.1/keyPhrases")!,
                    headers: headers,
                    body: body)

                return client.send(httpReq)
        }

        
    
        
        
        // TODO: Find matches
        // TODO: return result below
        
        return Future.map(on: req) { return PolicyResponse(items: [itemOne, itemTwo]) }
    }
}

//private func request(_ request: NLPRequest, incomingRequest: Request) -> Future<NLPResponse> {
//

//
//}
