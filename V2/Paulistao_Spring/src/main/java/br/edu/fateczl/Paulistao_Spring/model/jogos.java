package br.edu.fateczl.Paulistao_Spring.model;


public class jogos {
	String TimeA;
	String TimeB;
	int golsA;
	int golsB;
	String dta;
	public String getTimeA() {
		return TimeA;
	}
	public void setTimeA(String timeA) {
		TimeA = timeA;
	}
	public String getTimeB() {
		return TimeB;
	}
	public void setTimeB(String timeB) {
		TimeB = timeB;
	}
	public String getDta() {
		return dta;
	}
	public void setDta(String dta) {
		this.dta = dta;
	}
	public int getGolsA() {
		return golsA;
	}
	public void setGolsA(int golsA) {
		this.golsA = golsA;
	}
	public int getGolsB() {
		return golsB;
	}
	public void setGolsB(int golsB) {
		this.golsB = golsB;
	}
	@Override
	public String toString() {
		return "jogos [TimeA=" + TimeA + ", TimeB=" + TimeB + ", golsA=" + golsA + ", golsB=" + golsB + ", dta=" + dta
				+ "]";
	}
}