//
//  UsersDetailsScreen.swift
//  ios-swiftui-pagination-api-call
//
//  Created by Ankit Solanki on 25/11/20.
//

import SwiftUI
import URLImage

struct UsersDetailsScreen: View {
    @State var user: UserDetails!
    
    var body: some View {
        NavigationView {
            VStack (spacing: CGFloat(16)) {
                URLImage(url: URL(string: user.avatar)!,
                         content: { image in
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                                .shadow(radius: 10)
                         })
                
                Text(user.firstName + " " + user.lastName)
                    .font(.title)
                    .bold()
                Text(user.email)
                    .font(.headline)
                
                Spacer()
            }
        }
    }
}

struct UsersDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UsersDetailsScreen()
    }
}
