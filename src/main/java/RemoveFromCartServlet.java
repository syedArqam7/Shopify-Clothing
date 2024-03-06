import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/RemoveFromCart")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexParam = request.getParameter("index");

        if (indexParam != null && !indexParam.trim().isEmpty()) {
            try {
                int index = Integer.parseInt(indexParam);

                HttpSession session = request.getSession();
                List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

                if (cart != null && index >= 0 && index < cart.size()) {
                    cart.remove(index);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}
