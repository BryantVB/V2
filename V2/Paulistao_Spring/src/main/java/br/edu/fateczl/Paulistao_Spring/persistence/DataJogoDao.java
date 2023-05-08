package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.Paulistao_Spring.model.jogos;

@Repository
public class DataJogoDao implements IDataJogoDao {

	@Autowired
	GenericDao gDao;

	@Override
	public List<jogos> listarjogos(String data) throws SQLException, ClassNotFoundException {
		List<jogos> jogos = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT DISTINCT ta.NomeTime As nomeTimeA, tb.NomeTime As nomeTimeB, j.DataJ\r\n"
				+ "		FROM jogos j, times ta, times tb\r\n"
				+ "		WHERE j.CodTimeA = ta.CodigoTime\r\n"
				+ "		AND j.CodTimeB = tb.CodigoTime\r\n"
				+ "		AND j.DataJ = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, data);
		System.out.println(data);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			jogos j = new jogos();
			j.setTimeA(rs.getString("nomeTimeA"));
			j.setTimeB(rs.getString("nomeTimeB"));
			j.setDta(rs.getString("DataJ"));
			jogos.add(j);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
}
