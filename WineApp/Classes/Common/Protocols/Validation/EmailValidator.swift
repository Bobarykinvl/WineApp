//
//  EmailValidator.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 11.08.21.
//

import RxSwift
import RxCocoa

enum TextFieldValidationComponents {
    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let matches = "SELF MATCHES %@"
}

final class EmailValidator {

    func validate(_ input: String) -> Bool {
        guard
            let regex = try? NSRegularExpression(
                pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                options: [.caseInsensitive]
            )
        else {
            assertionFailure("Regex not valid")
            return false
        }

        let regexFirstMatch = regex
            .firstMatch(
                in: input,
                options: [],
                range: NSRange(location: 0, length: input.count)
            )

        return regexFirstMatch != nil
    }
    
    func checkValidEmail(email: String) -> Bool {
        NSPredicate(format: TextFieldValidationComponents.matches, TextFieldValidationComponents.emailRegEx).evaluate(with: email)
    }
}
