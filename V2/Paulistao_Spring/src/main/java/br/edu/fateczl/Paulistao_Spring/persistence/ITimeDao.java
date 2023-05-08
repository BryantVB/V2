package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;
import java.util.List;

public interface ITimeDao<time> {
	
	public List<time> listarTimes()  throws SQLException, ClassNotFoundException;
}
