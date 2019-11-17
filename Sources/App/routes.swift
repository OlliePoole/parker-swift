import Routing
import Vapor

public func routes(_ router: Router) throws {

    router.post("analyse") { req -> Future<PolicyResponse> in
        
        let rawPolicy = try req.content.syncDecode(AnalysisRequest.self).content
        
        guard let policy = PolicyRepository.loadPolicy(rawPolicy) else {
            throw Abort(.notFound)
        }
        
        let batchedContent = StringBatchService.batch(string: policy, batchLength: 1024)

        let requests = batchedContent.map {
            return NLPRequest(documents: [
                NLPRequest.Document(language: "en", id: UUID().uuidString, text: $0)
            ])
        }
        
        let client = try req.client()
        
        return requests.map { request in
            return client.post("https://parker.cognitiveservices.azure.com/text/analytics/v2.1/keyPhrases",
                        headers: HTTPHeaders([("Ocp-Apim-Subscription-Key", "9f15461943a84e909570b6b44cefbf11")]), beforeSend: { req in
                                                                
                try req.content.encode(request, as: .json)
            })
            
        }.flatten(on: req)
            .map(to: NLPResponse.self) { results in
                                
                let parsedItems = try results
                    .compactMap { $0.http.body.data }
                    .map { try JSONDecoder().decode(NLPResponse.self, from: $0) }
                                
                return NLPResponse(documents: parsedItems.flatMap { $0.documents })
                
        }.map(to: DocumentClassifier.Classification.self) { response in
            return DocumentClassifier.classify(response: response)
            
        }.map(to: PolicyResponse.self) { classification in
            
            let redItems: [PolicyResponse.PolicyItem] = classification.redWarnings.compactMap {
                guard let image = ImageResolutionService.resolve(for: $0) else {
                    return nil
                }
                
                guard let description = DescriptionResolver.resolveDescripton(for: $0) else {
                    return nil
                }
                
                return PolicyResponse.PolicyItem(title: $0, iconURL: image, description: description, priority: .red)
            }
            
            let amberItems: [PolicyResponse.PolicyItem] = classification.amberWarnings.compactMap {
                guard let image = ImageResolutionService.resolve(for: $0) else {
                    return nil
                }
                
                guard let description = DescriptionResolver.resolveDescripton(for: $0) else {
                    return nil
                }
                
                return PolicyResponse.PolicyItem(title: $0, iconURL: image, description: description, priority: .amber)
            }
            
            return PolicyResponse(items: redItems + amberItems)
        }
    }
}
