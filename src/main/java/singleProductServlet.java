import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/singleProductServlet")
public class singleProductServlet extends HttpServlet {
    Connection connection;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        connection = Database.getConnection();

        try {
            String productName = request.getParameter("product_name");

            if (productName != null) {
                String query = "SELECT product_name, price, image, product_description FROM products WHERE product_name = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, productName);

                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    String product_name = resultSet.getString("product_name");
                    double price = resultSet.getDouble("price");
                    String image = resultSet.getString("image");
                    String product_description = resultSet.getString("product_description");

                    request.setAttribute("product_name", product_name);
                    request.setAttribute("price", price);
                    request.setAttribute("image", image);
                    request.setAttribute("product_description", product_description);

                    String[] recentProductNames = getRecentProductNames();
                    double[] recentProductPrices = getRecentProductPrices();
                    String[] recentProductImages = getRecentProductImages();

                    request.setAttribute("recentProductNames", recentProductNames);
                    request.setAttribute("recentProductPrices", recentProductPrices);
                    request.setAttribute("recentProductImages", recentProductImages);

                    request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product name parameter is missing");
            }

        } catch (ServletException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Servlet Error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Error");
        }
    }

    private String[] getRecentProductNames() throws SQLException {
        String query = "SELECT product_name FROM products ORDER BY product_id DESC LIMIT 4";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();

        String[] recentProductNames = new String[4];
        int index = 0;

        while (resultSet.next() && index < 4) {
            recentProductNames[index] = resultSet.getString("product_name");
            index++;
        }

        return recentProductNames;
    }

    private double[] getRecentProductPrices() throws SQLException {
        String query = "SELECT price FROM products ORDER BY product_id DESC LIMIT 4";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();

        double[] recentProductPrices = new double[4];
        int index = 0;

        while (resultSet.next() && index < 4) {
            recentProductPrices[index] = resultSet.getDouble("price");
            index++;
        }

        return recentProductPrices;
    }

    private String[] getRecentProductImages() throws SQLException {
        String query = "SELECT image FROM products ORDER BY product_id DESC LIMIT 4";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();

        String[] recentProductImages = new String[4];
        int index = 0;

        while (resultSet.next() && index < 4) {
            recentProductImages[index] = resultSet.getString("image");
            index++;
        }

        return recentProductImages;
    }
}
