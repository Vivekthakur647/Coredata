

import UIKit

class Discs {
    var image: UIImage
	var name: String
	var description: String
    var type: String
    var id: Double
	var index: Int
	
    init(_image: UIImage, _name: String, _description: String, _type: String, _id: Double, _index: Int) {
		self.image = _image
        self.name = _name
		self.description = _description
		self.type = _type
        self.id = _id
        self.index = _index
	}
	
   convenience init(copying disc: Discs) {
       self.init(_image: disc.image, _name: disc.name, _description: disc.description, _type: disc.type, _id: disc.id, _index: disc.index)
   }
}


