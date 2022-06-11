
/**
 * Write a description of class Nodo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class NodoTBool implements INodo
{
    private boolean bval;
    

    public NodoTBool(boolean valor) {
        bval = valor;
    }
    
    public ResultValue avalia() {
        return new ResultValue(bval);              
    }
    
    public String toString() {
            return Boolean.toString(bval);
        }       
 }
    