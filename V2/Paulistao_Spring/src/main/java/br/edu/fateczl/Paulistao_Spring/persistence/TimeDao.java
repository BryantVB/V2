package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.Paulistao_Spring.model.time;

@Component
public class TimeDao implements ITimeDao<time>{
	
	@Autowired
	GenericDao gDao;
	
	@Override
	public List<time> listarTimes() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<time> times = new ArrayList<time>();
		
		String sql = "SELECT CodigoTime, NomeTime, Cidade, Estadio, MaterialEsportivo FROM times";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			time t = new time();
			t.setCod(rs.getInt("CodigoTime"));
			t.setNome(rs.getString("NomeTime"));
			t.setCidade(rs.getString("Cidade"));
			t.setEstadio(rs.getString("Estadio"));
			t.setMaterial(rs.getString("MaterialEsportivo"));
			
			times.add(t);
		}
		rs.close();
		ps.close();
		c.close();
		return times;
	}

}