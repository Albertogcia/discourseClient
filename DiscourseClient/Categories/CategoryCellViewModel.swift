import Foundation

class CategoryCellViewModel{
    let category: Category
    var textLabelText: String?
    
    init(category: Category) {
        self.category = category
        self.textLabelText = category.name
    }
}
