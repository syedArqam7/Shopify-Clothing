import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class placeOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(true);

        int customerID = (int) session.getAttribute("customerID");
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (customerID > 0 && cart != null && !cart.isEmpty()) {
            Connection connection;

            try {
                connection = Database.getConnection();
                assert connection != null;
                connection.setAutoCommit(false);

                String orderInsertQuery = "INSERT INTO orders (customer_id, order_date, total_price, order_status) VALUES (?, ?, ?, ?)";
                try (PreparedStatement orderInsertStatement = connection.prepareStatement(orderInsertQuery, Statement.RETURN_GENERATED_KEYS)) {
                    Timestamp orderDate = new Timestamp(System.currentTimeMillis());
                    double total = calculateTotal(cart);
                    String orderStatus = "Ordered";

                    orderInsertStatement.setInt(1, customerID);
                    orderInsertStatement.setTimestamp(2, orderDate);
                    orderInsertStatement.setDouble(3, total);
                    orderInsertStatement.setString(4, orderStatus);

                    int affectedRows = orderInsertStatement.executeUpdate();

                    if (affectedRows == 0) {
                        throw new SQLException("Order insertion failed, no rows affected.");
                    }

                    int orderID;
                    try (ResultSet generatedKeys = orderInsertStatement.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            orderID = generatedKeys.getInt(1);
                        } else {
                            throw new SQLException("Order insertion failed, no order ID obtained.");
                        }
                    }

                    for (Map<String, Object> cartItem : cart) {
                        String productName = (String) cartItem.get("productName");
                        int quantity = (int) cartItem.get("quantity");

                        int productID = getProductIdByName(connection, productName);

                        double subtotal = getSubtotalByProductName(connection, productName);

                        String orderItemsInsertQuery = "INSERT INTO orderitems (order_id, product_id, quantity, subtotal) VALUES (?, ?, ?, ?)";
                        try (PreparedStatement orderItemsInsertStatement = connection.prepareStatement(orderItemsInsertQuery)) {
                            orderItemsInsertStatement.setInt(1, orderID);
                            orderItemsInsertStatement.setInt(2, productID);
                            orderItemsInsertStatement.setInt(3, quantity);
                            orderItemsInsertStatement.setDouble(4, subtotal);

                            orderItemsInsertStatement.executeUpdate();
                        }
                    }

                    connection.commit();

                    session.setAttribute("customerID", customerID);
                    List<Map<String, Object>> orderDetails = new ArrayList<>(cart);
                    session.setAttribute("orderDetails", orderDetails);

                    cart.clear();
                    session.setAttribute("cart", cart);

                    response.sendRedirect(request.getContextPath() + "/orderSuccess.jsp");

                } catch (SQLException e) {
                    e.printStackTrace();
                    try {
                        if (connection != null) {
                            connection.rollback();
                        }
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Order placement failed.");

                } finally {
                    try {
                        if (connection != null) {
                            connection.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid customer or empty cart.");
        }
    }

    private double calculateTotal(List<Map<String, Object>> cart) {
        double total = 0.0;
        for (Map<String, Object> cartItem : cart) {
            total += (double) cartItem.get("subtotal");
        }
        return total;
    }

    private int getProductIdByName(Connection connection, String productName) throws SQLException {
        int productID = -1;
        String query = "SELECT product_id FROM products WHERE product_name = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, productName);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    productID = resultSet.getInt("product_id");
                }
            }
        }
        return productID;
    }

    private double getSubtotalByProductName(Connection connection, String productName) throws SQLException {
        double subtotal = 0.0;
        String query = "SELECT price FROM products WHERE product_name = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, productName);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    double price = resultSet.getDouble("price");
                    int quantity = 1; // Assuming quantity is 1 for the subtotal calculation
                    subtotal = price * quantity;
                }
            }
        }
        return subtotal;
    }
}
