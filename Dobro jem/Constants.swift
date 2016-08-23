//
//  Constants.swift
//  Dobro jem
//
//  Created by Ziga Strgar on 22/08/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import Foundation

let URL_BASE = "http://dobro-jem.si/api/"
let API_VERSION = "v2"
let RESTAURANTS = "/restaurants"
let RESTAURANT = "/restaurant/"
let LOGIN = "/login/"
let COMMENT = "/comment/"
let RATE = "/rate/"
let SOCIAL = "/social/"
let REGISTER = "/register/"
let LIKE = "/like/"

let API_KEY = "wmbh3EvV2ftSNyYFTfSlh402Tdo0XtMvUN8A0n1L"
let KEY = "?api_key=\(API_KEY)"

let URL_API = "\(URL_BASE)\(API_VERSION)"

typealias DownloadComplete = () -> ()