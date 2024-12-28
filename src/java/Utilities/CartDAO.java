package Utilities;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Method to retrieve all cart items for a specific user
    public List<Cart> getCartItems(int customerId) {
        List<Cart> cartItems = new ArrayList<>();
        String query = "SELECT c.cart_id, c.item_id, m.item_name, m.image, m.price as item_price, c.total_price, c.quantity, r.restaurant_id, r.restaurant_name, co.coupon_id, co.coupon_discount "
                + "FROM cart c "
                + "LEFT JOIN menu_items m ON c.item_id = m.item_id "
                + "LEFT JOIN restaurants r ON c.restaurant_id = r.restaurant_id "
                + "LEFT JOIN coupons co ON c.coupon_id = co.coupon_id "
                + "WHERE c.customer_id = ?";

        try (Connection conn = Database.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setItemId(rs.getInt("item_id"));
                    cart.setItemName(rs.getString("item_name"));
                    cart.setItemImage(rs.getString("image"));
                    cart.setItemPrice(rs.getDouble("item_price"));
                    cart.setTotalPrice(rs.getDouble("total_price"));
                    cart.setQuantity(rs.getInt("quantity"));
                    cart.setRestaurantId(rs.getInt("restaurant_id"));
                    cart.setRestaurantName(rs.getString("restaurant_name"));
                    cart.setCouponId(rs.getInt("coupon_id"));
                    cart.setCouponDiscount(rs.getDouble("coupon_discount"));
                    cartItems.add(cart);
                    count++;
                }
                System.out.println("Found " + count + " cart items for customer ID: " + customerId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    // Method to retrieve a specific cart item by cartId
    public Cart getCartItemById(int cartId) {
        Cart cart = null;
        String query = "SELECT c.cart_id, c.item_id, m.item_name, m.image, m.price as item_price, c.total_price, c.quantity, r.restaurant_name, co.coupon_id, co.coupon_discount "
                + "FROM cart c "
                + "LEFT JOIN menu_items m ON c.item_id = m.item_id "
                + "LEFT JOIN restaurants r ON c.restaurant_id = r.restaurant_id "
                + "LEFT JOIN coupons co ON c.coupon_id = co.coupon_id "
                + "WHERE c.cart_id = ?";

        try (Connection conn = Database.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, cartId); // Set the cart ID to query for
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setItemId(rs.getInt("item_id"));
                    cart.setItemName(rs.getString("item_name"));
                    cart.setItemImage(rs.getString("image"));
                    cart.setItemPrice(rs.getDouble("item_price"));
                    cart.setTotalPrice(rs.getDouble("total_price"));
                    cart.setQuantity(rs.getInt("quantity"));
                    cart.setRestaurantName(rs.getString("restaurant_name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }
    

    // Method to add an item to the cart
    public boolean addItemToCart(Cart cart) {
        String query = "INSERT INTO cart (customer_id, item_id, price, quantity, restaurant_id, total_price) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Database.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            double totalPrice = cart.getItemPrice() * cart.getQuantity();

            stmt.setInt(1, cart.getUserId());
            stmt.setInt(2, cart.getItemId());
            stmt.setDouble(3, cart.getItemPrice());
            stmt.setInt(4, cart.getQuantity());
            stmt.setInt(5, cart.getRestaurantId());
            stmt.setDouble(6, totalPrice);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Method to update item quantity and total price in the cart
public boolean updateItemQuantity(int cartId, int quantity) {
    String query = "UPDATE cart SET quantity = ? WHERE cart_id = ?";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {

        stmt.setInt(1, quantity);  // Set the new quantity
        stmt.setInt(2, cartId);     // Set the cart ID to identify the item

        return stmt.executeUpdate() > 0;  // Return true if the update was successful
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;  // Return false if an exception occurred
}


    // Method to remove an item from the cart
    public boolean removeItemFromCart(int cartId) {
        String query = "DELETE FROM cart WHERE cart_id = ?";

        try (Connection conn = Database.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, cartId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Method to clear the cart for a user
    public boolean clearCart(int customerId) {
        String query = "DELETE FROM cart WHERE customer_id = ?";

        try (Connection conn = Database.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customerId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}