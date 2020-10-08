//
//  ErrorMessages.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 06.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername     = "Создан некорректный запрос. Попробуйте снова."
    case unableToComplete    = "Невозможно выполнить запрос. Проверьте соединение с интернетом."
    case invalidResponse     = "Некорректный ответ сервера. Попробуйте снова."
    case invalidData         = "Получены некорректные данные от сервера."
}
