//
//  ContentView.swift
//  Lego Image Collector
//
//  Created by Edward Lach on 3/12/21.
//

import SwiftUI
import GoogleAPIClientForREST

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func save(service: GTLRDriveService, label: String, image: UIImage) {
    if let imageData = image.jpegData(compressionQuality: 0.8) {
        let filename: String = label + "-" + UUID().uuidString + ".jpeg"

        let file = GTLRDrive_File()
        file.name = filename
        file.parents = ["1ahIC3kJB02eQhwJdmjV-ebnoFPQb5jqf"]
        
        let params = GTLRUploadParameters(data: imageData, mimeType: "image/jpeg")
        params.shouldUploadWithSingleRequest = true
        
        let query = GTLRDriveQuery_FilesCreate.query(withObject: file, uploadParameters: params)
        query.fields = "id"
        
        service.executeQuery(query, completionHandler: { (ticket, file, error) in
            print("Upload file ID: \(file); Error: \(error?.localizedDescription)")
        })
    }
}

struct ContentView: View {
    @State var showAuthAlert: Bool = false
    @State var authError: Error?
    @State var label: String = ""
    @State private var isShowCamera = false
    @State private var image = UIImage()
    @State private var isSignedIn = false
    @State private var service = GTLRDriveService()
    
    var body: some View {
        VStack{
            Spacer()
            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
            if self.isSignedIn {
                Spacer()
                TextField("Lego ID", text: $label)
                    .padding(.leading, 10.0)
                    .padding(.vertical, 10.0)
                    .frame(maxHeight: 50.0)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {self.isShowCamera = true}) {
                        Image("red-lego-brick")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 5.0))
                            .shadow(radius: 5.0)
                    }
                    .padding(.vertical, 10.0)
                    Spacer()
                    Button(action: {save(service: self.service, label: self.label, image: self.image)}) {
                        HStack {
                            Image(systemName: "cloud")
                                .font(.system(size: 20))
                                .accentColor(Color.green)
                                .background(Color.clear)
                            Text("Save")
                                .font(.headline)
                                .background(Color.clear)
                                .foregroundColor(.green)
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 100.0, height: 100.0)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 5.0))
                        .shadow(radius: 5.0)
                    }
                    .padding(.vertical, 10.0)
                    Spacer()
                }
            } else {
                Spacer()
                GoogleSignIn(showAuthAlert: $showAuthAlert, authError: $authError) { (user) in

                    guard let authUser = user else {
                        self.authError = GoogleSignInError.credentialError
                        self.showAuthAlert = true
                        return
                    }
                    self.service.authorizer = authUser.authentication.fetcherAuthorizer()
                    self.isSignedIn = true
                }
                Spacer()
            }
        }
        .padding(.top, 10.0)
        .sheet(isPresented: $isShowCamera) {
            ImagePicker(sourceType: .camera, selectedImage: self.$image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
