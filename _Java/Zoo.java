abstract class Mammal {
	public String toString( ){
		return "Mammal type";
	}

	abstract void eat();

	// concrete method
	void breath(){
	}
	
}

abstract class Insect {
	public String toString( ){
		return "Insect type";
	}

	abstract void eat();
}

interface Motile {
	// all methods are abstract by default
	// not allowed to include concrete methods

	 public float getDistTraveled();
	// void setSpeed();
	// void setOrigin(String origin);
	// void setDestination(String destination);
}

interface Flyable extends Motile {
	void fly();

	// void fly();
	// void land();
}

interface Predatory {
	// void Hunt();
	// void Attack();
}


class Dog extends Mammal {
	void eat(){
		// feed the dog appropriately
		System.out.println("I'm eating a bone");

	}
}

class Lemur extends Mammal implements Flyable {
	public void fly() {
		System.out.println("The Lemur is soaring!!");
	}

	public void eat(){
		// feed the lemur appropriately
		System.out.println("I'm eating fruit");
	}

	public String toString( ){
		return "Lemur type";
	}

	public float getDistTraveled() {
		// create real implementation eventually
		return 1.0f;
	}
}

class Dragonfly extends Insect implements Flyable, Predatory{
	public void fly() {
		System.out.println("The Drongfly is hovering!!");
	}

	public String toString( ){
		return "Dragonfly type";
	}

	public float getDistTraveled() {
		// create real implementation eventually
		return 1.0f;
	}

	public void eat(){
		// feed the dragonfly appropriately
		System.out.println("I'm eating fruit");
	}
}


public class Zoo {
 Flyable[] creatures;

 public Zoo() {
 	System.out.println("in Zoo default CSTR");
 }

 public Zoo(Flyable[] creatures){
 	this.creatures = creatures;
 	System.out.println("in Zoo overloaded CSTR");
 	for(Flyable f: creatures) {
 		f.fly();
 	}
 }

 public static void main(String[] args){
 	Flyable[] creatures = {
 		new Lemur(),
 		new Dragonfly()
 	};
 	
 	new Zoo(creatures);

 	Zoo z = new Zoo();
 }
	
}