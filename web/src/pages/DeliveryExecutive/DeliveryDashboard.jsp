
<%@page import="java.sql.SQLException"%>
<%@page import="Utilities.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delivery Executive Dashboard Overview</title>
        <link rel="stylesheet" href="Delivery.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>

        <!--Java Scriplets-->
        <%
            //Actual code
//            int user_id = (Integer) session.getAttribute("user_id");
//            String name = (String) session.getAttribute("name");
//            String email = (String) session.getAttribute("email");
//            int delivery_executive_id = (Integer) session.getAttribute("delivery_executive_id");
//            String image = (String) session.getAttribute("image");
//            String imagepath = request.getContextPath() + '/' + image;
//            int location_id = 0;
//            String location = "";

            //For debugging
            int user_id = 257;
            String name = "Arthur Morgan";
            String email = "ArthurMorgan1863@gmail.com";
            int delivery_executive_id = 35;
            String image = "DatabaseImages/Delivery_Executives/Arthur_Morgan.jpeg";
            String imagepath = request.getContextPath() + '/' + image;
            int location_id = 0;
            String location = "";
            Connection conn = null;
            PreparedStatement selectSqlPstmt = null;
            PreparedStatement selectLocationPstmt = null;
            ResultSet selectSqlRs = null;
            ResultSet selectLocationSqlRs = null;

            try {
                // Get connection
                conn = Database.getConnection(); // Assuming getConnection method works with Java 1.5

                // First Query: Get location_id for the user
                try {
                    String selectSql = "SELECT location FROM delivery_executives WHERE user_id=?";
                    selectSqlPstmt = conn.prepareStatement(selectSql);
                    selectSqlPstmt.setInt(1, user_id); // Set parameter before executing the query

                    selectSqlRs = selectSqlPstmt.executeQuery(); // Execute the query

                    if (selectSqlRs.next()) {
                        location_id = selectSqlRs.getInt("location"); // Retrieve the location_id
                    } else {
                        out.println("Unexpected Error: No location found for user.");
                        return;
                    }
                } catch (SQLException e) {
                    out.println("Error executing the first query: " + e.getMessage());
                    e.printStackTrace();
                    return; // Return after logging the error
                }

                // Second Query: Get location name based on location_id
                try {
                    String selectLocationSql = "SELECT location_name FROM locations WHERE location_id=?";
                    selectLocationPstmt = conn.prepareStatement(selectLocationSql);
                    selectLocationPstmt.setInt(1, location_id); // Set parameter before executing the query

                    selectLocationSqlRs = selectLocationPstmt.executeQuery(); // Execute the query

                    if (selectLocationSqlRs.next()) {
                        location = selectLocationSqlRs.getString("location_name"); // Retrieve the location name
                    } else {
                        out.println("Unexpected Error: No location found for location_id.");
                        return;
                    }
                } catch (SQLException e) {
                    out.println("Error executing the second query: " + e.getMessage());
                    e.printStackTrace();
                    return; // Return after logging the error
                }

            } catch (SQLException e) {
                out.println("Error connecting to the database: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources manually to avoid resource leak
                try {
                    if (selectSqlRs != null) {
                        selectSqlRs.close();
                    }
                    if (selectLocationSqlRs != null) {
                        selectLocationSqlRs.close();
                    }
                    if (selectSqlPstmt != null) {
                        selectSqlPstmt.close();
                    }
                    if (selectLocationPstmt != null) {
                        selectLocationPstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    out.println("Error closing resources: " + ex.getMessage());
                }
            }


        %>


        <!-- Welcome Popup -->


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
                            <a href="">
                                <span class="icon"><ion-icon name="home-sharp"></ion-icon></span>
                                <span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="DeliveryOrders.jsp">
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
                    <div class="headerLogo">
                        <div class="logo">
                            <img src="../../../Public/images/logo.png" alt="">
                        </div>
                    </div>
                    <div class="search-wrapper">
                        <span class="icon"><ion-icon name="search"></ion-icon></span>
                        <input type="search" placeholder="Search">
                    </div>
                    <div class="social-icons">
                        <div class="logout_btn">
                            <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center logout">
                                <button type="submit" class="btn d-flex align-items-center">
                                    <span class="ml-2">Logout</span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                                    <path d="M7.5 1v7h1V1z"></path>
                                    <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </header>

                <main>
                    <h2 class="dash-title">Hello, <%=name%></h2>

                    <div class="container">

                        <div class="profile">
                            <div class="personal-details">
                                <div class="personal-image"><img src="<%=imagepath%>" alt="Your-image"></div>
                                <div class="personal-description">
                                    <h5><%=name%></h5>
                                    <h6><span>&#9733;5.0</span><span> <%=location%> </span></h6>
                                    <p>Joined June 2024</p>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">Edit</button>
                                </div>
                            </div>
                            <div class="order-details">
                                <div class="order-cards">
                                    <span class="icon" style="color: rgb(0, 200, 0);"><ion-icon name="checkmark-done-outline"></ion-icon></span>
                                    <h5>932</h5>
                                    <p>Finish Order</p>
                                </div>
                                <div class="order-cards">
                                    <span class="icon" style="color: rgb(255, 140, 0);"><ion-icon name="checkmark-circle"></ion-icon></span>
                                    <h5>1032</h5>
                                    <p>Order Delivered</p>
                                </div>
                                <div class="order-cards">
                                    <span class="icon" style="color: rgb(255, 0, 0);"><ion-icon name="close-circle"></ion-icon></span>
                                    <h5>103</h5>
                                    <p>Order Canceled</p>
                                </div>
                            </div>
                            <div class="earning">
                                <div class="earning-details">
                                    <div class="details-left">
                                        <span class="icon"><ion-icon name="wallet-outline"></ion-icon></span>
                                        <div>
                                            <p>Today's Earnings</p>
                                            <h5>â¹2,530</h5>
                                        </div>
                                    </div>
                                    <div class="details-right">
                                        <button class="start-delivery">Ready to Deliver</button>
                                        <button class="end-delivery">Call it a Day</button>
                                    </div>
                                </div>
                                <hr>
                                <div class="distance-details">
                                    <div class="distance-head">
                                        <span>Total Trip</span>
                                        <span>Total Distance</span>
                                        <span>Total Time</span>
                                    </div>
                                    <div class="distance-values">
                                        <span>15</span>
                                        <span>15Km</span>
                                        <span>90 Min</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="dash-performance">
                            <!-- Current Order Section -->
                            <div class="current-order">
                                <%
                                    PreparedStatement selectDeliveriesSqlPstmt = null;
                                    ResultSet selectDeliveriesSqlRs = null;
                                    int order_id = 0;
                                    double total_amount = 0;
                                    String address = null;
                                    String restaurant_name = null;

                                    try {
                                        // Get connection
                                        conn = Database.getConnection(); // Assuming getConnection method works with Java 1.5

                                        // First Query: Get location_id for the user
                                        try {
                                            String selectDeliveriesSql = "SELECT order_id FROM deliveries WHERE delivery_executive_id=?";
                                            selectDeliveriesSqlPstmt = conn.prepareStatement(selectDeliveriesSql);
                                            selectDeliveriesSqlPstmt.setInt(1, delivery_executive_id); // Set parameter before executing the query

                                            selectDeliveriesSqlRs = selectDeliveriesSqlPstmt.executeQuery(); // Execute the query

                                            if (selectDeliveriesSqlRs.next()) {
                                                order_id = selectDeliveriesSqlRs.getInt("order_id"); // Retrieve the order_id
                                            } else {
                                                out.println("Unexpected Error: No Deliveries found for user.");
                                                return;
                                            }
                                        } catch (SQLException e) {
                                            out.println("Error executing the first query: " + e.getMessage());
                                            e.printStackTrace();
                                            return; // Return after logging the error
                                        }
                                        // Second Query: Get orders
                                        try {
                                            String selectOrdersSql = "SELECT o.total_amount as total_amount, o.address as address, r.restaurant_name as restaurant_name "
                                                                     + "FROM orders o "
                                                                     + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                                                                     + "WHERE o.order_id = ? AND o.order_status = 'Accepted'";
                                            PreparedStatement selectOrdersPstmt = conn.prepareStatement(selectOrdersSql);
                                            selectOrdersPstmt.setInt(1, order_id); // Set parameter before executing the query

                                            ResultSet selectOrdersSqlRs = selectOrdersPstmt.executeQuery(); // Execute the query

                                            if (selectOrdersSqlRs.next()) {
                                                total_amount = selectOrdersSqlRs.getDouble("total_amount");
                                                address = selectOrdersSqlRs.getString("address");
                                                restaurant_name = selectOrdersSqlRs.getString("restaurant_name");
                                            } else {
                                                out.println("Unexpected Error: No orders found.");
                                                return;
                                            }
                                        } catch (SQLException e) {
                                            out.println("Error executing the second query: " + e.getMessage());
                                            e.printStackTrace();
                                            return; // Return after logging the error
                                        }

                                    } catch (SQLException e) {
                                        out.println("Error connecting to the database: " + e.getMessage());
                                        e.printStackTrace();
                                    } finally {
                                        // Close resources manually to avoid resource leak
                                        try {
                                            if (selectSqlRs != null) {
                                                selectSqlRs.close();
                                            }
                                            if (selectLocationSqlRs != null) {
                                                selectLocationSqlRs.close();
                                            }
                                            if (selectSqlPstmt != null) {
                                                selectSqlPstmt.close();
                                            }
                                            if (selectLocationPstmt != null) {
                                                selectLocationPstmt.close();
                                            }
                                            if (conn != null) {
                                                conn.close();
                                            }
                                        } catch (SQLException ex) {
                                            out.println("Error closing resources: " + ex.getMessage());
                                        }
                                    }

                                %>
                                <h2><ion-icon name="receipt-outline"></ion-icon> Current Order</h2>
                                <div class="order-details">
                                    <div class="order-row">
                                        <span class="icon"><ion-icon name="document-outline"></ion-icon></span>
                                        <strong>Order #<%=order_id%></strong>
                                    </div>
                                    <div class="order-row">
                                        <span class="icon"><ion-icon name="restaurant-outline"></ion-icon></span>
                                        <%=restaurant_name%>
                                    </div>
                                    <div class="order-row">
                                        <span class="icon"><ion-icon name="pricetag-outline"></ion-icon></span>
                                                <%=total_amount%>
                                    </div>
                                    <div class="order-row">
                                        <span class="icon"><ion-icon name="location-outline"></ion-icon></span>
                                                <%=address%>
                                    </div>
                                    <div class="order-row">
                                        <span class="icon"><ion-icon name="checkmark-circle-outline"></ion-icon></span>
                                        Status: <strong class="status">Accepted</strong>
                                    </div>
                                </div>
                            </div>

                            <!-- Statistics Section -->
                            <div class="statistics">
                                <h2><ion-icon name="list-outline"></ion-icon> Upcoming Orders</h2>
                                <div class="yourOrders">
                                    <div class="upcoming-order">
                                        <h4>Order #12346</h4>
                                        <p><ion-icon name="restaurant-outline"></ion-icon> Sushi Delight</p>
                                        <p><ion-icon name="pricetag-outline"></ion-icon> $18.99</p>
                                        <p><ion-icon name="location-outline"></ion-icon> 45 Elm Street</p>
                                    </div>
                                    <div class="upcoming-order">
                                        <h4>Order #12347</h4>
                                        <p><ion-icon name="restaurant-outline"></ion-icon> Burger Barn</p>
                                        <p><ion-icon name="pricetag-outline"></ion-icon> $12.50</p>
                                        <p><ion-icon name="location-outline"></ion-icon> 67 Oak Avenue</p>
                                    </div>
                                    <div class="upcoming-order">
                                        <h4>Order #12348</h4>
                                        <p><ion-icon name="restaurant-outline"></ion-icon> Taco Time</p>
                                        <p><ion-icon name="pricetag-outline"></ion-icon> $22.75</p>
                                        <p><ion-icon name="location-outline"></ion-icon> 89 Maple Lane</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </main>
            </div>
        </div>

        <!-- Edit Profile Modal -->
        <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="UpdateDeliveryExecutive" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="<%= request.getAttribute("name")%>">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email")%>">
                            </div>
                            <div class="mb-3">
                                <label for="number" class="form-label">Number</label>
                                <input type="text" class="form-control" id="number" name="number" value="<%= request.getAttribute("number")%>">
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="<%= request.getAttribute("address")%>">
                            </div>
                            <div class="mb-3">
                                <label for="deliveryArea" class="form-label">Delivery Area Address</label>
                                <input type="text" class="form-control" id="deliveryArea" name="deliveryArea" value="<%= request.getAttribute("deliveryArea")%>">
                            </div>
                            <div class="mb-3">
                                <label for="emergencyContact" class="form-label">Emergency Contact Number</label>
                                <input type="text" class="form-control" id="emergencyContact" name="emergencyContact" value="<%= request.getAttribute("emergencyContact")%>">
                            </div>
                            <div class="mb-3">
                                <label for="profileImage" class="form-label">Profile Image</label>
                                <input type="file" class="form-control" id="profileImage" name="profileImage">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Scripts  -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


        <!-- Icon Scripts -->

        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <script src="Delivery.js"></script>
    </body>
</html>
