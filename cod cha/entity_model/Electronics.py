from entity_model.Product import Product

class Electronics:
    def __init__(self, product_name, description, price, quantity_in_stock, product_type, brand, warranty_period):
        self.product_name = product_name
        self.description = description
        self.price = price
        self.quantity_in_stock = quantity_in_stock
        self.type = product_type
        self.brand = brand
        self.warranty_period = warranty_period

