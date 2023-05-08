package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GolsDao implements IGolsDao{
	
	@Autowired
	GenericDao gDao;
	
	@Override
	public String alterarGols(String timeA, String timeB, int golsA, int golsB, String dataJogo)
			throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		
		System.out.println(timeA+timeB+golsA+golsB+dataJogo);
		
		String sql_proc = "{CALL p_alterarGols (?,?,?,?,?)}";
		
		CallableStatement cs = c.prepareCall(sql_proc);
		cs.setString(1, timeA);
		cs.setString(2, timeB);
		cs.setInt(3, golsA);
		cs.setInt(4, golsB);
		cs.setString(5, dataJogo);
		cs.execute();
		cs.close();
		c.close();
		return "Jogo atualizado com sucesso";
	}
	
}
