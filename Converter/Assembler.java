import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Scanner;

public class Assembler {
	public static void main(String args[]) throws IOException {
		File f;
		String path;
		Scanner scnr1 = new Scanner(System.in);
		while(true) {
			System.out.print("Text file path: ");
			path = scnr1.nextLine();
			if(path.endsWith(".txt")) {
				f = new File(path);
				if(f.isFile()) {
					break;
				}
			}
			System.out.println("Unsupported File Format. Provide Text file.");
		}
		String storepath = path.substring(0, path.lastIndexOf(f.separator) + 1);
		File imem = new File(storepath + "IMEM_PRGM.v");
		File dmem = new File(storepath + "DMEM_PRGM.v");
		imem.createNewFile();
		dmem.createNewFile();
		Scanner scnr2 = null;
		Scanner scnr3 = null;
		Scanner scnr = null;
		PrintWriter pi = null;
		PrintWriter pd = null;
		try {
			int i = 0;
			scnr = new Scanner(f);
			scnr3 = new Scanner(f);
			pi = new PrintWriter(imem);
			pi.println("module IMEM_PRGM(A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P);\r\n"
					+ "\toutput [15:0] A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P;");
			pi.println("\tassign A = 16'b0000000000000000;");
			String line = scnr.nextLine();
			String line1 = scnr3.nextLine();
			char[] letter = {'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P'};
			HashMap<String, String> labels = new HashMap<String, String>();
			HashMap<String, String> labels1 = new HashMap<String, String>();
			String y = null;
			while(!line1.equals("") && line1 != null) {
				scnr2 = new Scanner(line1);
				String a = scnr2.next();
				if(a.endsWith(":") && !a.startsWith("//")) {
					labels.put(a.substring(0, a.length() - 1), IntToBin(i));
				}
				i++;
				line1 = scnr3.nextLine();
			}
			i = 0;
			line1 = scnr3.nextLine();
			while(line1 != null) {
				scnr2 = new Scanner(line1);
				String a = scnr2.next();
				if(a.endsWith(":")) {
					labels1.put(a.substring(0, a.length() - 1), IntToBin(i));
				}
				i++;
				try {
					line1 = scnr3.nextLine();
				} catch(java.util.NoSuchElementException d) {
					line1 = null;
				}
			}
			i = 0;
			while(!line.equals("") && line != null && i < 15) {
				while(line != null && line.startsWith("//")) {
					line = scnr.nextLine();
				}
				if(line == null) {
					break;
				}
				scnr2 = new Scanner(line);
				String a = scnr2.next();
				String b, c, d, e;
				switch(a) {
				case "NOOP": 
					if(!scnr2.hasNext()) {
						b = "0000";
						c = "11";
						d = "00";
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "IN":
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0001";
						c = "11";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "OUT":
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0010";
						c = "11";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "END":
					if(!scnr2.hasNext()) {
						b = "0001";
						c = "00";
						d = "00";
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "LDM":
				case "LDD":
					y = a;
					a = scnr2.next();
					b = "0000";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("LDM")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("LDD")) {
						c = "01";
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "LDX":
					a = scnr2.next();
					b = "0000";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "STO":
					a = scnr2.next();
					b = "0001";
					c = "01";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "STX":
					a = scnr2.next();
					b = "0001";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "ADDM":
				case "ADDD":
					y = a;
					a = scnr2.next();
					b = "0010";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("ADDM")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("ADDD")) {
						c = "01";
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "ADDX":
					a = scnr2.next();
					b = "0010";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "SUBM":
				case "SUBD":
					y = a;
					a = scnr2.next();
					b = "0011";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("SUBM")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("SUBD")) {
						c = "01";
						e = GetEa(a, labels1);;
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "SUBX":
					a = scnr2.next();
					b = "0011";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "INC":
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0110";
						c = "00";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "DEC":
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0110";
						c = "01";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "LSL":
					a = scnr2.next();
					b = "0110";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
					break;
				case "LSR":
					a = scnr2.next();
					b = "0110";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
					break;
				case "ADDR":
					a = scnr2.next();
					b = "0100";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
					break;
				case "SUBR":
					a = scnr2.next();
					b = "0101";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
					break;
				case "CMP":
				case "CMD":
					y = a;
					a = scnr2.next();
					b = "1000";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("CMP")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("CMD")) {
						c = "01";
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "CMX":
					a = scnr2.next();
					b = "1000";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "JMP":
					b = "1000";
					c = "11";
					d = "00";
					e = GetEa(scnr2.next(), labels1);
					break;
				case "JPN":
					b = "1001";
					c = "00";
					d = "00";
					e = GetEa(scnr2.next(), labels1);
					break;
				case "JPE":
					b = "1001";
					c = "01";
					d = "00";
					e = GetEa(scnr2.next(), labels1);
				case "JGT":
					b = "1001";
					c = "10";
					d = "00";
					e = GetEa(scnr2.next(), labels1);
				case "JGE":
					b = "1001";
					c = "11";
					d = "00";
					e = GetEa(scnr2.next(), labels1);
					break;
				case "ANDM":
				case "ANDD":
					y = a;
					a = scnr2.next();
					b = "1010";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("ANDM")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("ANDD")) {
						c = "01";
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "ANDX":
					a = scnr2.next();
					b = "1010";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "ORM":
				case "ORD":
					y = a;
					a = scnr2.next();
					b = "1100";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("ORM")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("ORD")) {
						c = "01";
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "ORX":
					a = scnr2.next();
					b = "1100";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "XORM":
				case "XORD":
					y = a;
					a = scnr2.next();
					b = "1110";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					a = scnr2.next();
					if(a.startsWith("#") && y.equals("XORM")) {
						c = "00";
						e = GetE(a);
					} else if (y.equals("XORD")) {
						c = "01";
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "XORX":
					a = scnr2.next();
					b = "1110";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
					break;
				case "NOT":
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "1010";
						c = "11";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
					break;
				case "ASR":
					a = scnr2.next();
					b = "0011";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
					break;
				case "CSL":
					a = scnr2.next();
					b = "1100";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
					break;
				case "CSR":
					a = scnr2.next();
					b = "1110";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
					break;
				case "ANDR":
					a = scnr2.next();
					b = "1011";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
					break;
				case "ORR":
					a = scnr2.next();
					b = "1101";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
					break;
				case "XORR":
					a = scnr2.next();
					b = "1111";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
					break;
				default: throw new Exception("Command " + a + " not supported");
				}
				for(int j = 0; j < 8; j++) {
					if(e.charAt(j) == '0' || e.charAt(j) == '1') {
						continue;
					} else {
						throw new Exception("Illegal Format");
					}
				}
				pi.println("\tassign " + letter[i] + " = 16'b" + b + c + d + e + ";");
				line = scnr.nextLine();
				i += 1;
			}
			if(i > 15) {
				throw new Exception("Too many instruction lines");
			} else if(i < 15) {
				for(; i < 15; i++) {
					pi.println("\tassign " + letter[i] + " = 16'b0000000000000000;");
				}
			}
			if(line == null) {
				throw new Exception("Illegal Format");
			}
			pi.println("endmodule");
			i = 0;
			line = scnr.nextLine();
			pd = new PrintWriter(dmem);
			pd.println("module DMEM_PRGM(D0, D1, D2, D3, D4, D5, D6, D7);\r\n"
					+ "\toutput [7:0] D0, D1, D2, D3, D4, D5, D6, D7;");
			while(line != null && i < 8) {
				while(line != null && line.startsWith("//")) {
					line = scnr.nextLine();
				}
				if(line == null) {
					break;
				}
				scnr2 = new Scanner(line);
				String a = scnr2.next();
				if(labels1.containsKey(a.substring(0, a.length() - 1))) {
					a = scnr2.next();
				} else if (a.endsWith(":")) {
					throw new Exception("Illegal Format");
				}
				pd.println("\tassign D" + i + " = 8'b" + GetE(a) + ";");
				try {
					line = scnr.nextLine();
				} catch(java.util.NoSuchElementException d) {
					line = null;
				}
				i++;
			}
			if(i == 8) {
				throw new Exception("Too many data lines");
			}else if(i < 8 && line == null) {
				for(; i < 8; i++) {
					pd.println("\tassign D" + i + " = 8'b00000000;");
				}
			} else {
				throw new Exception("Illegal Format");
			}
			pd.println("endmodule");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pi.flush();
			pi.close();
			pd.flush();
			pd.close();
			scnr.close();
			scnr1.close();
			scnr2.close();
			scnr3.close();
		}
	}
	
	public static String IntToBin(int a) {
		String x;
		if(a >= 0) {
			x = String.format("%8s", Integer.toBinaryString(a)).replace(' ', '0');
		} else {
			x = Integer.toBinaryString(a).substring(24);
		}
		return x;
	}
	
	public static String HexToBin(String a) throws Exception {
		String x = "";
		for(int i = 0; i < 2; i++) {
			switch(a.charAt(i)) {
			case '0': x += "0000"; break;
			case '1': x += "0001"; break;
			case '2': x += "0010"; break;
			case '3': x += "0011"; break;
			case '4': x += "0100"; break;
			case '5': x += "0101"; break;
			case '6': x += "0110"; break;
			case '7': x += "0111"; break;
			case '8': x += "1000"; break;
			case '9': x += "1001"; break;
			case 'A': x += "1010"; break;
			case 'B': x += "1011"; break;
			case 'C': x += "1100"; break;
			case 'D': x += "1101"; break;
			case 'E': x += "1110"; break;
			case 'F': x += "1111"; break;
			default: throw new Exception("Illegal Format");
			}
		}
		return x;
	}
	
	public static String GetD(String a) throws Exception {
		if(a.equals("A")){
			return "00";
		} else if(a.equals("B")){
			return "01";
		} else if(a.equals("C")){
			return "10";
		} else if(a.equals("IX")){
			return "11";
		} else {
			throw new Exception("Illegal Format");
		}
	}
	
	public static String GetE(String a) throws Exception {
		if (a.startsWith("#")) {
			switch(a.substring(0, 2)) {
			case "#B": 
				if(a.length() != 10) {
					throw new Exception("Illegal Format");
				}
				return a.substring(2);
			case "#&":
				if(a.length() != 4) {
					throw new Exception("Illegal Format");
				}
				return HexToBin(a.substring(2));
			case "#0":
			case "#1":
			case "#2":
			case "#3":
			case "#4":
			case "#5":
			case "#6":
			case "#7":
			case "#8":
			case "#9":
				if(a.length() > 4 || Integer.parseInt(a.substring(1)) > 127 || Integer.parseInt(a.substring(1)) < -128) {
					throw new Exception("Illegal Format");
				}
				return IntToBin(Integer.parseInt(a.substring(1)));
			default: throw new Exception("Illegal Format");
			}
		} else {
			throw new Exception("Illegal Format");
		}
	}
	
	public static String GetEa(String a, HashMap<String, String> labels1) throws Exception {
		String e;
		try {
			e = String.format("%d", Integer.valueOf(a));
		} catch(NumberFormatException x) {
			e = labels1.get(a);
			if(e == null) {
				throw new Exception("Illegal Format");
			}
		}
		return e;
	}
}
