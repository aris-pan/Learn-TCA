//
//  ErrorView.swift
//  LearnTCA
//
//  Created by Aris on 4/4/23.
//

import SwiftUI

struct ErrorView: View {
  var message: String
  var retryAction: () -> Void
  
  var body: some View {
    VStack {
      Text(":(")
        .font(.custom("AmericanTypewriter", size: 50))
      Text("")
      Text(message)
        .font(.custom("AmericanTypewriter", size: 25))
      Button {
        retryAction()
      } label: {
        Text("Retry")
          .font(.custom("AmericanTypewriter", size: 25))
          .foregroundColor(.white)
      }
      .frame(width: 100, height: 60)
      .background(.blue)
      .cornerRadius(10)
      .padding()
    }
  }
}

struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView(
      message: "Oops something went wrong",
      retryAction: {}
    )
  }
}
