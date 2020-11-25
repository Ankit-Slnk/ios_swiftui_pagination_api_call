# iOS SwiftUI Pagination & Api Call Demo

![Flutter Pagination & Api Call Demo](ios_swiftui_pagination_api_call.png)

This demo will show us how to call `post` and `get` HTTP request in iOS swiftUI. This will also show us how to use `pagination` in list.

## Setup

Use latest versions of below mentioned pods in `Podfile`.

| Pod | Explanation |
|-----|-------------|
| [Alamofire](https://github.com/Alamofire/Alamofire) | Alamofire is an HTTP networking library written in Swift. |
| [URLImage](https://github.com/dmytro-anokhin/url-image) | URLImage is a SwiftUI view that displays an image downloaded from provided URL. |

### Check internet connectivity

    import Foundation
    import Alamofire

    class Reachability {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            return self.sharedInstance.isReachable
        }
    }

### GET Request

    GET     https://reqres.in/api/users?page=<page_number>

Convert `JSON` response from this api to `swift class` using [quicktype](https://app.quicktype.io).

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
                                 //encoding: JSONEncoding.default,  // comment this if need paramenter for get call
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

### Show list of users in SwiftUI

    NavigationView {
        List {
            ForEach(0..<userDetails.count, id: \.self, content: {index in
                UserItemView(user: userDetails[index])
                    .onAppear {
                        if index == (userDetails.count - 1) {
                            //if last item then call api for next page
                            getUsers()
                        }
                    }
            })
                    
            HStack {
                Spacer()
                if stopLoading {
                    //show that there is end of list
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

##### Please refer to my [blogs](https://ankitsolanki.netlify.app/blog.html) for more information.