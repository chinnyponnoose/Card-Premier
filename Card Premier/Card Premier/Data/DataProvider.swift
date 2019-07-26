//
//  ViewController.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/23/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import Foundation
struct DataProvider {
    static func staticData() -> Data? {
        guard let path = Bundle.main.path(forResource: "StaticData", ofType: "json") else {
            return nil
        }

        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}
