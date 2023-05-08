package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.Paulistao_Spring.model.grupos;

public interface IGruposDao {
	
	public List<grupos> listargrupoA()  throws SQLException, ClassNotFoundException;
	public List<grupos> listargrupoB()  throws SQLException, ClassNotFoundException;
	public List<grupos> listargrupoC()  throws SQLException, ClassNotFoundException;
	public List<grupos> listargrupoD()  throws SQLException, ClassNotFoundException;
}