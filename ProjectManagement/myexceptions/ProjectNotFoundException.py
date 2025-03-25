class ProjectNotFoundException(Exception):
    """Raised when an invalid Project ID is entered"""
    def __init__(self, message="❌ Project not found!"):
        self.message = message
        super().__init__(self.message)
