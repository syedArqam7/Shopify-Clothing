import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/productCountServlet")
public class ProductCountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Object cartObject = session.getAttribute("cart");

        int productCount = 0;
        if (cartObject instanceof java.util.List) {
            productCount = ((java.util.List<?>) cartObject).size();
        }

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(productCount);
        out.flush();
    }
}
