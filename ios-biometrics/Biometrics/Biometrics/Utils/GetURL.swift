//
//  GetURL.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation

func getURL(route: String) -> URL {
    let importedURL = try! String(contentsOf: Bundle.main.url(forResource: "url", withExtension: "txt")!)
    
    return URL(string: importedURL + route)!
}
