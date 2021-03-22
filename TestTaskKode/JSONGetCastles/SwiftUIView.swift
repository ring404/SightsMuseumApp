//
//  SwiftUIView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 17.02.2021.
//

import SwiftUI

struct MusicSearchView: View {
  
  @ObservedObject var viewModel: castleListViewModel

  var body: some View {
    
    
    NavigationView {
      VStack {
        SearchBar(searchTerm: $viewModel.searchTerm)
//        Вилла_Франка
        if viewModel.castles.isEmpty {
          EmptyStateView()
        } else {
          List(viewModel.castles) { castle in
            castleView(castle: castle)
          }
          .listStyle(PlainListStyle())
        }
      }
      .navigationBarTitle("Music Search")
    }
  }
}

struct castleView: View {
  @ObservedObject var castle: CastleViewModel
  
  var body: some View {
    HStack {
      ArtworkView(image: castle.artwork)
        .padding(.trailing)
      VStack(alignment: .leading) {
        Text(castle.trackName)
        Text(castle.artistName)
          .font(.footnote)
          .foregroundColor(.gray)
      }
    }
    .padding()
  }
}

struct ArtworkView: View {
  let image: Image?
  
  var body: some View {
    ZStack {
      if image != nil {
        image
      } else {
        Color(.systemIndigo)
        Image(systemName: "music.note")
          .font(.largeTitle)
          .foregroundColor(.white)
      }
    }
    .frame(width: 50, height: 50)
    .shadow(radius: 5)
    .padding(.trailing, 5)
  }
}

struct EmptyStateView: View {
    let idFromNameResult:GetWikiAPI
    
    init() {
        idFromNameResult = GetWikiAPI.init()
    }
    
  var body: some View {
    VStack {
      Spacer()
      Image(systemName: "music.note")
        .font(.system(size: 85))
        .padding(.bottom)
      Text("Start searching for music...")
        Text(self.idFromNameResult.getPageIdFromName(query: "Rossgarten_Gate"))
        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Kaliningrad_05-2017_img12_Rossgarten_Gate.jpg/417px-Kaliningrad_05-2017_img12_Rossgarten_Gate.jpg")!,
                       placeholder: { Text("Loading ...") },
                       image: { Image(uiImage: $0).resizable() })
               .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3) // 2:3 aspect ratio
       
        .font(.title)
      Spacer()
    }
    .padding()
    .foregroundColor(Color(.systemIndigo))
  }
}

struct SearchBar: UIViewRepresentable {
  typealias UIViewType = UISearchBar
  
  @Binding var searchTerm: String

  func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "Type a castle, artist, or album name..."
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: Context) {
  }
  
  func makeCoordinator() -> SearchBarCoordinator {
    return SearchBarCoordinator(searchTerm: $searchTerm)
  }
  
  class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    @Binding var searchTerm: String
    
    init(searchTerm: Binding<String>) {
      self._searchTerm = searchTerm
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchTerm = searchBar.text ?? ""
      UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
    }
  }
}

struct MusicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MusicSearchView(viewModel: castleListViewModel())
    }
}
