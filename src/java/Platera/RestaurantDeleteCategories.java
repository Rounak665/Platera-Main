package Platera;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "RestaurantDeleteCategories", urlPatterns = {"/RestaurantDeleteCategories"})
public class RestaurantDeleteCategories extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the restaurantId from session
        HttpSession session = request.getSession();
        Integer restaurantId = (Integer) session.getAttribute("restaurant_id");

        // If restaurantId is not found in session, return an error
        if (restaurantId == null) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>Restaurant not found. Please log in again.</h3>");
            return;
        }

        // Get the category ID to be deleted
        String categoryIdParam = request.getParameter("category_id");
        if (categoryIdParam == null || categoryIdParam.isEmpty()) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>Invalid category ID provided.</h3>");
            return;
        }

        int categoryId = Integer.parseInt(categoryIdParam);

        // Query to remove the category from restaurant_categories
        String updateQuery = "UPDATE restaurant_categories SET "
                + "category_1 = CASE WHEN category_1 = ? THEN NULL ELSE category_1 END, "
                + "category_2 = CASE WHEN category_2 = ? THEN NULL ELSE category_2 END, "
                + "category_3 = CASE WHEN category_3 = ? THEN NULL ELSE category_3 END "
                + "WHERE restaurant_id = ?";

        try (Connection conn = Utilities.Database.getConnection();
                PreparedStatement ps = conn.prepareStatement(updateQuery)) {

            // Set query parameters
            ps.setInt(1, categoryId);
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, restaurantId);

            // Execute the update
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.setContentType("text/html");
                response.getWriter().println("<h3>Category deleted successfully.</h3>");
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<h3>No changes made. Category may not exist for this restaurant.</h3>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>An error occurred while deleting the category. Please try again later.</h3>");
        }
    }
}
