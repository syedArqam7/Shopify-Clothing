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
import java.util.ArrayList;
import java.util.Comparator;

@WebServlet("/sortPrice")
public class sortPriceProductServlet extends HttpServlet {
    Connection connection;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        connection = Database.getConnection();

        try {
            String query = "SELECT product_id, product_name, price, image FROM products";
            assert connection != null;
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            ArrayList<Products> products = new ArrayList<>();

            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                String productName = resultSet.getString("product_name");
                double price = resultSet.getDouble("price");
                String image = resultSet.getString("image");

                products.add(new Products(productId, productName, price, image));
            }

            products.sort(Comparator.comparingDouble(Products::getPrice));

            int productIndex = 1;
            for (Products product : products) {
                String priceAttribute = "price_" + productIndex;
                String imageAttribute = "image_" + productIndex;
                String productNameAttribute = "product_name_" + productIndex;

                request.setAttribute(productNameAttribute, product.getProductName());
                request.setAttribute(priceAttribute, product.getPrice());
                request.setAttribute(imageAttribute, "productImages/" + product.getImage());

                productIndex++;
            }

            request.getRequestDispatcher("/prodSort.jsp").forward(request, response);

        } catch (ServletException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error");
        }
    }
}
