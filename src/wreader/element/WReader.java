package wreader.element;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.print.PrintException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RuleContext;
import org.antlr.v4.runtime.tree.ParseTree;

import wreader.grammar.WRLexer;
import wreader.grammar.WRParser;




public class WReader {
	

		public static void main(String[] args) throws IOException {

			String fp=".\\ex\\ex1.wr";
			ANTLRInputStream input = new ANTLRFileStream(fp);
			WRLexer lexer = new WRLexer(input);
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			WRParser parser = new WRParser(tokens);
			parser.setBuildParseTree(true);
			RuleContext tree = parser.module();
			parser.module();
			//tree.inspect(parser); // show in gui
			try {
				tree.save(parser, ".\\R.ps");
			} catch (PrintException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // Generate postscript
			System.out.println(tree.toStringTree(parser));
			
			

		}

}
	
