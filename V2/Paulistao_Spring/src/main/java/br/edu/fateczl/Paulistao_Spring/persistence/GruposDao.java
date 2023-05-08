package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.Paulistao_Spring.model.grupos;

@Component
public class GruposDao implements IGruposDao{
	
	@Autowired
	GenericDao gDao;
	
	@Override
	public List<grupos> listargrupoA() throws SQLException, ClassNotFoundException {
		List<grupos> grupoA = new ArrayList<grupos>();
		Connection c = gDao.getConnection();
		String sql = "SELECT t.NomeTime, g.Grupo \r\n"
				+ "FROM times t INNER JOIN grupos g ON t.CodigoTime = g.CodTime\r\n"
				+ "WHERE g.Grupo = 'A';";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			grupos g = new grupos();
			g.setTimes(rs.getString("NomeTime"));
			g.setGrupos(rs.getString("Grupo"));
			grupoA.add(g);
		}
		rs.close();
		ps.close();
		c.close();
		return grupoA;
	}

	@Override
	public List<grupos> listargrupoB() throws SQLException, ClassNotFoundException {
		List<grupos> grupoB = new ArrayList<grupos>();
		Connection c = gDao.getConnection();
		String sql = "SELECT t.NomeTime, g.Grupo \r\n"
				+ "FROM times t INNER JOIN grupos g ON t.CodigoTime = g.CodTime "
				+ "WHERE g.Grupo = 'B'";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			grupos g = new grupos();
			g.setTimes(rs.getString("NomeTime"));
			g.setGrupos(rs.getString("Grupo"));
			grupoB.add(g);
		}
		rs.close();
		ps.close();
		c.close();
		
		return grupoB;
	}

	@Override
	public List<grupos> listargrupoC() throws SQLException, ClassNotFoundException {
		List<grupos> grupoC = new ArrayList<grupos>();
		Connection c = gDao.getConnection();
		String sql = "SELECT t.NomeTime, g.Grupo \r\n"
				+ "FROM times t INNER JOIN grupos g ON t.CodigoTime = g.CodTime "
				+ "WHERE g.Grupo = 'C'";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			grupos g = new grupos();
			g.setTimes(rs.getString("NomeTime"));
			g.setGrupos(rs.getString("Grupo"));
			grupoC.add(g);
		}
		rs.close();
		ps.close();
		c.close();
		
		return grupoC;
	}

	@Override
	public List<grupos> listargrupoD() throws SQLException, ClassNotFoundException {
		List<grupos> grupoD = new ArrayList<grupos>();
		Connection c = gDao.getConnection();
		String sql = "SELECT t.NomeTime, g.Grupo \r\n"
				+ "FROM times t INNER JOIN grupos g ON t.CodigoTime = g.CodTime "
				+ "WHERE g.Grupo = 'D'";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			grupos g = new grupos();
			g.setTimes(rs.getString("NomeTime"));
			g.setGrupos(rs.getString("Grupo"));
			grupoD.add(g);
		}
		rs.close();
		ps.close();
		c.close();
		
		return grupoD;
	}
	
}
