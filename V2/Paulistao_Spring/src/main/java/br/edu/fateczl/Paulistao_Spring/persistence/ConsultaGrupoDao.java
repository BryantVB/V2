package br.edu.fateczl.Paulistao_Spring.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.Paulistao_Spring.model.JogoInfo;

@Component
public class ConsultaGrupoDao implements IConsultaGrupoDao{

	@Autowired
	GenericDao gDao;
	
	@Autowired
	GruposDao grDao;

	@Override
	public List<JogoInfo> listainfo(String grupo) throws SQLException, ClassNotFoundException {
		List<JogoInfo> jogoinf = new ArrayList<>();
		Connection c = gDao.getConnection();
		List<String> timeG = new ArrayList<>();
		
		String sqla = "select t.NomeTime from times t INNER JOIN grupos g ON g.CodTime = t.CodigoTime\r\n"
				+ "				WHERE g.Grupo = ?";
		
		PreparedStatement ps = c.prepareStatement(sqla);
		ps.setString(1, grupo);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			timeG.add(rs.getString("NomeTime"));
		}
		System.out.println(timeG.get(0));
		
		for (String gr : timeG) {
			System.out.println("-------Valor: "+gr);
			String sql = "SELECT * FROM dbo.f_jogoinfo (?)";
			PreparedStatement psa = c.prepareStatement(sql);
			psa.setString(1, gr);
			ResultSet rsa = psa.executeQuery();
			System.out.println("******-Valor: 1");
			if(rsa.next()) {
				System.out.println("******-Valor: 2");
				JogoInfo ji = new JogoInfo();
				ji.setTime(rsa.getString("nome"));
				ji.setNumJogos(rsa.getInt("numJogo"));
				ji.setVitorias(rsa.getInt("vit"));
				ji.setDerrotas(rsa.getInt("derr"));
				ji.setEmpates(rsa.getInt("emp"));
				ji.setGols_Marcados(rsa.getInt("marcados"));
				ji.setGols_Sofridos(rsa.getInt("sofridos"));
				ji.setSaldo_Gols(rsa.getInt("saldo"));
			jogoinf.add(ji);
			
			System.out.println(ji.toString());
			}
		}
		
		return jogoinf;
	}
}
