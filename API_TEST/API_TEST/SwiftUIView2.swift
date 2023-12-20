//
//  SwiftUIView2.swift
//  API_TEST
//
//  Created by user on 2023/12/20.
//

import SwiftUI
import RealityKit

struct SwiftUIView2 : View {
    
    let contentView = SwiftUIView2()
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window.rootViewController = UIHostingController(rootView: contentView)
    window.makeKeyAndVisible()
    
    var body: some View {
        Text("上")
        ARViewContainer().edgesIgnoringSafeArea(.all)
        Text("下")
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        //SwiftUIView2().forAR()
        
        
        let arView = ARView(frame: .zero)
        
        let test: String = String(describing: base64ToFront)//追加
        
        //AR表示するベースとなるボックスを作成
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.5, 0.5, 0)))
        
        //base64コードを仮置き（本番はバック作成の関数のリターンを置く）
        let base64:String = test
        //base64->UIImage変換処理を定義
        func convertBase64ToImage(_ base64String: String) -> UIImage? {
            guard let imageData = Data(base64Encoded: base64String) else { return nil }
            return UIImage(data: imageData)
        }
        
        //UIImageの作成
        let testUIImage = convertBase64ToImage(base64)
        
        //ローカルに保存するパスを指定（）
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("temp.png")
        
        
        
        if let uiImage = testUIImage,
           let pngData = uiImage.pngData(),
           ((try? pngData.write(to: url)) != nil), // 一度ローカルに書き込む
           let texture = try? TextureResource.load(contentsOf: url) { // 保存した画像のローカルURLからテクスチャリソースとして読み込む
            var imageMaterial = UnlitMaterial()
            imageMaterial.baseColor = MaterialColorParameter.texture(texture)
            box.model?.materials = [imageMaterial]
        }
        
        
        
        
        
        
        //アンカー設定。Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(box)//model->box変更した
        
        
        //Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    SwiftUIView2()
}
