<%@ page import="com.example.webapp.CustomerDAO" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.webapp.ProductDAO" %>
<%@ page import="com.example.webapp.Customer" %>
<%@ page import="com.example.webapp.Promote" %>
<%@ page import="com.example.webapp.Product" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>ERP MANAGER</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <!--logo-->
    <link rel="icon" href="images/logo.png">

</head>
<body class="dark-mode">

<%
    String role = (String) session.getAttribute("role");

    if (role == null) {
%>
<jsp:forward page="login.jsp"/>
<%
        //response.sendRedirect("http://localhost:8080/WebApp_war_exploded/login.jsp");
    }

    if (!role.equals("Salesman")) {
%>
<jsp:forward page="index.jsp"/>
<%
        //response.sendRedirect("http://localhost:8080/WebApp_war_exploded/index.jsp");
    }

%>

<jsp:include page="header.jsp">
    <jsp:param name="role" value="<%=role%>"/>
</jsp:include>


<!-- Search -->
<div class="container text-center" style="margin-top: 100px">
    <form role="search" action="PromoteServlet" type="POST">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="input-group mb-3">
                    <div class="form-floating">
                        <input class="form-control" name="customer" list="search_customers_list" type="search"
                               id="search_customers"
                               placeholder="Add Customer" aria-label="Search">
                        <datalist id="search_customers_list">
                            <%
                                CustomerDAO customer = new CustomerDAO();
                                ResultSet rs = customer.getAllCustomers();
                                if (rs == null) {
                                    throw new Exception("Error");
                                }

                                while (rs.next()) {
                                    String name = rs.getString("Name");
                                    String surname = rs.getString("Surname");
                                    String id = rs.getString("id");

                            %>
                            <option value="<%=name + " " + surname + " (ID=" + id+")"%>">
                                    <%
                                }
                                rs.close();
                                customer.close();
                            %>
                        </datalist>
                        <label for="search_customers" class="text-black">Add Customers</label>
                    </div>
                    <button class="btn input-group-text bg-success" type="submit"><i
                            class="bi bi-plus-lg"></i></button>
                </div>
            </div>
        </div>
    </form>
    <form role="search" action="PromoteServlet" type="POST">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="input-group mb-3">
                    <div class="form-floating">
                        <input class="form-control" list="search_products_list" name="product" type="search"
                               id="search_products"
                               placeholder="Add Product" aria-label="Search">
                        <datalist id="search_products_list">
                            <%
                                ProductDAO product = new ProductDAO();
                                ResultSet rs1 = product.getAllProducts();
                                if (rs1 == null) {
                                    throw new Exception("Error");
                                }

                                while (rs1.next()) {
                                    String name = rs1.getString("Name");
                                    String id = rs1.getString("id");
                            %>
                            <option value="<%=name + " (ID=" + id+")"%>">
                                    <%
                                }
                                rs1.close();
                                product.close();
                            %>
                        </datalist>
                        <label for="search_products" class="text-black">Add Products</label>
                    </div>
                    <button class="btn input-group-text bg-success" type="submit"><i
                            class="bi bi-plus-lg"></i></button>
                </div>
            </div>
        </div>
    </form>
</div>

<br>
<br>
<br>

<div class="container text-center">
    <form action="PromoteServlet" type="POST" onsubmit="myFunction();">
        <!-- Tables-->
        <div class="row justify-content-evenly">
            <div class="col-5">
                <div class="table-responsive-md">
                    <table class="table bg-white caption-top" id="client_table">
                        <caption class="bg-white text-center"><h4>List of Clients </h4></caption>
                        <thead>
                        <tr>
                            <th scope="col">#Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Surname</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Customer cust : Promote.getCustomers()) {
                        %>
                        <tr>
                            <th scope="row"><%=cust.getId()%>
                            </th>
                            <td><%=cust.getName()%>
                            </td>
                            <td><%=cust.getSurname()%>
                            </td>
                            <td>
                                <button type="submit" class="btn btn-danger small" value="<%=cust.toString()%>"
                                        name="remove_client<%=cust.getId()%>"><i
                                        class="bi bi-dash-lg"></i></button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <input type="hidden" class="visually-hidden" name="client_number" id="client_number" value="">
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-5">
                <div class="table-responsive-md">
                    <table class="table bg-white caption-top" id="product_table">
                        <caption class="bg-white text-center"><h4>List of Products </h4></caption>
                        <thead>
                        <tr>
                            <th scope="col">#Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Price</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Product prod : Promote.getProducts()) {
                        %>
                        <tr>
                            <th scope="row"><%=prod.getId()%>
                            </th>
                            <td><%=prod.getName()%>
                            </td>
                            <td><%=prod.getPrice()%> <i class="bi bi-currency-euro"></i></td>
                            <td>
                                <button type="submit" class="btn btn-danger small" value="<%=prod.toString()%>"
                                        name="remove_product<%=prod.getId()%>"><i
                                        class="bi bi-dash-lg"></i></button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <input type="hidden" class="visually-hidden" name="product_number" id="product_number" value="">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <br>
        <br>

        <div class="d-grid gap-2 col-8 mx-auto">
            <button class="btn btn-primary" type="submit"
                    onclick="return confirm('Do you really want to submit the form?');">Submit
            </button>
        </div>

    </form>
</div>
</body>
<!-- Scripts -->
<script src="js/jquery.min.js"></script> <!-- jQuery for Bootstrap's JavaScript plugins -->
<script src="js/scripts.js"></script> <!-- Custom scripts -->
<script src="js/bootstrap.bundle.min.js"></script>
<script>
    function myFunction() {
        var client_number = document.getElementById("client_table").rows.length;
        var product_number = document.getElementById("product_table").rows.length;
        var c = document.getElementById("client_number")
        c.value = client_number - 1
        var p = document.getElementById("product_number")
        p.value = product_number - 1
    }

</script>
</html>