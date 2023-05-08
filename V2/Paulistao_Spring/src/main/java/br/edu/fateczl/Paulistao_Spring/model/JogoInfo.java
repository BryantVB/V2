package br.edu.fateczl.Paulistao_Spring.model;

public class JogoInfo {
	public String time;
	public int numJogos;
	public int vitorias;
	public int empates;
	public int derrotas;
	public int gols_Marcados;
	public int gols_Sofridos;
	public int saldo_Gols;
	public int pontos;
	
	
	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}


	public int getNumJogos() {
		return numJogos;
	}


	public void setNumJogos(int numJogos) {
		this.numJogos = numJogos;
	}


	public int getVitorias() {
		return vitorias;
	}


	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}


	public int getEmpates() {
		return empates;
	}


	public void setEmpates(int empates) {
		this.empates = empates;
	}


	public int getDerrotas() {
		return derrotas;
	}


	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}


	public int getGols_Marcados() {
		return gols_Marcados;
	}


	public void setGols_Marcados(int gols_Marcados) {
		this.gols_Marcados = gols_Marcados;
	}


	public int getGols_Sofridos() {
		return gols_Sofridos;
	}


	public void setGols_Sofridos(int gols_Sofridos) {
		this.gols_Sofridos = gols_Sofridos;
	}


	public int getSaldo_Gols() {
		return saldo_Gols;
	}


	public void setSaldo_Gols(int saldo_Gols) {
		this.saldo_Gols = saldo_Gols;
	}


	public int getPontos() {
		return pontos;
	}


	public void setPontos(int pontos) {
		this.pontos = pontos;
	}


	@Override
	public String toString() {
		return "JogoInfo [time=" + time + ", numJogos=" + numJogos + ", vitorias=" + vitorias + ", empates=" + empates
				+ ", derrotas=" + derrotas + ", gols_Marcados=" + gols_Marcados + ", gols_Sofridos=" + gols_Sofridos
				+ ", saldo_Gols=" + saldo_Gols + ", pontos=" + pontos + "]";
	}


	
}
