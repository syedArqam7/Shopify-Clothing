import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.Serial;
import java.sql.*;

@WebServlet("/signUp")
public class signUpServlet extends HttpServlet {
    Connection connection;
    @Serial
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        connection = Database.getConnection();

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("pass");
            String rePassword = request.getParameter("re_pass");
            String contact = request.getParameter("contact");
            String address = request.getParameter("address");

            Customer customer = new Customer();
            customer.setCustomer_name(name);
            customer.setCustomer_email(email);
            customer.setCustomer_password(password);
            customer.setCustomer_phoneNumber(contact);
            customer.setCustomer_address(address);

            String query = "INSERT INTO customer (customer_name, customer_email, customer_password, customer_address, customer_phoneNumber) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, customer.getCustomer_name());
            preparedStatement.setString(2, customer.getCustomer_email());
            preparedStatement.setString(3, customer.getCustomer_password());
            preparedStatement.setString(4, customer.getCustomer_address());
            preparedStatement.setString(5, customer.getCustomer_phoneNumber());

            preparedStatement.executeUpdate();

            System.out.println("added");

            preparedStatement.close();
            connection.close();

            request.getRequestDispatcher("/login.jsp").forward(request, response);

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