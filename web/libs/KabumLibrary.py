from robot.api.deco import keyword

class KabumLibrary:

    @keyword("Validate Product Details")
    def validate_product_details(self, product_name, expected_name):
        assert product_name in expected_name, f"Expected {expected_name}, but got {product_name}"
