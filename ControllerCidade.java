import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class ControllerCidade {
    
    public static void cadastrarCidade(Cidade cidade) throws SQLException{
        String nome;
        String pais;
        Connection connection;
        connection  = new ConnectionFactory().getConnection();

        String sql = "INSERT INTO cidade (nome, pais) VALUES(?,?)";
        PreparedStatement pst = connection.prepareStatement(sql);
        nome = cidade.getNome();
        pais = cidade.getPais();
        pst.setString(1,nome);
        pst.setString(2,pais);
        pst.execute();

        System.out.println("Todos os dados foram inseridos!");
        connection.close();
    }

    public static Cidade pesquisarCidade(int id)  throws SQLException{
        String sql = "SELECT * FROM cidade WHERE id_cidade = ?";

        Connection conexao = new ConnectionFactory().getConnection();
        PreparedStatement pst = conexao.prepareStatement(sql);

        pst.setInt(1, id);
        ResultSet resultSet = pst.executeQuery();

        if(resultSet.next()){
            String nome = resultSet.getString("nome");
            String pais = resultSet.getString("pais");
            Cidade resultadoCidade = new Cidade();
            resultadoCidade.setNome(nome);
            resultadoCidade.setPais(pais);
            resultadoCidade.setId_cidade(id);
            return resultadoCidade;
        } else{
            System.out.println("Cidade nao encontrada");
        }
        conexao.close();
        return null;
    }

    public static void excluirCidade(Cidade cidade) throws SQLException{
        String sql = "DELETE FROM cidade WHERE id_cidade = ?";

        Connection conexao = new ConnectionFactory().getConnection();
        PreparedStatement pst = conexao.prepareStatement(sql);

        pst.setInt(1, cidade.getId_cidade());
        int linhasAfetadas = pst.executeUpdate();

        if(linhasAfetadas > 0){
            System.out.println("Cidade deletada!");
        } else{
            System.out.println("Cidade nao encontrada");
        }
        conexao.close();
    }
}
