//
//  Pagination.swift
//  ios-swiftui-pagination-api-call
//
//  Created by Ankit Solanki on 25/11/20.
//

import SwiftUI
import Alamofire
import URLImage

struct UsersListScreen: View {
    @State var isShowToast = false
    @State var toastMessage = ""
    @State var userDetails: [UserDetails] = [UserDetails]()
    @State var page: Int = 1
    @State var stopLoading = false
    
    //types of navigating to other view
    //https://stackoverflow.com/questions/57311918/how-to-go-to-another-view-with-button-click
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(0..<userDetails.count, id: \.self, content: {index in
                        UserItemView(user: userDetails[index])
                            .onAppear {
                                if index == (userDetails.count - 1) {
                                    //if last item then call api with next page
                                    getUsers()
                                }
                            }
                    })
                    
                    HStack {
                        Spacer()
                        if stopLoading {
                            Text("End of list")
                        } else {
                            ProgressView()
                        }
                        Spacer()
                    }
                }
                
                .navigationBarTitle("Users")
                
                .onAppear(){
                    getUsers()
                }
            }
            
        }
        .popup(isPresented: $isShowToast, type: .toast, position: .bottom,autohideIn: 2) {
            Utility.toast(text: toastMessage)
        }
    }
    
    func getUsers(){
        if Reachability.isConnectedToInternet {
            let parameters: [String: String] = [
                "page": page.description,
            ]
            let headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            let request = AF.request(AppStrings.USERS,
                                     method: .get,
                                     parameters: parameters,
                                     //encoding: JSONEncoding.default,  // remove this if need paramenter for get call
                                     headers: headers)
            request.responseDecodable(of: UsersResponse.self) { (response) in
                print(response.debugDescription)
                guard let apiResponse = response.value else { return }
                if apiResponse.data.count > 0 {
                    self.userDetails.append(contentsOf: apiResponse.data)
                    self.page += 1
                }
                self.stopLoading = (apiResponse.total == self.userDetails.count)
            }
        } else {
            toastMessage = AppStrings.noInternet
            isShowToast.toggle()
        }
    }
}

struct UserItemView: View {
    @State var user: UserDetails!
    
    var body: some View {
        NavigationLink(destination: UsersDetailsScreen(user: user)) {
            HStack (spacing: CGFloat(16)) {
                
                URLImage(url: URL(string: user.avatar)!,
                         content: { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .shadow(radius: 3)
                         })
                
                VStack (alignment: .leading, spacing: CGFloat(0)) {
                    Text(user.firstName + " " + user.lastName)
                        .font(.headline)
                        .bold()
                    Text(user.email)
                        .font(.subheadline)
                }
            }
            .frame(height: 70, alignment: .leading)
        }
    }
}

struct Pagination_Previews: PreviewProvider {
    static var previews: some View {
        UsersListScreen()
    }
}

