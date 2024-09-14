//
//  ContentView.swift
//  Prioritize
//
//  Created by Gustavo Nunes Pereira on 14/09/24.
//

import SwiftUI
import Contacts

struct ContentView: View {
    

    var body: some View {
        VStack {
            HStack {
                // Esse componente representa o avatar do usuário
                Avatar()
                Spacer()
                    .frame(width: 15)
                // Esse componente representa a saudação ao usuário
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.gray)
                    Text("Gustavo Nunes")
                        .font(.system(size: 20, weight: .medium))
                }
                Spacer()
                // Esse componente representa um botão
                Button(action: {
                    print("Botão de calendário pressionado")
                }) {
                    Image(systemName: "calendar")
                        .foregroundStyle(.black)
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray))
                Button(action: {
                    print("Botão de calendário pressionado")
                }) {
                    Image(systemName: "bell")
                        .foregroundStyle(.black)
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray))
            }.padding()
            Spacer()
        }
    }

   
}

struct Avatar: View {
    
    @State private var avatar: UIImage? = nil
        
    var body: some View {
        
        if let avatar = avatar {
            Image(uiImage: avatar)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else {
            Image(systemName: "person")
                .font(.system(size: 30))
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .onAppear { fetchUserAvatar() }
        }
        
        
        
    }
    
    func fetchUserAvatar() {
        
        let store = CNContactStore()
        let keys = [CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
        
        do {
            let containers = try store.containers(matching: nil)
            for container in containers {
                let predicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
                
                if let contact = contacts.first, let imageData = contact.thumbnailImageData {
                    avatar = UIImage(data: imageData)
                }
            }
        } catch {
            print("Error fetching user avatar: \(error)")
        }
    }
}

#Preview {
    ContentView()
        
}
