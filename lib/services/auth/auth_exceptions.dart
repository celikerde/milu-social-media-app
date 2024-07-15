//login Exception
class InvalidCredentialsAuthException implements Exception {}

//Register Exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//Generic Auth Exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
