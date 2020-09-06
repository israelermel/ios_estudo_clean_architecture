//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Israel Ermel on 02/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Validation

class EmailValidatorSpy: EmailValidator {
      var isValid = true
      var email: String?
      
      func isValid(email: String) -> Bool {
          self.email = email
          return isValid
      }
      
      func simulateInvalidEmail() {
          isValid = false
      }
  }
