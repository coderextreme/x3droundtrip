import org.w3c.dom.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import java.io.*;
import org.xmlunit.builder.Input;
import org.xmlunit.validation.ValidationProblem;
import org.xmlunit.validation.ValidationResult;
import org.xmlunit.validation.Validator;
import org.xmlunit.validation.Languages;
import org.xmlunit.diff.DifferenceEngine;
import org.xmlunit.diff.DOMDifferenceEngine;
import org.xmlunit.diff.ComparisonListener;
import org.xmlunit.diff.Comparison;
import org.xmlunit.diff.ComparisonResult;
import org.xmlunit.matchers.ValidationMatcher;

public class Compare {
    public static void main(String args[]) throws Exception {
	Source control = Input.fromFile(args[0]).build();
	Source test = Input.fromFile(args[1]).build();
	DifferenceEngine diff = new DOMDifferenceEngine();
	diff.addDifferenceListener(new ComparisonListener() {
		public void comparisonPerformed(Comparison comparison, ComparisonResult outcome) {
		    System.out.println("\n difference: " + comparison);
		    System.out.println(  " outcome:    "+ outcome);
		    System.out.println(  " file left:  "+ args[0]);
		    System.out.println(  " file right: "+ args[1]);
		}
        });
	diff.compare(control, test);
    }
}
