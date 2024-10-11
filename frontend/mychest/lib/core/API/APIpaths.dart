library apiPaths;

//AUTH
String signUp = "http://localhost:8100/users/newUser";
String loginToken = "http://localhost:8080/realms/mychest/protocol/openid-connect/token";
String getProfile = "http://localhost:8100/users/getProfile";

//CreditCard
String getCreditCard = "http://localhost:8100/getFrom";
String setCreditCard = "http://localhost:8100/setTo";

//Products
String getFeatured = "http://localhost:8100/products/featured";
String searchProductsByCategory = "http://localhost:8100/searchByCategory";
String searchProducts = "http://localhost:8100/proucts/search";

//Banner
String getBanner = "http://localhost:8100/banner/get";

//Category
String getMostPopularCategories = "http://localhost:8100/category/mostPopular";

//Cart
String addCart = "http://localhost:8100/cart/add"; //TODO add cart instantiation when login and add the cartID to sharedPreferences
String addItemToCart = "http://localhost:8100/cart/addItem";
String removeItem = "http://localhost:8100/cart/removeItem";

//Order
String payOrder = "http://localhost:8100/orders/pay";
String getOrders = "http://localhost:8100/orders/getOrders";

