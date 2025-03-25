class EmployeeNotFoundException(Exception):
    """Raised when an invalid Employee ID is entered"""
    def __init__(self, message="❌ Employee not found!"):
        self.message = message
        super().__init__(self.message)
