//
//  BoxOfficeNetwork.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/27.
//

import Foundation
import RxSwift

class BoxOfficeNetwork {
    private let session : URLSession
    let api = BoxOfficeAPI()
    
    init(session : URLSession = .shared) {
        self.session = session
    }
    
    func getBoxOffice() -> Single<Result<BoxOfficeResponse,URLError>> {

        guard let url = api.getBoxOffice().url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                // json decoding
                do {
                    let boxOfficeData = try JSONDecoder().decode(BoxOfficeResponse.self, from: data)
                    return .success(boxOfficeData)
                } catch {
                    return
                        .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in
            .just(Result.failure(URLError(.cannotLoadFromNetwork)))
            }
            .asSingle()
    }

}
