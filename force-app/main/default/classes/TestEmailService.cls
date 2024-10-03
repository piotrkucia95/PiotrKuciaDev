public class TestEmailService implements Messaging.InboundEmailHandler {

    DateTime t1;
transient DateTime t2; //declare
 
public String getT1() {
if (t1 == null)
 t1 = System.now();
 
return '' + t1;
}
 
public String getT2() {
if (t2 == null)
 t2 = System.now();
 
return '' + t2;
}
    
    public void refreshT1() {
        t1 = System.now();
    }
    
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        return null;
    }
}