package Utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {

public List<Orders> getAcceptedOrdersByDeliveryExecutiveId(int deliveryExecutiveId) throws SQLException {

    List<Orders> ordersList = new ArrayList<>();
    String query = "SELECT o.order_id, o.total_amount AS total_amount, o.address AS customer_address, o.order_status, o.order_date, "
            + "r.restaurant_id, r.restaurant_name AS restaurant_name, r.address AS restaurant_address, r.phone AS restaurant_phone, "
            + "p.payment_method, p.payment_status, p.payment_date, "
            + "oi.item_id, m.item_name, oi.quantity, m.image, o.phone AS customer_phone, "
            + "u.email AS customer_email "
            + "FROM orders o "
            + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
            + "LEFT JOIN payments p ON o.order_id = p.order_id "
            + "LEFT JOIN deliveries d ON o.order_id = d.order_id "
            + "JOIN order_items oi ON o.order_id = oi.order_id "
            + "JOIN menu_items m ON oi.item_id = m.item_id "
            + "LEFT JOIN customers c ON o.customer_id = c.customer_id "
            + "LEFT JOIN users u ON c.user_id = u.user_id "
            + "WHERE d.delivery_executive_id = ? AND o.order_status IN ('Accepted', 'Cooked', 'Picked Up') "
            + "ORDER BY o.order_date DESC";

    try (Connection conn = Database.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setInt(1, deliveryExecutiveId);
        ResultSet rs = pstmt.executeQuery();

        int currentOrderId = -1;
        Orders currentOrder = null;

        while (rs.next()) {
            int orderId = rs.getInt("order_id");

            // Check if we have a new order
            if (orderId != currentOrderId) {
                if (currentOrder != null) {
                    ordersList.add(currentOrder); // Add the previous order to the list
                }

                // Create a new Orders object for the new order
                currentOrder = new Orders();
                currentOrder.setOrderId(orderId);
                currentOrder.setOrderStatus(rs.getString("order_status"));
                currentOrder.setOrderDate(rs.getString("order_date"));
                currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                currentOrder.setCustomerAddress(rs.getString("customer_address"));
                currentOrder.setCustomerPhone(rs.getString("customer_phone"));
                currentOrder.setCustomerEmail(rs.getString("customer_email")); // Set customer email
                currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                currentOrder.setRestaurantPhone(rs.getString("restaurant_phone"));
                currentOrder.setPaymentMethod(rs.getString("payment_method"));
                currentOrder.setPaymentStatus(rs.getString("payment_status"));
                currentOrder.setPaymentDate(rs.getString("payment_date"));

                currentOrderId = orderId;  // Update current order id
            }

            // Add item details to the current order
            int itemId = rs.getInt("item_id");
            String itemName = rs.getString("item_name");
            int quantity = rs.getInt("quantity");
            String image = rs.getString("image"); // Get the image URL

            OrderItem orderItem = new OrderItem();
            orderItem.setItemId(itemId);
            orderItem.setItemName(itemName);
            orderItem.setQuantity(quantity);
            orderItem.setImage(image); // Set the image URL

            currentOrder.addOrderItem(orderItem);  // Add item to the order
        }

        // Add the last order to the list
        if (currentOrder != null) {
            ordersList.add(currentOrder);
        }
    }

    return ordersList;  // Return the list of orders with their items
}


    public List<Orders> getOrdersByCustomerId(int customerId) throws SQLException {

        List<Orders> ordersList = new ArrayList<>();
        String query = "SELECT o.order_id, o.total_amount AS total_amount, o.address AS customer_address, o.order_status, o.order_date, "
                + "r.restaurant_id, r.restaurant_name AS restaurant_name, r.address AS restaurant_address, r.phone as restaurant_phone, "
                + "p.payment_method, p.payment_status, p.payment_date, "
                + "oi.item_id, m.item_name, oi.quantity, m.image, oi.price, o.phone as customer_phone "
                + "FROM orders o "
                + "LEFT JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                + "LEFT JOIN payments p ON o.order_id = p.order_id "
                + "LEFT JOIN order_items oi ON o.order_id = oi.order_id "
                + "LEFT JOIN menu_items m ON oi.item_id = m.item_id "
                + "WHERE o.customer_id = ? "
                + "ORDER BY o.order_date DESC";

        try (Connection conn = Database.getConnection(); // Initialize connection locally
                PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();

            int currentOrderId = -1;
            Orders currentOrder = null;

            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // Check if we have a new order
                if (orderId != currentOrderId) {
                    // If we already have a current order, add it to the list
                    if (currentOrder != null) {
                        ordersList.add(currentOrder);
                    }

                    // Create a new Orders object for the new order
                    currentOrder = new Orders();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setOrderStatus(rs.getString("order_status"));
                    currentOrder.setOrderDate(rs.getString("order_date"));
                    currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                    currentOrder.setCustomerAddress(rs.getString("customer_address"));
                    currentOrder.setCustomerPhone(rs.getString("customer_phone"));
                    currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                    currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                    currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                    currentOrder.setRestaurantPhone(rs.getString("restaurant_phone"));
                    currentOrder.setPaymentMethod(rs.getString("payment_method"));
                    currentOrder.setPaymentStatus(rs.getString("payment_status"));
                    currentOrder.setPaymentDate(rs.getString("payment_date"));

                    currentOrderId = orderId;  // Update current order id
                }

                // Add item details to the current order
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image"); // Get the image URL
                double price = rs.getDouble("price"); // Get the price

                OrderItem orderItem = new OrderItem();
                orderItem.setItemId(itemId);
                orderItem.setItemName(itemName);
                orderItem.setQuantity(quantity);
                orderItem.setImage(image); // Set the image URL
                orderItem.setPrice(price); // Set the price

                currentOrder.addOrderItem(orderItem);  // Add item to the current order
            }

            // Add the last order to the list if it's not already added
            if (currentOrder != null) {
                ordersList.add(currentOrder);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;  // Re-throw exception to be handled by the calling code
        }

        return ordersList;  // Return the list of orders with their items
    }

    public List<Orders> getCompletedOrdersByDeliveryExecutiveId(int deliveryExecutiveId) throws SQLException {

        List<Orders> ordersList = new ArrayList<>();
        String query = "SELECT o.order_id, o.total_amount AS total_amount, o.address AS customer_address, o.order_status, o.order_date, "
                + "r.restaurant_id,r.restaurant_name AS restaurant_name, r.address AS restaurant_address,r.phone as restaurant_phone, "
                + "p.payment_method, p.payment_status, p.payment_date, "
                + "oi.item_id, m.item_name, oi.quantity, m.image,o.phone as customer_phone "
                + "FROM orders o "
                + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
                + "LEFT JOIN payments p ON o.order_id = p.order_id "
                + "LEFT JOIN deliveries d ON o.order_id = d.order_id "
                + "JOIN order_items oi ON o.order_id = oi.order_id "
                + "JOIN menu_items m ON oi.item_id = m.item_id "
                + "WHERE d.delivery_executive_id = ? AND o.order_status = 'Delivered' "
                + "ORDER BY o.order_date DESC";

        try (Connection conn = Database.getConnection(); // Initialize connection locally
                PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, deliveryExecutiveId);
            ResultSet rs = pstmt.executeQuery();

            int currentOrderId = -1;
            Orders currentOrder = null;

            while (rs.next()) {
                int orderId = rs.getInt("order_id");

                // Check if we have a new order
                if (orderId != currentOrderId) {
                    if (currentOrder != null) {
                        ordersList.add(currentOrder); // Add the previous order to the list
                    }

                    // Create a new Orders object for the new order
                    currentOrder = new Orders();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setOrderStatus(rs.getString("order_status"));
                    currentOrder.setOrderDate(rs.getString("order_date"));
                    currentOrder.setTotalAmount(rs.getDouble("total_amount"));
                    currentOrder.setCustomerAddress(rs.getString("customer_address"));
                    currentOrder.setCustomerPhone(rs.getString("customer_phone"));
                    currentOrder.setRestaurantId(rs.getInt("restaurant_id"));
                    currentOrder.setRestaurantName(rs.getString("restaurant_name"));
                    currentOrder.setRestaurantAddress(rs.getString("restaurant_address"));
                    currentOrder.setRestaurantPhone(rs.getString("restaurant_phone"));
                    currentOrder.setPaymentMethod(rs.getString("payment_method"));
                    currentOrder.setPaymentStatus(rs.getString("payment_status"));
                    currentOrder.setPaymentDate(rs.getString("payment_date"));

                    currentOrderId = orderId;  // Update current order id
                }

                // Add item details to the current order
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image"); // Get the image URL

                OrderItem orderItem = new OrderItem();
                orderItem.setItemId(itemId);
                orderItem.setItemName(itemName);
                orderItem.setQuantity(quantity);
                orderItem.setImage(image); // Set the image URL

                currentOrder.addOrderItem(orderItem);  // Add item to the order
            }

            // Add the last order to the list
            if (currentOrder != null) {
                ordersList.add(currentOrder);
            }
        }

        return ordersList;  // Return the list of orders with their items
    }
}
