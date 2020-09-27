//
//  Seeds.swift
//  WeatherVIPTests
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

struct Seeds {
    static let forecastJson = """
        {\"coord\":{\"lon\":-122.08,\"lat\":37.39},\"weather\":[{\"id\":800,\"main\":\"Clear\",
        \"description\":\"clear sky\",\"icon\":\"01d\"}],
            \"base\":\"stations\",\"main\":{\"temp\":282.55,\"feels_like\":281.86,\"temp_min\":280.37,
        \"temp_max\":284.26,\"pressure\":1023,\"humidity\":100},\"visibility\":16093,\"wind\":
        {\"speed\":1.5,\"deg\":350},\"clouds\":{\"all\":1},
        \"dt\":1560350645,\"sys\":{\"type\":1,\"id\":5122,\"message\":0.0139,
        \"country\":\"US\",\"sunrise\":1560343627,
        \"sunset\":1560396563},\"timezone\":-25200,\"id\":420006353,\"name\":\"Mountain View\",\"cod\":200}
        """
    static let forecastListJson = """
        {\"list\":[{\"dt\":1596564000,\"main\":{\"temp\":293.55,\"feels_like\":293.13,\"temp_min\":293.55,
        \"temp_max\":294.05,\"pressure\":1013,\"sea_level\":1013,\"grnd_level\":976,\"humidity\":84,\"temp_kf\":-0.5},
        \"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],
        \"clouds\":{\"all\":38},\"wind\":{\"speed\":4.35,\"deg\":309},
        \"visibility\":10000,\"pop\":0.49,\"rain\":{\"3h\":0.53},\"sys\":{\"pod\":\"d\"},
        \"dt_txt\":\"2020-08-04 18:00:00\"},{\"dt\":1596564000,
        \"main\":{\"temp\":293.55,\"feels_like\":293.13,\"temp_min\":293.55,\"temp_max\":294.05,\"pressure\":1013,
        \"sea_level\":1013,\"grnd_level\":976,\"humidity\":84,\"temp_kf\":-0.5},\"weather\":[{\"id\":500,
        \"main\":\"Rain\",
        \"description\":\"light rain\",\"icon\":\"10d\"}],
        \"clouds\":{\"all\":38},\"wind\":{\"speed\":4.35,\"deg\":309},
        \"visibility\":10000,\"pop\":0.49,\"rain\":{\"3h\":0.53},
        \"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-08-04 06:00:00\"}]}
        """
}
