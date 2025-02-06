import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

public class TesteConexao {

    public static void main(String[] args) throws SQLException {
    
        Connection conexao = new ConnectionFactory().getConnection();
        System.out.println("Conexão aberta!");

        Scanner sc = new Scanner(System.in);

        System.out.println("Bem vindo ao banco de dados, o que gostaria de fazer?");
        System.out.println("1 - inserir uma nova cidade no banco de dados");
        System.out.println("2 - pesquisar uma cidade no banco de dados");
        System.out.println("3 - excluir uma cidade do banco de dados");
        System.out.println("0 - sair do banco de dados");

        int resposta = sc.nextInt();

        do
        {
            switch(resposta){
                case 1:
                    Cidade cidade = inserirCidade();
                    ControllerCidade.cadastrarCidade(cidade);
                    System.out.println("A cidade foi cadastrada com sucesso");
                    break;
    
                case 2:
                    System.out.println("Digite o id da cidade que deseja procurar");
                    int x = sc.nextInt();
                    System.out.println(ControllerCidade.pesquisarCidade(x));
                    break;
    
                case 3:
                    System.out.println("digite o id da cidade que voce quer excluir");
                    int id = sc.nextInt();
                    ControllerCidade.excluirCidade(ControllerCidade.pesquisarCidade(id));
                    break;
    
                case 0:
                    break;
    
                default:
                    System.out.println("Opcao nao disponivel, tente novamente");
                    break;
            }

            System.out.println("1 - inserir uma nova cidade no banco de dados");
            System.out.println("2 - pesquisar uma cidade no banco de dados");
            System.out.println("3 - excluir uma cidade do banco de dados");
            System.out.println("0 - sair do banco de dados");

            resposta = sc.nextInt();
    
        }while (resposta != 0);

        sc.close();
        conexao.close();
    }    

    public static Cidade inserirCidade(){
        Scanner sc = new Scanner(System.in);
        Cidade cidade = new Cidade();

        System.out.println("Digite o nome da cidade:");
        cidade.setNome(sc.nextLine());
        System.out.println("Digite o pais da cidade");
        cidade.setPais(sc.nextLine());

        return cidade;
    }
}