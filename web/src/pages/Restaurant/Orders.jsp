<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <link rel="stylesheet" href="RestaurantDashboard.css"> <!-- Link to your CSS -->
</head>
<body>

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
            <div class="sidebar-toggle close-btn"><ion-icon name="close-outline" class="icon"></ion-icon></div>
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
                        <a href="./Category.jsp">
                            <span class="icon"><ion-icon name="grid"></ion-icon></span>
                            <span>Categories</span>
                        </a>
                    </li>
                    <li>
                        <a href="./Menu.jsp">
                            <span class="icon"><ion-icon name="book"></ion-icon></span>
                            <span>Menu</span>
                        </a>
                    </li>
                    <li>
                        <a href="./Orders.jsp">
                            <span class="icon"><ion-icon name="cart"></ion-icon></span>
                            <span>Orders</span>
                        </a>
                    </li>
                    <li class="li_logout">
                        <a href="http://localhost:8080/Platera-Main/logout">
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
                    <div class="logout_btn" onclick="signout()">
                    <span class="logout">Logout</span>
                    <span class="icon"><ion-icon name="power"></ion-icon></span>
                    </div>
                </div>
            </header>
            
            <main>
                <h2 class="dash-title">Orders</h2>

                <!-- Orders Section -->
                <section id="orders-section" class="recent">
                    <div class="activity-card">
                        <h3>Order History</h3>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>PayRef</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Date Delivered</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="orders-table">
                                    <!-- Order rows will be inserted here by JS -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </div>

    <!-- Scripts  -->

    <!-- Icon Scripts -->
    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <!-- Main JavaScript -->
    <script>
        document.querySelector("#menu").addEventListener("click", function() {
            document.querySelector(".sidebar").classList.add("activate");
        });
    
        document.querySelector(".sidebar .close-btn").addEventListener("click", function() {
            document.querySelector(".sidebar").classList.remove("activate");
        });
    
        function signout() {
            localStorage.removeItem('authtoken');
            localStorage.removeItem('admin');
            window.location.href = '../AddRestaurent/AddRestaurent.html#Signin-popup'; 
        }
    
        // Initial Order Data (for displaying before fetching actual data)
        const initialOrders = [
            { id: 1, payment_ref: 'PAY123', amount: '₹500', status: 'Pending', date_delivered: 'N/A' },
            { id: 2, payment_ref: 'PAY456', amount: '₹1200', status: 'Delivered', date_delivered: '23-09-2024' },
            { id: 3, payment_ref: 'PAY789', amount: '₹300', status: 'In Progress', date_delivered: 'N/A' }
        ];
    
        // Function to populate the table with initial rows
        function populateInitialOrders() {
            const ordersTable = document.getElementById('orders-table');
            initialOrders.forEach((order, index) => {
                const orderRow = `
                    <tr>
                        <td>#${index + 1}</td>
                        <td>${order.payment_ref}</td>
                        <td>${order.amount}</td>
                        <td>${order.status}</td>
                        <td>${order.date_delivered}</td>
                        <td style="display:flex; justify-content: center;"><button class="btn btn-view">View</button></td>
                    </tr>
                `;
                ordersTable.insertAdjacentHTML('beforeend', orderRow);
            });
        }
    
        // Fetch Orders 
        function fetchOrders() {
            const apiUrl = 'YOUR_API_URL_HERE'; // Replace with actual API URL
    
            fetch(`${apiUrl}/orders/all`, {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem('authtoken')}`
                }
            })
            .then(response => response.json())
            .then(data => {
                const orders = data.data;
                const ordersTable = document.getElementById('orders-table');
                ordersTable.innerHTML = ''; // Clear the table before appending new rows
    
                orders.forEach((order, index) => {
                    const orderRow = `
                        <tr>
                            <td>#${index + 1}</td>
                            <td>${order.payment_ref}</td>
                            <td>₹${order.amount}</td>
                            <td>${order.status}</td>
                            <td>${order.date_delivered || 'N/A'}</td>
                            <td><button class="btn btn-main">View</button></td>
                        </tr>
                    `;
                    ordersTable.insertAdjacentHTML('beforeend', orderRow);
                });
            })
            .catch(error => console.log('Error fetching orders:', error));
        }
    
        // Populate initial orders on page load
        document.addEventListener('DOMContentLoaded', function() {
            populateInitialOrders();  // Populate initial rows
            fetchOrders();  // Fetch real data and replace initial rows
        });
    </script>
    
</body>
</html>
