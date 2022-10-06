<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="plantilla/menu.jspf"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%
    String driver = "com.mysql.cj.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String database = "empresa";
    String userid = "root";
    String password = "";
    try {
        Class.forName(driver);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
%>

<%
    if(request.getParameter("emp_no_edit")!="null"){

    }else{
        DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        String currentDate = formatter.format(new Date());
        Statement st=connection.createStatement();
        int i=st.executeUpdate("INSERT INTO empleado ( apellido, oficio, dir, fecha_alt, salario, comision, dept_no) \n" +
                "VALUES ("+request.getParameter("apellido")+", "+request.getParameter("oficio")+", "+request.getParameter("dir")+", "+currentDate+", "+request.getParameter("salario")+", "+request.getParameter("comision")+", "+request.getParameter("dept_no")+" );");
        System.out.println(i);
    }
%>
<html>
<head>
    <title>Dynamic Drop Down List Demo - CodeJava.net</title>
</head>
<body>


<div class="container text-left">

    <form action="" method="post" name="formulario">
        <input type="hidden" name="emp_no_edit" value="<%= request.getParameter("emp_no")%>">
        <div class="mb-3">
            <label  class="form-label">Apellido</label>
            <input type="text" class="form-control" name="apellido" value="<%= request.getParameter("apellido")!="null" ?request.getParameter("apellido"):""%>" required placeholder="Apellido">

        </div>
        <div class="mb-3">
            <label  class="form-label text-left">Oficio</label>
            <input type="text" class="form-control" name="oficio" value="<%= request.getParameter("oficio")!="null" ?request.getParameter("oficio"):""%>" required placeholder="Oficio">
        </div>
        <div class="mb-3">
            <label  class="form-label text-left">Dir</label>
            <input type="number" class="form-control" name="dir" value="<%= request.getParameter("dir")!="null" ?request.getParameter("dir"):""%>" required placeholder="Dir">
        </div>
        <div class="mb-3">
            <label  class="form-label text-left">Salario</label>
            <input type="number" step="0.01" class="form-control" name="salario" value="<%= request.getParameter("salario")!="null" ?request.getParameter("salario"):""%>" placeholder="Salario">
        </div>

        <%=request.getParameter("combo")%>
        <select class="form-select" name="combo" aria-label="Default select example">
            <%
                try{
                    statement=connection.createStatement();
                    String sql ="select * from departamentos";
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                        if(request.getParameter("combo")!="null" && request.getParameter("emp_no_edit")!="null"){


            %>
            <option  <%= request.getParameter("combo")!="null"?request.getParameter("combo").equals(resultSet.getString("dept_no"))?"selected":"id=1":"id=0"%> value="<%=resultSet.getString("dept_no") %>"><%=resultSet.getString("dnombre") %></option>
            <%
                        }else {
            %>
            <option   value="<%=resultSet.getString("dept_no") %>"><%=resultSet.getString("dnombre") %></option>
            <%
            }
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select>
        <div>
            <input type="submit" value="Actualizar">
        </div>
    </form>

    <table border="1">
        <tr>
            <td>Codigo</td>
            <td>Apellido</td>
            <td>Oficio</td>
            <td>Direccion</td>
            <td>Fecha Alt</td>
            <td>Salario</td>
        </tr>
        <%
            try{
                connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                statement=connection.createStatement();
                String sql ="select * from empleado";
                resultSet = statement.executeQuery(sql);
                while(resultSet.next()){
        %>
        <tr>
            <td><%=resultSet.getString("emp_no") %></td>
            <td><%=resultSet.getString("apellido") %></td>
            <td><%=resultSet.getString("oficio") %></td>
            <td><%=resultSet.getString("dir") %></td>
            <td><%=resultSet.getString("fecha_alt") %></td>
            <td><%=resultSet.getString("salario") %></td>
            <td>
                <form action="" method="get">
                    <input type="hidden" name="emp_no" value="<%=resultSet.getString("emp_no") %>">
                    <input type="hidden" name="apellido" value="<%=resultSet.getString("apellido") %>">
                    <input type="hidden" name="oficio" value="<%=resultSet.getString("oficio") %>">
                    <input type="hidden" name="dir" value="<%=resultSet.getString("dir") %>">
                    <input type="hidden" name="fecha_alt" value="<%=resultSet.getString("fecha_alt") %>">
                    <input type="hidden" name="salario" value="<%=resultSet.getString("salario") %>">
                    <input type="hidden" name="combo" value="<%=resultSet.getString("dept_no") %>">
                    <input type="submit" value="Editar">
                </form>
            </td>

        </tr>
        <%
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

</div>
</body>
</html>
