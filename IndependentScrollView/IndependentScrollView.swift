//
//  IndependentScrollView.swift
//
//  Created by Itay Lador on 2/3/25.
//

import SwiftUI


struct IndependentScrollViewGrid<ListItemType, Label> : View where ListItemType : Identifiable, Label : View {
    let list : [ListItemType]
    @ViewBuilder let item_view : (ListItemType) -> Label
    let item_size : CGSize
    let num_items_in_row : Int
    let padding : CGFloat
    @State private var visible_index : Int = 0
    @State private var latest_index : Int = 0
    let expanded : ListItemType?


    init(list : [ListItemType], item_size: CGSize, container_width : CGFloat = UIScreen.main.bounds.width, expanded : ListItemType? = nil, @ViewBuilder _ label: @escaping (ListItemType) -> Label){
        self.list = list
        self.item_view = label
        self.item_size = item_size
        self.num_items_in_row = Int(floor(container_width / item_size.width))
        self.padding = (container_width - ( item_size.width * CGFloat(num_items_in_row))) / 4
        self.expanded = expanded
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                ForEach(Array(list.enumerated()), id: \.element.id) { index, list_item in
                    if latest_index <= index || abs(index - visible_index) <= 200 {
                        self.item_view(list_item)
                            .offset(
                                x:  expanded?.id == list_item.id ? 0 : item_size.width * CGFloat(index % self.num_items_in_row) + (padding * CGFloat(index % self.num_items_in_row)),
                                y: item_size.height * CGFloat(index / self.num_items_in_row) + (padding * CGFloat(index / self.num_items_in_row))
                            )
                            .onAppear {
                                if latest_index < index {
                                    latest_index = index
                                }
                            }
                            .animation(.smooth, value: latest_index)
                    }
                }
            }
            .frame(width: window.width, height: item_size.width * CGFloat((list.count / num_items_in_row) + 3) + (padding * CGFloat(list.count / num_items_in_row)), alignment: .topLeading )
            .background(GeometryReader { geometry in
                let yOffset = -geometry.frame(in: .named("IndependentScrollViewGrid")).origin.y
                Color.clear.preference(key: ViewOffsetKey.self, value: yOffset)
            })
            .onPreferenceChange(ViewOffsetKey.self) { newOffset in
                if abs(self.visible_index - Int(newOffset / item_size.height) * num_items_in_row) > 50 {
                    self.visible_index = Int(newOffset / MEDIA_ITEM_WIDTH) * num_items_in_row
                }
            }
            
        }
        .coordinateSpace(name: "IndependentScrollViewGrid")
    }
}
