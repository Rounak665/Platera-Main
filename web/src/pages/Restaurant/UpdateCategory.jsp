<%@page import="Utilities.CategoryDAO"%>
<%@page import="Utilities.Category"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platera - Restaurant Add Category</title>
    <link rel="shortcut icon" href="../../../Public/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="./RestaurantDashboard.css"> <!-- Use the same CSS as the home page -->
</head>
<body>
    <!-- Error Popup -->
    <div class="error-popup" id="errorPopup">
        <div class="error-content">
            <h2>Error</h2>
            <p id="errorMessage">An error has occurred. Please try again later.</p>
            <button id="closeErrorPopup">Go Back</button>
        </div>
    </div>
    <!-- loader -->
    <div class="loader">
        <div id="pl">
            <div>
                <video class="vid" src="../ContactUs/Assets/loader.mp4" autoplay muted loop></video>
            </div>
        </div>
    </div>

    <div>
        <div class="sidebar">
            <div class="sidebar-toggle menu" id="menu">
                <ion-icon name="menu"></ion-icon>
            </div>
            <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="ico"></ion-icon></div>
            <div class="sidebar-header">
                <div class="logo">
                    <img src="../../../Public/images/logo.png" alt="">
                </div>
            </div>
            
            <div class="sidebar-menu">
                <ul>
                    <li>
                        <a href="RestaurantDashboard.html">
                            <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                            <span>Home</span>
                        </a>
                    </li>
                    <li>
                        <a href="Category.html">
                            <span class="icon"><ion-icon name="grid"></ion-icon></span>
                            <span>Categories</span>
                        </a>
                    </li>
                    <li>
                        <a href="Menu.html">
                            <span class="icon"><ion-icon name="book"></ion-icon></span>
                            <span>Menu</span>
                        </a>
                    </li>
                    <li>
                        <a href="Orders.html">
                            <span class="icon"><ion-icon name="cart"></ion-icon></span>
                            <span>Orders</span>
                        </a>
                    </li>
                    <li class="li_logout">
                        <a href="../AddRestaurent/AddRestaurent.html#Signin-popup">
                            <span class="icon"><ion-icon name="power"></ion-icon></span>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main-content">
            <header>
                <div class="search-wrapper">
                    <span class="icon"><ion-icon name="search"></ion-icon></span>
                    <input type="search" placeholder="Search">
                </div>
                <div class="social-icons">
                    <div class="logout_btn" onclick="signout()">
                        <span class="logout">Logout</span>
                        <span class="icon"><ion-icon name="power"></ion-icon></span>
                    </div>
                </div>
            </header>



<%
    // Fetch the categories from the database
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getCategories();
    session.setAttribute("categories", categories);
%>

<main>
    <h2 class="dash-title">Add Category</h2>
    <section class="recent">
        <div class="activity-card pad-1">
            <form id="add-category-form" action="http://localhost:8080/Platera-Main/RestaurantUpdateCategories" method="post">
                <!-- Category Dropdown 1 -->
                <div class="form-group">
                    <label for="category-1">Category 1</label>
                    <select id="category-1" name="category-1" class="form-control" required>
                        <option value="">Choose Category 1</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Category Dropdown 2 -->
                <div class="form-group">
                    <label for="category-2">Category 2</label>
                    <select id="category-2" name="category-2" class="form-control" required>
                        <option value="">Choose Category 2</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Category Dropdown 3 -->
                <div class="form-group">
                    <label for="category-3">Category 3</label>
                    <select id="category-3" name="category-3" class="form-control" required>
                        <option value="">Choose Category 3</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit" id="submit-category" class="btn btn-main">Submit</button>
                </div>
            </form>
        </div>
    </section>
</main>

    </div>

    <!-- Scripts  -->

    <!-- Icon Scripts -->

    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- main scripts -->

    <script>
        document.querySelector("#menu").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.add("activate");
});

document.querySelector(".sidebar .close-btn").addEventListener("click", function() {
    document.querySelector(".sidebar").classList.remove("activate");
});
    </script>
    <script src="../../../error.js"></script>

</body>
</html>
