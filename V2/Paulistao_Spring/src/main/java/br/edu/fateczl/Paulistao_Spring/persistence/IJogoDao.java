package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.Paulistao_Spring.model.jogos;

public interface IJogoDao {

	public void criarJogo() 			throws SQLException, ClassNotFoundException;;
	public List<jogos> listarJogo()  	throws SQLException, ClassNotFoundException;
	
}
