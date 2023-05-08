package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Component;

@Component
public class GenericDao {
	
	private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		String hostName = "localhost";
		String dbName = "paulistao";
		String user = "sa";
		String senha = "123456";
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		String connect = String.format("jdbc:jtds:sqlserver://%s:50144;databaseName=%s;user=%s;password=%s",hostName, dbName, user, senha);
		c = DriverManager.getConnection(connect);
		return c;
	}
}