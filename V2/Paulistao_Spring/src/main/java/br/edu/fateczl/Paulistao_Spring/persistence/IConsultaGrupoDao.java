package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.Paulistao_Spring.model.JogoInfo;

public interface IConsultaGrupoDao {
	
	public List<JogoInfo> listainfo(String grupo)  throws SQLException, ClassNotFoundException;
	
}
