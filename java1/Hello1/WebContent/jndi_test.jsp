<html>
  <head>
    <%@ page errorPage="errorpg.jsp" 
             import="java.sql.*, 
                     javax.sql.*, 
                     java.io.*,
                     javax.naming.InitialContext,
                     javax.naming.Context" %>
  </head>
  <body>
    <h1>JDBC JNDI JSP Resource Test</h1>
   
<%
System.out.println("Console--testLine L14********************");
out.println("<BR>Browser--testLine L15");
String dsString = "java:/comp/env/myDataBaseName";
 
InitialContext initCtx = new InitialContext();
if ( initCtx == null ) {
   throw new Exception("Uh oh -- no context!");
}
DataSource ds = (DataSource) initCtx.lookup(dsString);
if ( ds == null ) {
   throw new Exception("Data source not found!");
}
System.out.println("Console--testLine L26");
out.println("<BR>Browser--testLine L27");

Connection conn  = null;

try {                   
 	conn = ds.getConnection();
    if(conn == null) throw new Exception("No DB Connection");
    System.out.println("Console--testLine L34");
	out.println("<BR>Browser--testLine L35");

    Statement stmt = conn.createStatement();
    ResultSet rset = stmt.executeQuery("select * from DISCIPLINE_SR");
    System.out.println("Console--testLine L39********************");
	out.println("<BR>Browser--testLine L40");
	out.println("<BR><BR><BR>"); 
	 %>
	<table width=‘600’ border=‘1’> 
	<tr>
	<th align=‘left’>Name</th>
	<th align=‘left’>Discipline</th>
	<th align=‘left’>Dept ID</th>
	</tr>
      <% 

	while (rset.next()) {         
		%>
		<tr><td> <%= rset.getString(1)  %></td>
		<td> <%= rset.getString(2)  %></td>
		<td> <%= rset.getString(3)  %></td>
		</tr>
	<%  }
	rset.close();
	stmt.close();
    } catch(SQLException e)
  	 {
	      // Do exception catch such as if connection is not made or 
	      // query is not set up properly
	      out.println("SQLException: " + e.getMessage() + "<BR>");
	      while((e = e.getNextException()) != null)
	      out.println(e.getMessage() + "<BR>");
  	 } catch(ClassNotFoundException e)
	  {
	      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
	  }
finally
   {
      //Clean up resources, close the connection.
      if(conn != null)
      {
         try
         {
            conn.close();
            initCtx.close();

         }
         catch (Exception ignored) {}
      }
   }
 %>
    </table>
  </body>
</html>


