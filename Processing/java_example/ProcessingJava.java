import processing.core.*;


public class ProcessingJava extends PApplet{

	public ProcessingJava(){

	}

	public void setup(){

	}

	public void draw(){

	}

	 public void settings() {  
		size(1000, 1000); 
	}

  	static public void main(String[] passedArgs) {
		String[] appletArgs = new String[] { "ProcessingJava" };
	    if (passedArgs != null) {
	      PApplet.main(concat(appletArgs, passedArgs));
	    } else {
	      PApplet.main(appletArgs);
	    }
	}
}