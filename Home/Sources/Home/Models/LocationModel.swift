//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

struct LocationModel {
    let title: String
    let subTitle: String
    let latitude: Double
    let longitude: Double
}

extension LocationModel {
    init(_ dto: SearchLocationDTO) {
        self.title = dto.name
        self.subTitle = dto.state ?? dto.country
        self.latitude = dto.lat
        self.longitude = dto.lon
    }
}

extension LocationModel: Identifiable, Hashable {
    var id: UUID { .init() }
}
