package com.example.webapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

public class HistoryServlet extends HttpServlet {

    private String getSearchId(String x) {
        String[] y = x.split("=");
        y[1] = y[1].substring(0, y[1].length() - 1);
        return y[1];
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        String[] paramNames = {"customer", "startDate", "endDate"};
        PrintWriter out = new PrintWriter(response.getWriter(), true);
        String x = request.getParameter(paramNames[1]);
        if (Objects.equals(x, ""))
            out.println("yes");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        /*
         * If receive any get request redirect user back to login form.
         */
        doPost(request, response);
    }

}
