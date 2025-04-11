class PaymentValidationException(Exception):
    def __init__(self, message="Payment details are invalid."):
        super().__init__(message)
