import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin")
public class adminCrudServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "addProduct" -> addProduct(request, response);
            case "editProduct" -> editProduct(request, response);
            case "deleteProduct" -> deleteProduct(request, response);
            case "deleteCustomer" -> deleteCustomer(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/admin.jsp?success=true");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        int sizeId = Integer.parseInt(request.getParameter("sizeId"));
        String availabilityStatus = request.getParameter("availabilityStatus");
        String image = request.getParameter("image");

        Connection connection = null;
        try {
            connection = Database.getConnection();
            String query = "INSERT INTO products (product_name, product_description, price, category_id, brand_id, size_id, availability_status, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, productName);
                preparedStatement.setString(2, productDescription);
                preparedStatement.setDouble(3, price);
                preparedStatement.setInt(4, categoryId);
                preparedStatement.setInt(5, brandId);
                preparedStatement.setInt(6, sizeId);
                preparedStatement.setString(7, availabilityStatus);
                preparedStatement.setString(8, image);
                preparedStatement.executeUpdate();
            }

            response.sendRedirect(request.getContextPath() + "/admin.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productID = Integer.parseInt(request.getParameter("productID"));
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        int sizeId = Integer.parseInt(request.getParameter("sizeId"));
        String availabilityStatus = request.getParameter("availabilityStatus");
        String image = request.getParameter("image");

        Connection connection = null;
        try {
            connection = Database.getConnection();

            if (!checkIDExistence(connection, "products", "product_id", productID)) {
                showErrorPopup(response, "Product ID does not exist!");
                return;
            }

            String query = "UPDATE products SET product_name=?, product_description=?, price=?, category_id=?, brand_id=?, size_id=?, availability_status=?, image=? WHERE product_id=?";
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, productName);
                preparedStatement.setString(2, productDescription);
                preparedStatement.setDouble(3, price);
                preparedStatement.setInt(4, categoryId);
                preparedStatement.setInt(5, brandId);
                preparedStatement.setInt(6, sizeId);
                preparedStatement.setString(7, availabilityStatus);
                preparedStatement.setString(8, image);
                preparedStatement.setInt(9, productID);
                preparedStatement.executeUpdate();
            }

            response.sendRedirect(request.getContextPath() + "/adminEdit.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productID = Integer.parseInt(request.getParameter("productID"));

        Connection connection = null;
        try {
            connection = Database.getConnection();

            if (!checkIDExistence(connection, "products", "product_id", productID)) {
                showErrorPopup(response, "Product ID does not exist!");
                return;
            }

            String query = "DELETE FROM products WHERE product_id=?";
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, productID);
                preparedStatement.executeUpdate();
            }

            response.sendRedirect(request.getContextPath() + "/adminDelete.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int customerID = Integer.parseInt(request.getParameter("customerID"));

        Connection connection = null;
        try {
            connection = Database.getConnection();
            assert connection != null;
            connection.setAutoCommit(false);

            if (!checkIDExistence(connection, "customer", "customer_id", customerID)) {
                showErrorPopup(response, "Customer ID does not exist!");
                return;
            }

            String deleteOrderItemsQuery = "DELETE FROM orderitems WHERE order_id IN (SELECT order_id FROM orders WHERE customer_id = ?)";
            try (PreparedStatement deleteOrderItemsStatement = connection.prepareStatement(deleteOrderItemsQuery)) {
                deleteOrderItemsStatement.setInt(1, customerID);
                deleteOrderItemsStatement.executeUpdate();
            }

            String deleteOrdersQuery = "DELETE FROM orders WHERE customer_id = ?";
            try (PreparedStatement deleteOrdersStatement = connection.prepareStatement(deleteOrdersQuery)) {
                deleteOrdersStatement.setInt(1, customerID);
                deleteOrdersStatement.executeUpdate();
            }

            String deleteCustomerQuery = "DELETE FROM customer WHERE customer_id = ?";
            try (PreparedStatement deleteCustomerStatement = connection.prepareStatement(deleteCustomerQuery)) {
                deleteCustomerStatement.setInt(1, customerID);
                deleteCustomerStatement.executeUpdate();
            }

            connection.commit();

            response.sendRedirect(request.getContextPath() + "/adminDelCustomer.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackException) {
                    rollbackException.printStackTrace();
                }
            }
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    private boolean checkIDExistence(Connection connection, String tableName, String idColumnName, int id) throws SQLException {
        String checkExistenceQuery = "SELECT * FROM " + tableName + " WHERE " + idColumnName + "=?";
        try (PreparedStatement checkExistenceStatement = connection.prepareStatement(checkExistenceQuery)) {
            checkExistenceStatement.setInt(1, id);
            try (ResultSet resultSet = checkExistenceStatement.executeQuery()) {
                return resultSet.next();
            }
        }
    }
    private void showErrorPopup(HttpServletResponse response, String message) throws IOException {
        response.getWriter().write("<script>showErrorPopup('" + message + "');</script>");
    }
}
