//
//  SettingsView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 02/02/23.
//

import SwiftUI

struct SettingsView: View {
    
    let viewModel: SettingsVM
    
    init(viewModel: SettingsVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack(spacing: 20) {
                
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(uiColor: viewModel.iconContainerColor))
                        .cornerRadius(10)
                }
                
                Text(viewModel.title)
            }
            .padding(.vertical, 5)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        }
        .scrollContentBackground(.hidden)
    }
}
