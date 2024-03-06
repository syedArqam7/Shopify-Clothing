import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/allOrders")
public class allOrdersServlet extends HttpServlet {
    private static final Connection connection = Database.getConnection();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int customerID = Integer.parseInt(request.getParameter("customerID"));

        if (customerID > 0) {
            List<Map<String, Object>> allOrders;
            try {
                allOrders = getAllOrdersByCustomer(customerID);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            session.setAttribute("allOrders", allOrders);
            session.setAttribute("customerID", customerID
            );

            request.getRequestDispatcher("/allOrders.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    private static List<Map<String, Object>> getAllOrdersByCustomer(int customerID) throws SQLException {
        String sql = "SELECT o.order_id, o.order_date, o.total_price, o.order_status, "
                + "p.product_name, oi.quantity, oi.subtotal "
                + "FROM orders o "
                + "JOIN orderitems oi ON o.order_id = oi.order_id "
                + "JOIN products p ON oi.product_id = p.product_id "
                + "WHERE o.customer_id = ? ";

        assert connection != null;
        PreparedStatement statement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        statement.setInt(1, customerID);

        ResultSet resultSet = statement.executeQuery();
        List<Map<String, Object>> allOrders = new ArrayList<>();

        while (resultSet.next()) {
            int orderId = resultSet.getInt("order_id");
            Map<String, Object> order = new HashMap<>();
            order.put("orderID", orderId);
            order.put("orderDate", resultSet.getDate("order_date"));
            order.put("total", resultSet.getDouble("total_price"));
            order.put("orderStatus", resultSet.getString("order_status"));

            List<Map<String, Object>> orderProducts = new ArrayList<>();
            do {
                if (orderId == resultSet.getInt("order_id")) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("productName", resultSet.getString("product_name"));
                    product.put("quantity", resultSet.getInt("quantity"));
                    product.put("subtotal", resultSet.getDouble("subtotal"));
                    orderProducts.add(product);
                } else {
                    resultSet.previous();
                    break;
                }
            } while (resultSet.next());

            order.put("products", orderProducts);
            allOrders.add(order);
        }

        return allOrders;
    }

}
