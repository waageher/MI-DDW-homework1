package cvut.fit.ddw.waageher.homework1;

import cvut.fit.ddw.waageher.homework1.gate.ReviewEvaluatorClient;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * @author Bc. Herbert Waage
 */
@SuppressWarnings("serial")
public class Startup extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("----------");
        System.out.println("---------- Startup Servlet Initialized successfully ----------");
        System.out.println("----------");
        //MachineLearningClient.getInstance();
    }
}
