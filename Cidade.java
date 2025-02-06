public class Cidade {
    private int id_cidade;
    private String nome;
    private String pais;

    public int getId_cidade() {
        return id_cidade;
    }
    public void setId_cidade(int id_cidade) {
        this.id_cidade = id_cidade;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getPais() {
        return pais;
    }
    public void setPais(String pais) {
        this.pais = pais;
    }

    public String toString(){
        String msg = "Cidade = " + getNome() + "\nPais = " + getPais();
        return msg;
    }
}
