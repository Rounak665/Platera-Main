<%@page import="Utilities.Database"%>
<%@page import="javax.servlet.jsp.jstl.sql.Result"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <link rel="stylesheet" href="Admin.css"> 
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

        <!-- Sidebar and Header Section -->
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
                            <a href="./Admin_Order_Management.jsp">
                                <span class="icon"><ion-icon name="wine"></ion-icon></span>
                                <span>Order Management</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Restaurant_Approval.jsp">
                                <span class="icon"><ion-icon name="restaurant"></ion-icon></span>
                                <span>Restaurant Approval</span>
                            </a>
                        </li>
                        <li>
                            <a href="./Admin_Delivery_Executive_Approval.jsp">
                                <span class="icon"><ion-icon name="bicycle"></ion-icon></span>
                                <span>Delivery Executive Management</span>
                            </a>
                        </li>
                        <li class="logoutOption">
                            <form action="http://localhost:8080/Platera-Main/logout" method="POST">                          
                                <button type="submit"><span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>Logout</button>
                            </form>
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
                    

                    <div class="social-icons">
                        <div class="logout_btn">
                            <form action="http://localhost:8080/Platera-Main/logout" class="d-flex align-items-center">
                                <button type="submit" class="btn d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
                                    <path d="M7.5 1v7h1V1z"></path>
                                    <path d="M3 8.812a5 5 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812"></path>
                                    </svg>
                                    <span class="ml-2">Logout</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </header>

                <main>
                    <!-- Pending Restaurants Section -->
                    <section class="pending-restaurants">

                        <h1>Pending Restaurant Approvals</h1>

                        <table border="1" id="restaurant-table">
                            <thead>
                                <tr>
                                    <th>Request ID</th>
                                    <th>Restaurant Name</th>
                                    <th>Owner Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Bank Account Name</th>
                                    <th>Bank Account Number</th>
                                    <th>GSTIN</th>
                                    <th>FSSAI License</th>
                                    <th>Pan</th>
                                    <th>Actions</th> 
                                </tr>
                            </thead>
                            <tbody>

                                <%
                                    Connection conn = null;
                                    PreparedStatement stmt = null;
                                    ResultSet rs = null;

                                    try {
                                        conn = Database.getConnection(); // Assuming getConnection method works with Java 1.5
                                        String sql = "SELECT * FROM restaurant_requests";
                                        stmt = conn.prepareStatement(sql);
                                        rs = stmt.executeQuery();

                                        while (rs.next()) {
                                            int request_id = rs.getInt("request_id");
                                            String restaurant_name = rs.getString("restaurant_name");
                                            String owner_name = rs.getString("owner_name");
                                            String email = rs.getString("email");
                                            String phone = rs.getString("owner_phone");
                                            String bank_acc_name = rs.getString("bank_acc_name");
                                            String bank_acc_number = rs.getString("bank_acc_number");
                                            String gst_in = rs.getString("gst_in");
                                            String fssai_lic_no = rs.getString("fssai_lic_no");
                                            String pan_number = rs.getString("pan_number");
                                %>
                                <tr>
                                    <td> <%=request_id%> </td>
                                    <td> <%=restaurant_name%> </td>
                                    <td> <%=owner_name%> </td>
                                    <td> <%=email%> </td>
                                    <td> <%=phone%> </td>
                                    <td> <%=bank_acc_name%> </td>
                                    <td> <%=bank_acc_number%> </td>
                                    <td> <%=gst_in%> </td>
                                    <td> <%=fssai_lic_no%> </td>
                                    <td> <%=pan_number%> </td>
                                    <td>
                                        <form action='http://localhost:8080/Platera-Main/approveRestaurant' method='post' style='display:inline;'>
                                            <input type='hidden' name='request_id' value='<%=request_id%>'/>
                                            <input type='submit' class="button approve-btn" value='Approve'/>
                                        </form>
                                        <form action='http://localhost:8080/Platera-Main/rejectRestaurant' method='post' style='display:inline;'>
                                            <input type='hidden' name='request_id' value='<%=request_id%>'/>
                                            <input type='submit' class="button reject-btn" value='Reject'/>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        out.println("Error connecting to the database: " + e.getMessage());
                                        e.printStackTrace();
                                    } finally {
                                        // Close resources manually to avoid resource leak
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                            if (stmt != null) {
                                                stmt.close();
                                            }
                                            if (conn != null) {
                                                conn.close();
                                            }
                                        } catch (SQLException ex) {
                                            out.println("Error closing resources: " + ex.getMessage());
                                        }
                                    }
                                %>
                        </table>

                    </section>
                </main>
            </div>
        </div>

        <!-- Scripts Section -->
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <script>
            document.querySelector("#menu").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.add("activate");
            });

            document.querySelector(".sidebar .close-btn").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.remove("activate");
            });

// Check if the URL hash is #errorPopup
            if (window.location.hash === '#errorPopup') {
                // Show the error popup
                document.addEventListener('DOMContentLoaded', function () {
                    const errorPopup = document.getElementById('errorPopup');
                    if (errorPopup) {
                        errorPopup.style.display = 'flex';
                    }
                });
            }

// Function to display the error popup dynamically
            function showErrorPopup(message) {
                const errorMessage = document.getElementById('errorMessage');
                const errorPopup = document.getElementById('errorPopup');
                if (errorMessage && errorPopup) {
                    errorMessage.innerText = message;
                    errorPopup.style.display = 'flex';
                }
            }

// Close the error popup
            document.addEventListener('DOMContentLoaded', function () {
                const closeErrorPopupButton = document.getElementById('closeErrorPopup');
                const errorPopup = document.getElementById('errorPopup');
                if (closeErrorPopupButton && errorPopup) {
                    closeErrorPopupButton.addEventListener('click', function () {
                        errorPopup.style.display = 'none';
                    });
                }
            });

        </script>

    </body>
</html>
