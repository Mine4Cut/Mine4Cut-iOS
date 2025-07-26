//
//  Logger.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/26/25.
//

import os

public enum Logger {
    public static func log(message: String) {
        os_log("\(message)")
    }
}
