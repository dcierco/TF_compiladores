import java.util.List;
import java.util.ArrayList;

/**
 * Funcao
 */
public class Funcao {
    String nome;
    List<String> params;
    INodo cmd;
    int nParams;

    public Funcao(String nome){
        this.nome = nome;
        params = new ArrayList<String>();
        this.cmd = null;
        nParams = 0;
    }

    public void addParam(String param){
        this.params.add(nome + "." + param);
        this.nParams++;
    }

    public void addCMD(INodo cmd){
        this.cmd = cmd;
    }

    public String getNome(){
        return this.nome;
    }

    public ResultValue executaFuncao(List<INodo> params){
        if(params.size() != nParams){
            return new ResultValue(-1);
        }
        for (int i = 0; i < nParams; i++) {
            new NodoNT(TipoOperacao.ATRIB, this.params.get(i), params.get(i));
        }
        return cmd.avalia();
    }

    @Override
    public String toString() {
        String resp = "Função: " + this.nome + "parâmetros: (";
        for (String parametro : params) {
            resp += parametro.toString() + ", ";
        }
        return resp.substring(0, resp.length()-2) + ")\n";
    }
}