
/**
 * Write a description of class Nodo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class NodoTDouble implements INodo
{
    private double dval;
    

    public NodoTDouble(double valor) {
        dval = valor;
    }
    
    public ResultValue avalia() {
        return new ResultValue(dval);              
    }
    
    public String toString() {
            return Double.toString(dval);
        }       
 }
    