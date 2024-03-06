import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/sendInfoCart")
public class sendInfoCartServlet extends HttpServlet {
    Connection connection;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        connection = Database.getConnection();

        try {
            String productName = request.getParameter("product_name");
            String priceParam = request.getParameter("price");

            if (priceParam == null || priceParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Price parameter is missing");
                return;
            }
            double price = Double.parseDouble(priceParam);

            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String query = "SELECT product_id, image FROM products WHERE product_name = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, productName);

            ResultSet resultSet = preparedStatement.executeQuery();

            int productId = 0;
            String image = "";

            if (resultSet.next()) {
                productId = resultSet.getInt("product_id");
                image = resultSet.getString("image");
                System.out.println(image);
            }

            double subtotal = price * quantity;

            HttpSession session = request.getSession(true);

            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            Map<String, Object> cartItem = new HashMap<>();
            cartItem.put("productId", productId);
            cartItem.put("productName", productName);
            cartItem.put("price", price);
            cartItem.put("quantity", quantity);
            cartItem.put("subtotal", subtotal);
            cartItem.put("image", image);

            cart.add(cartItem);

            String referringPage = request.getHeader("referer");
            response.sendRedirect(referringPage);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Servlet Error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Error");
        }
    }
}
