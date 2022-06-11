
/**
 * Write a description of class ResultValue here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class ResultValue
{
    private TypeEnum type;
    private double dval;
    private boolean bval;
    
    public ResultValue(double val){
        type = TypeEnum.DOUBLE;
        dval = val;
    }

     public ResultValue(boolean val){
        type = TypeEnum.BOOLEAN;
        bval = val;
    }
    
    public double getDouble() {
        return dval;
    }
    
    public boolean getBool() {
        return bval;
    }

    public String toString() {
        switch (type) {
            case DOUBLE:
                return Double.toString(dval);
            case BOOLEAN:
                return Boolean.toString(bval);
            }
            
         return "erro! tipo nao tratado em ResultValue";
        }       
}
