import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.annotation.WebServlet;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Product")
public class productInformationServlet extends HttpServlet {
    Connection connection;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        connection = Database.getConnection();

        try {
            String query = "SELECT product_name, price, image FROM products";
            assert connection != null;
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            int productIndex = 1;

            while (resultSet.next()) {
                String productNameAttribute = "product_name_" + productIndex;
                String priceAttribute = "price_" + productIndex;
                String imageAttribute = "image_" + productIndex;

                request.setAttribute(productNameAttribute, resultSet.getString("product_name"));
                request.setAttribute(priceAttribute, resultSet.getDouble("price"));
                request.setAttribute(imageAttribute, resultSet.getString("image"));

                productIndex++;
            }

            request.getRequestDispatcher("/prod.jsp").forward(request, response);

        } catch (ServletException serv) {
            serv.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Servlet Error");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Error");
        }
    }
}
