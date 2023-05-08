package br.edu.fateczl.Paulistao_Spring.model;

public class grupo {

	String grupo;
	int codTime;
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public int getCodTime() {
		return codTime;
	}
	public void setCodTime(int codTime) {
		this.codTime = codTime;
	}
	@Override
	public String toString() {
		return "grupo [grupo=" + grupo + ", codTime=" + codTime + "]";
	}
}
