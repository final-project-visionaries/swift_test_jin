//
//  ContentView.swift
//  API_TEST
//
//  Created by user on 2023/12/18.
//

import SwiftUI
import Alamofire

var base64ToFront: Any = "11"//追加

struct ContentView: View {
    
    @State private var imagesData: [[String: Any]] = [] // 結果を格納するための変数を作成します。
    @State private var isPresented: Bool = false//追加
    
    
    var body: some View {
        
            VStack {
                Button(action:{
                    print("getボタン押しました")
                    //getRequestが非同期処理だから、その処理が終わった後に実行するコールバック{}.thenのイメージ
                    getRequest { decodedImages in
                        self.imagesData = decodedImages
                        print(self.imagesData[3]["image_data"])
                            base64ToFront = self.imagesData[3]["image_data"]
                            //base64ToFront = "image_data"
//                        let contentView = SwiftUIView()
//                        // Use a UIHostingController as window root view controller.
//                        let window = UIWindow(frame: UIScreen.main.bounds)
//                        window.rootViewController = UIHostingController(rootView: contentView)
//                        ContentView.window = window
//                        window.makeKeyAndVisible()
                        isPresented.toggle()
                    }
                    
                }
                )
                {
                    Text("get")
                }
                Button(action: postReqest){
                    Text("postメソッド")
                }
            }
       
        .fullScreenCover(isPresented: $isPresented){
            SwiftUIView2()
        }
        .padding()
    }
    
    func postReqest(){
        let parameters: [String: [String]] = [
            "foo": ["bar"],
            "baz": ["a", "b"],
            "qux": ["x", "y", "z"]
        ]
        
        // All three of these calls are equivalent
        AF.request("http://localhost:4242/api/v1/images", method: .post, parameters: parameters)
    }
    
}


#Preview {
    ContentView()
}
