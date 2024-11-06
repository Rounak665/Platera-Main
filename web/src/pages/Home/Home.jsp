<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Platera | Discover & Order Food</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link rel="shortcut icon" href="./assets/favicon.png" type="image/x-icon" />
    <link rel="stylesheet" href="./style.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
      integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <!-- Welcome Popup -->
    <!-- <div class="welcome-popup" id="welcomePopup">
    <div class="popup-content">
        <h3>Welcome!</h3>
        <p>Thanks for visiting our website.</p>
        <button id="closePopupBtn">Close</button>
    </div>
</div> -->

    <!-- Navigation Bar -->
    <header>
      <nav class="navbar">
        <div class="logo">
          <a href="./Home.html"
            ><img src="./assets/PlateraLogo-red.png" alt=""
          /></a>
        </div>
        <div class="search-container">
          <input
            type="text"
            id="location-search"
            class="location-search"
            placeholder="Search for a location..."
          />
          <button class="select-location-btn" onclick="selectLocation()">
            &#x2192;
          </button>
          <!-- Arrow button -->
        </div>

        <span id="selected-location" class="selected-location"
          >Selected Location: None</span
        >

        <ul class="nav-links">
          <li><a href="./Home.html">Home</a></li>
          <li><a href="#restaurants">Restaurants</a></li>
          <li><a href="#dishes">Dishes</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
        <div class="navbar-icons">
          <!-- <button class="profile-btn" onclick="toggleProfileModal()"><i class="fas fa-user"></i></button>
            <button class="cart-btn" onclick="toggleCartModal()"><i class="fas fa-shopping-cart"></i><span id="cart-count">0</span></button> -->

          <div class="profile-icon" id="profileIcon">
            <i class="fas fa-user"></i>
          </div>
          <!-- Profile Icon -->
          <div class="cart-icon" id="cartIcon">
            <i class="fas fa-shopping-cart"></i>
          </div>
        </div>
      </nav>
    </header>

    <!-- Sliding User Section -->
    <section class="user-section" id="userSection">
      <button class="close-btn" id="closeUserSection">&times;</button>
      <!-- Close Button -->
      <div class="user-profile">
        <h2>Dashboard</h2>
        <ul class="dashboard-options">
          <form action="http://localhost:8080/Platera-Main/logout" method="get">
            <button type="submit" class="btn btn-outline-danger" id="logout-btn">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="bi bi-power"
                viewBox="0 0 16 16"
              >
                <path d="M7.5 1v7h1V1z"></path>
                <path
                  d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"
                ></path>
              </svg>
            </button>
        </form>
          <li>Hi, ${sessionScope.name}!</li>
          <li>Profile Settings</li>
          <li>Order History</li>
          <li>Favorites</li>
          <li>Logout</li>
        </ul>
        <button class="logout-btn">Logout</button>
        <!-- Logout Button -->
      </div>
    </section>

    <!-- Sliding Cart Section -->
    <section class="cart-section" id="cartSection">
      <button class="close-btn" id="closeCartSection">&times;</button>
      <!-- Close Button -->
      <div class="cart-content">
        <h2>Your Cart</h2>
        <ul class="cart-items">
          <li>Item 1 - ₹300</li>
          <li>Item 2 - ₹450</li>
          <li>Item 3 - ₹200</li>
          <li>Total: ₹950</li>
        </ul>
        <button class="checkout-btn">Checkout</button>
      </div>
    </section>

    <!-- Profile Modal -->
    <!-- <div class="profile-modal" id="profileModal">
    <div class="modal-content">
        <span class="close" onclick="toggleProfileModal()">&times;</span>
        <h2>User Profile</h2>
        <p>Name: John Doe</p>
        <p>Email: johndoe@example.com</p>
        <button class="logout-btn">Logout</button>
    </div>
</div> -->

    <!-- Cart Modal -->
    <!-- <div class="cart-modal" id="cartModal">
    <div class="modal-content">
        <span class="close" onclick="toggleCartModal()">&times;</span>
        <h2>Your Cart</h2>
        <ul id="cart-items"></ul>
        <p>Total: $<span id="cart-total">0.00</span></p>
        <button class="checkout-btn">Checkout</button>
    </div>
</div> -->

    <!-- Carousel Section -->
    <section class="carousel" id="home">
      <div class="carousel-container">
        <div class="carousel-slide">
          <img src="./assets/slide1.png" alt="Slide 1" />
          <img src="./assets/slide2.png" alt="Slide 2" />
          <img src="./assets/slide3.png" alt="Slide 3" />
          <img src="./assets/slide4.png" alt="Slide 4" />
          <img src="./assets/slide5.png" alt="Slide 5" />
        </div>
      </div>

      <!-- Search Bar -->
      <div class="search-bar">
        <input
          type="text"
          placeholder="Search for food, restaurants, or cuisine..."
        />
        <button>Search</button>
      </div>

      <!-- Dots Indicator -->
      <div class="dots" id="dots"></div>

      <!-- Floating Product Cards -->
      <div class="product-cards-container">
        <div class="product-card">
          <img src="./assets/card1.jpg" alt="Dish 1" />
          <h4>Order Online</h4>
          <p>Stay home and order to your doorstep</p>
        </div>
        <div class="product-card">
          <img src="./assets/card2.jpg" alt="Dish 2" />
          <h4>International Cuisins</h4>
          <p>Explore our range of international cuisines</p>
        </div>
        <div class="product-card">
          <img src="./assets/card3.jpg" alt="Dish 3" />
          <h4>Top Indian Dishes</h4>
          <p>Check out our top Indian dishes</p>
        </div>
        <div class="product-card">
          <img src="./assets/card4.jpg" alt="Dish 4" />
          <h4>Healthy Options</h4>
          <p>Discover our healthy options</p>
        </div>
      </div>
    </section>

    <!-- Spacer Section -->
    <section class="spacer-section"></section>

    <!-- Popular Restaurants Section -->
    <section class="popular-restaurants">
      <h3>Popular Restaurants with online food delivery</h3>
      <!-- Filter Buttons -->
      <div class="filter-buttons">
        <button class="filter-btn" onclick="filterRestaurants('ratings')">
          Ratings
        </button>
        <button class="filter-btn" onclick="filterRestaurants('nonveg')">
          Non-Veg
        </button>
        <button class="filter-btn" onclick="filterRestaurants('offers')">
          Offers
        </button>
        <button class="filter-btn" onclick="filterRestaurants('under300')">
          Less than ₹300
        </button>
        <button class="filter-btn" onclick="filterRestaurants('300to700')">
          ₹300-₹700
        </button>
      </div>

      <!-- Restaurant Slider -->
      <div class="slider-wrapper">
        <button class="slide-btn prev-btn" onclick="moveSlider(-1)">
          &#10094;
        </button>

        <div class="restaurant-slider">
          <div class="restaurant-card">
            <img
              src="./assets/product1.png"
              alt="Restaurant 1"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>KFC</h3>
              <p>⭐ 4.7 | ₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Burgers, Fast Food, Rolls & Wraps</p>
              <!-- Cuisines -->
              <p class="location">Dunlop</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product2.png"
              alt="Restaurant 2"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>Wow Momo!</h3>
              <p>⭐ 4.5 | ₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Noodles, Chinese, Dumplings</p>
              <!-- Cuisines -->
              <p class="location">Central Kolkata</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product3.png"
              alt="Restaurant 3"
              class="restaurant-image"
              style="object-position: top"
            />
            <div class="restaurant-info">
              <h3>Pizza Hut</h3>
              <p>⭐ 4.4 | ₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Pizzas</p>
              <!-- Cuisines -->
              <p class="location">Esplanade</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product4.png"
              alt="Restaurant 4"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>Burger King</h3>
              <p>⭐ 4.4 | ₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Burgers, Fries, American</p>
              <!-- Cuisines -->
              <p class="location">Dunlop</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product5.png"
              alt="Restaurant 5"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>Subway</h3>
              <p>⭐ 4.3 | ₹₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Sandwiches, Snacks, Beverages</p>
              <!-- Cuisines -->
              <p class="location">Park Street</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product6.avif"
              alt="Restaurant 6"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>Baskin Robins</h3>
              <p>⭐ 4.8 | ₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Ice Cream, Desserts</p>
              <!-- Cuisines -->
              <p class="location">Elgin</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product7.avif"
              alt="Restaurant 2"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>Arsalan</h3>
              <p>⭐ 4.5 | ₹₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Biriyani, Mughlai, Indian, Kebabs,....</p>
              <!-- Cuisines -->
              <p class="location">Hati Bagan</p>
              <!-- Location -->
            </div>
          </div>
          <div class="restaurant-card">
            <img
              src="./assets/product8.avif"
              alt="Restaurant 2"
              class="restaurant-image"
            />
            <div class="restaurant-info">
              <h3>Domino's Pizza</h3>
              <p>⭐ 4.2 | ₹₹₹</p>
              <!-- Ratings & Price Range -->
              <p>Pizzas, Italian, pastas, Garlic Bread</p>
              <!-- Cuisines -->
              <p class="location">Central Avenue</p>
              <!-- Location -->
            </div>
          </div>
          <!-- Add more restaurant cards as needed -->
        </div>

        <button class="slide-btn next-btn" onclick="moveSlider(1)">
          &#10095;
        </button>
      </div>
    </section>

    <!-- Spacer Section -->
    <section class="spacer-section"></section>

    <!-- Footer Section -->

    <footer>
      <div class="container_footer">
        <div class="row">
          <div class="col">
            <img src="./assets/PlateraLogo-red.png" alt="" />
            <p>
              Platera delivers delicious meals from your favorite local
              restaurants straight to your door, combining speed and convenience
              with every order. From quick bites to gourmet dishes, enjoy a
              world of flavors anytime, anywhere!
            </p>
          </div>
          <div class="col">
            <h3>
              Office
              <div class="underline"><span></span></div>
            </h3>
            <p>ITFL Road</p>
            <p>Whitefield, Bangalore</p>
            <p>Karnatak, PIN 568629, INDIA</p>
            <p class="email_id">support@platera.in</p>
            <h4>+91 - 1234567891</h4>
          </div>
          <div class="col">
            <h3>
              Links
              <div class="underline"><span></span></div>
            </h3>
            <ul>
              <li>
                <a
                  href="../FooterLinkPages/Terms&Conditions/Terms&Conditions.html"
                  >Terms & Conditions</a
                >
              </li>
              <li>
                <a href="../FooterLinkPages/PrivacyPolicy/PrivacyPolicy.html"
                  >Privacy Policy</a
                >
              </li>
              <li><a href="../FooterLinkPages/Help/Help.html">Help</a></li>
            </ul>
          </div>
          <div class="col">
            <h3>
              Newsletter
              <div class="underline"><span></span></div>
            </h3>
            <form>
              <img id="mail" src="./Public/images/mail.png" alt="" />
              <input
                type="email"
                name=""
                id=""
                placeholder="Enter Your Email Address"
              />
              <button type="submit">
                <img id="send" src="./Public/images/send.png" alt="" />
              </button>
            </form>
            <div class="social_icon">
              <i class="fa-brands fa-facebook"></i>
              <i class="fa-brands fa-instagram"></i>
              <i class="fa-brands fa-pinterest"></i>
              <i class="fa-brands fa-x-twitter"></i>
            </div>
          </div>
        </div>
      </div>
      <hr />
      <p class="copyright">Platera @2024 - All Rights Reserved</p>
    </footer>
    <!-- bootstrap import -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>

    <script src="script.js"></script>
  </body>
</html>