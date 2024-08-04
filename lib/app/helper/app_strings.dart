import 'all_imports.dart';

class AppStrings {
  static String appName = "LocalHarvest";
  static String getConnectedToFreshLocalAffordableGroceries =
      "Get connected to fresh, local, & affordable groceries";
  static String
      supportYourLocalFarmersCutOutTheMiddleManGettingTheFarmerYourselfABetterDeal =
      "Support your local farmers & cut out the middle man, getting the farmer & yourself a better deal!";

  static String commonValidation = "Please fill all the details";
  static String emailValidation = "Please enter a valid email";
  static String phoneValidation = "Please enter a valid phone number";
  static String lastNameValidation = "Please enter a valid first name";
  static String firstNameValidation = "Please enter a valid last name";
  static String profilePictureValidation =
      "Please select a valid profile picture";
  static String passwordValidation = "Please enter a valid password";
  static String passwordErrorMessage =
      "Minimum 8 characters, at least 1 lower case, at least 1 upper case, at least 1 digit";

  static String signUp = "Sign Up";
  static String logIn = "Log In";
  static String firstName = "First Name";
  static String lastName = "Last Name";
  static String emailAddress = "Email Address";
  static String phoneNumber = "Phone Number";
  static String password = "Password";
  static String autoFillBySpeech = "Auto-fill details by speech";
  static String dontHaveAnAccount = "Don't have an account?";
  static String alreadyHaveAnAccount = "Already have an account?";
  static String consumer = "Consumer";
  static String farmer = "Farmer";
  static String farmers = "Farmers";
  static String profilePicture = "Profile Picture";
  static String pickSource = "Pick Source";
  static String camera = "Camera";
  static String gallery = "Gallery";

  static String fewMoreDetails = "Few More Details";
  static String experience = "Experience(in years)";
  static String freeLand = "Free Land(in square feet)";
  static String done = "Done";

  static String noProductsListedYet = "No Products Listed Yet!";
  static String listening = "Listening";

  static String search = "Search";
  static String fulfilledBy = "Fulfilled by";
  static String organic = "Organic";
  static String orders = "Orders";
  static String farmingExp = "Farming Exp.";
  static String reviews = "Reviews";
  static String lifetimeSales = "Lifetime Sales";
  static String addToCart = "Add To Cart";

  static String newProduct = "New Product";
  static String products = "Products";
  static String addProduct = "Add Product";
  static String productImage = "Product Image";
  static String productName = "Product Name";
  static String productDescription = "Product Description";
  static String productPrice = "Product Price";
  static String productQuantity = "Product Quantity";

  static String cart = "Cart";
  static String checkout = "Checkout";

  static String autoFillPrompt = """
  You have to auto fill details depending on what users say. You will be provided with a JSON in which "text" will contain what user said, "parameters" will contain all the details that you have to fetch from the user's text and return. "parameters" will be a list with JSON with key as the key which the output has to be given, and its value will explain what that key means and what to detect from the text given by the user.

If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If a particular parameter has not been talked about in the text, then return null in that particular field.

RETURN JUST THE JSON CODE, NOTHING ELSE. 

Example Input: {"text": "my name is malay patel and my email address is dhara nine two 77 adrate gmail dot com. My phone number is nine four two double nine eight 99 four 0", "parameters": [{"fName": "First name of the user", "lName": "Last name of the user", "email": "email address of the user", "phone": "Phone number of the user"},],} 

Example Output: {"context": true, "data": {"fName":"Malay", "lName":"Patel", "email":"dhara9277@gmail.com", "phone":"9429989940"}}""";
}
