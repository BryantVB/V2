package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.Paulistao_Spring.model.jogos;

public interface IDataJogoDao {

	public List<jogos> listarjogos(String data)  throws SQLException, ClassNotFoundException;
}
