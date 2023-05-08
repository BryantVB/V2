package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.Paulistao_Spring.model.grupos;

public interface IFazGrupoDao {
	
	public void Fazergrupos()  throws SQLException, ClassNotFoundException;
	public List<grupos> listargrupos()  throws SQLException, ClassNotFoundException;
}
