package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.CallableStatement;
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
public class FazGrupoDao implements IFazGrupoDao{
	
	@Autowired
	GenericDao gDao;
	
	@Override
	public void Fazergrupos() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String proc_sql = "{CALL timesGrandes}";
		String proc_sql2 = "{CALL timesPequenos}";
		
		try {
			CallableStatement cs = c.prepareCall(proc_sql);
			cs.execute();
			CallableStatement cs2 = c.prepareCall(proc_sql2);
			cs2.execute();
			cs.close();
			} catch(Exception e) {
			}
			c.close();
	}
	
	
	@Override
	public List<grupos> listargrupos() throws SQLException, ClassNotFoundException {
		List<grupos> grupos = new ArrayList<grupos>();
		Connection c = gDao.getConnection();
		String sql = "SELECT t.NomeTime, g.Grupo \r\n"
				+ "FROM times t INNER JOIN grupos g ON t.CodigoTime = g.CodTime;";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			grupos g = new grupos();
			g.setTimes(rs.getString("NomeTime"));
			g.setGrupos(rs.getString("Grupo"));
			grupos.add(g);
		}
		rs.close();
		ps.close();
		c.close();
		
		return grupos;
	}
}
