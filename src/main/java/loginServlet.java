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

@WebServlet("/loginHome")
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (Connection connection = Database.getConnection()) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            String query = "SELECT * FROM customer WHERE customer_name = ? AND customer_password = ?";
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    boolean check = resultSet.next();
                    HttpSession session = request.getSession();


                    if(username.equals("Admin") && password.equals("admin!0")){
                        session.setAttribute("customerID", 2);
                        response.sendRedirect(request.getContextPath() + "/adminLogin");
                        return;
                    }


                    if (check) {
                        Customer customer = new Customer();
                        customer.setCustomer_id(resultSet.getInt("customer_id"));
                        System.out.println(customer.getCustomer_id());
                        customer.setCustomer_name(resultSet.getString("customer_name"));

                        session.setAttribute("customerID", customer.getCustomer_id());

                        request.setAttribute("loginSuccess", true);

                        request.getRequestDispatcher("/check.jsp").forward(request, response);
                    } else {
                        request.setAttribute("loginFailed", true);
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                    }
                }
            }
        } catch (ServletException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Error");
        }
    }
}
