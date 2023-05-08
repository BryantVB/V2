package br.edu.fateczl.Paulistao_Spring.model;

public class grupos {
	String times;
	String grupos;
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getGrupos() {
		return grupos;
	}
	public void setGrupos(String grupos) {
		this.grupos = grupos;
	}
	@Override
	public String toString() {
		return "grupos [times=" + times + ", grupos=" + grupos + "]";
	}
}

