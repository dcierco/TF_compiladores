import java.util.List;
import java.util.ArrayList;

/**
 * ListaFuncao
 */
public class ListaFuncao {
    static List<Funcao> lista;

    public ListaFuncao(){
        lista = new ArrayList<Funcao>();
    }
    
    public static void addFuncao(Funcao func){
        lista.add(func);
    }

    public static Funcao busca(String nome){
        for (Funcao funcao : lista) {
            if(funcao.getNome() == nome){
                return funcao;
            }
        }

        return null;
    }

    @Override
    public String toString() {
        String resp = "";
        for (Funcao f : lista) {
            resp += f.toString() + "/n/n";
        }
        return resp;
    }
}