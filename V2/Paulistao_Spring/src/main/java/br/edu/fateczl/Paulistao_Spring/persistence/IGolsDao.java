package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.SQLException;

public interface IGolsDao {

	public String alterarGols(String nome_timeA, String nome_timeB, int gols_timeA, int gols_timeB, String data_jogo)throws SQLException, ClassNotFoundException;
	
}
