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

import br.edu.fateczl.Paulistao_Spring.model.jogos;

@Component
public class JogoDao implements IJogoDao{

	@Autowired
	GenericDao gDao;

	@Override
	public void criarJogo() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String proc_sql = "{CALL criarJogos}";
		
		try {
			CallableStatement cs = c.prepareCall(proc_sql);
			cs.execute();
			cs.close();
			} catch(Exception e) {
			}
			c.close();
	}

	@Override
	public List<jogos> listarJogo() throws SQLException, ClassNotFoundException {
		
		List<jogos> jogos = new ArrayList<jogos>();
		Connection c = gDao.getConnection();
		String sql = "	SELECT ta.NomeTime As nome_Time_A, tb.NomeTime As nome_Time_B, j.DataJ\r\n"
				+ "		FROM jogos j, times ta, times tb\r\n"
				+ "		WHERE j.CodTimeA = ta.CodigoTime\r\n"
				+ "		AND j.CodTimeB = tb.CodigoTime;";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			jogos j = new jogos();
			j.setTimeA(rs.getString("nome_Time_A"));
			j.setTimeB(rs.getString("nome_Time_B"));
			j.setDta(rs.getString("DataJ"));
			jogos.add(j);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
	
	
}
