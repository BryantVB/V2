package br.edu.fateczl.Paulistao_Spring.model;
public class time {
	int cod;
	String nome;
	String cidade;
	String estadio;
	String material;
	public int getCod() {
		return cod;
	}
	public void setCod(int cod) {
		this.cod = cod;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getEstadio() {
		return estadio;
	}
	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
	@Override
	public String toString() {
		return "time [cod=" + cod + ", nome=" + nome + ", cidade=" + cidade + ", estadio=" + estadio + ", material="
				+ material + "]";
	}
	
	
}