
class InsufficientFundsException(Exception):
    def __init__(self, message="Insufficient funds to enroll in this course."):
        super().__init__(message)
