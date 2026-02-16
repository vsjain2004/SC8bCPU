import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Scanner;

public class Assembler {
	public static void main(String[] args) throws IOException {
		File f;
		String path;
		Scanner scnr1 = new Scanner(System.in);
		while(true) {
			System.out.print("Text file path: ");
			path = scnr1.nextLine();
			if(path.endsWith(".asm")) {
				f = new File(path);
				if(f.isFile()) {
					break;
				}
			}
			System.out.println("Unsupported File Format. Provide Text file.");
		}
		String storepath = path.substring(0, path.lastIndexOf('.'));
		File imem = new File(storepath + "_IMEM.hex");
		File dmem = new File(storepath + "_DMEM.hex");
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
			String line = scnr.nextLine();
			String line1 = scnr3.nextLine();
			HashMap<String, String> labels = new HashMap<>();
			HashMap<String, String> labels1 = new HashMap<>();
			String y;
			while(line1 != null && !line1.equals("")) {
				scnr2 = new Scanner(line1);
				String a = scnr2.next();
				if(a.endsWith(":") && !a.startsWith("//")) {
					labels.put(a.substring(0, a.length() - 1), IntToBin(i));
				}
				if(!a.startsWith("//")){
					i++;
				}
				try {
					line1 = scnr3.nextLine();
				} catch(java.util.NoSuchElementException d) {
					line1 = null;
				}
			}
			i = 0;
			try {
				line1 = scnr3.nextLine();
			} catch(java.util.NoSuchElementException d) {
				line1 = null;
			}
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
			while(line != null && !line.equals("") && i < 16) {
				while(line != null && line.stripLeading().startsWith("//")) {
					line = scnr.nextLine();
				}
				if(line == null) {
					break;
				}
				scnr2 = new Scanner(line);
				String a = scnr2.next();
				String b, c, d, e;
				if(a.contains(":")){
					a = scnr2.next();
				}
				switch(a) {
				case "NOOP" -> {
					if(!scnr2.hasNext()) {
						b = "0000";
						c = "11";
						d = "00";
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "IN" -> {
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0001";
						c = "11";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "OUT" -> {
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0010";
						c = "11";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "END" -> {
					if(!scnr2.hasNext()) {
						b = "0001";
						c = "00";
						d = "00";
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "LDM", "LDD" -> {
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
				}
				case "LDX" -> {
					a = scnr2.next();
					b = "0000";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "STO" -> {
					a = scnr2.next();
					b = "0001";
					c = "01";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "STX" -> {
					a = scnr2.next();
					b = "0001";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "ADDM", "ADDD" -> {
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
				}
				case "ADDX" -> {
					a = scnr2.next();
					b = "0010";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "SUBM", "SUBD" -> {
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
						e = GetEa(a, labels1);
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "SUBX" -> {
					a = scnr2.next();
					b = "0011";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "INC" -> {
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0110";
						c = "00";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "DEC" -> {
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "0110";
						c = "01";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "LSL" -> {
					a = scnr2.next();
					b = "0110";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
				}
				case "LSR" -> {
					a = scnr2.next();
					b = "0110";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
				}
				case "ADDR" -> {
					a = scnr2.next();
					b = "0100";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
				}
				case "SUBR" -> {
					a = scnr2.next();
					b = "0101";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
				}
				case "CMP", "CMD" -> {
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
				}
				case "CMX" -> {
					a = scnr2.next();
					b = "1000";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "JMP" -> {
					b = "1000";
					c = "11";
					d = "00";
					e = GetEa(scnr2.next(), labels);
				}
				case "JPN" -> {
					b = "1001";
					c = "00";
					d = "00";
					e = GetEa(scnr2.next(), labels);
				}
				case "JPE" -> {
					b = "1001";
					c = "01";
					d = "00";
					e = GetEa(scnr2.next(), labels);
				}
				case "JGT" -> {
					b = "1001";
					c = "10";
					d = "00";
					e = GetEa(scnr2.next(), labels);
				}
				case "JGE" -> {
					b = "1001";
					c = "11";
					d = "00";
					e = GetEa(scnr2.next(), labels);
				}
				case "SWAPR" -> {
					a = scnr2.next();
					b = "0111";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
				}
				case "ANDM", "ANDD" -> {
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
				}
				case "ANDX" -> {
					a = scnr2.next();
					b = "1010";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "ORM", "ORD" -> {
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
				}
				case "ORX" -> {
					a = scnr2.next();
					b = "1100";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "XORM", "XORD" -> {
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
				}
				case "XORX" -> {
					a = scnr2.next();
					b = "1110";
					c = "10";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetEa(scnr2.next(), labels1);
				}
				case "NOT" -> {
					a = scnr2.next();
					if(!scnr2.hasNext()) {
						b = "1010";
						c = "11";
						d = GetD(a);
						e = "00000000";
					} else {
						throw new Exception("Illegal Format");
					}
				}
				case "ASR" -> {
					a = scnr2.next();
					b = "0011";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
				}
				case "CSL" -> {
					a = scnr2.next();
					b = "1100";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
				}
				case "CSR" -> {
					a = scnr2.next();
					b = "1110";
					c = "11";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					e = GetE(scnr2.next());
				}
				case "ANDR" -> {
					a = scnr2.next();
					b = "1011";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
				}
				case "ORR" -> {
					a = scnr2.next();
					b = "1101";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
				}
				case "XORR" -> {
					a = scnr2.next();
					b = "1111";
					if(a.endsWith(",")) {
						d = GetD(a.substring(0, a.length() - 1));
					} else {
						throw new Exception("Illegal Format");
					}
					c = GetD(scnr2.next());
					e = "00000000";
				}
				default -> throw new Exception("Command " + a + " not supported");
				}
				for(int j = 0; j < 8; j++) {
					if(e.charAt(j) == '0' || e.charAt(j) == '1') {
					} else {
						throw new Exception("Illegal Format");
					}
				}
				if(i < 15) {
					pi.println(String.format("%4s", Integer.toHexString((Integer.parseInt(b + c + d + e,2)))).replace(' ', '0'));
				} else {
					pi.print(String.format("%4s", Integer.toHexString((Integer.parseInt(b + c + d + e,2)))).replace(' ', '0'));
				}
				try {
					line = scnr.nextLine();
				} catch(java.util.NoSuchElementException g) {
					line = "";
				}
				i += 1;
			}
			if(i == 16 && !"".equals(line)) {
				throw new Exception("Too many instruction lines");
			} else if(i < 16) {
				for(; i < 15; i++) {
					pi.println("0000");
				}
				pi.print("0000");
			}
			if(line == null) {
				throw new Exception("Illegal Format");
			}
			i = 0;
			try {
				line = scnr.nextLine();
			} catch(java.util.NoSuchElementException g) {
				line = null;
			}
			pd = new PrintWriter(dmem);
			
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
				if(i < 7) {
					pd.println(String.format("%2s", Integer.toHexString((Integer.parseInt(GetE(a),2)))).replace(' ', '0'));
				} else {
					pd.print(String.format("%2s", Integer.toHexString((Integer.parseInt(GetE(a),2)))).replace(' ', '0'));
				}
				try {
					line = scnr.nextLine();
				} catch(java.util.NoSuchElementException d) {
					line = null;
				}
				i++;
			}
			if(i == 8 && line != null) {
				throw new Exception("Too many data lines");
			}else if(i < 8 && line == null) {
				for(; i < 7; i++) {
					pd.println("00");
				}
				pd.print("00");
			} else if(!(i == 8 && line == null)) {
				throw new Exception("Illegal Format");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("Hex Files generated.");
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
			case '0' -> x += "0000";
			case '1' -> x += "0001";
			case '2' -> x += "0010";
			case '3' -> x += "0011";
			case '4' -> x += "0100";
			case '5' -> x += "0101";
			case '6' -> x += "0110";
			case '7' -> x += "0111";
			case '8' -> x += "1000";
			case '9' -> x += "1001";
			case 'A' -> x += "1010";
			case 'B' -> x += "1011";
			case 'C' -> x += "1100";
			case 'D' -> x += "1101";
			case 'E' -> x += "1110";
			case 'F' -> x += "1111";
			default -> throw new Exception("Illegal Format");
			}
		}
		return x;
	}
	
	public static String GetD(String a) throws Exception {
		switch (a) {
			case "A" -> {
				return "00";
			}
			case "B" -> {
				return "01";
			}
			case "C" -> {
				return "10";
			}
			case "IX" -> {
				return "11";
			}
			default -> throw new Exception("Illegal Format");
		}
	}
	
	public static String GetE(String a) throws Exception {
		if (a.startsWith("#")) {
			switch(a.substring(0, 2)) {
			case "#B" -> {
				if(a.length() <= 10) {
					return String.format("%8s", a.substring(2)).replace(' ', '0');
				} else {
					throw new Exception("Illegal Format");
				}
			}
			case "#&" -> {
				if(a.length() <= 4) {
					return HexToBin(String.format("%2s", a.substring(2)).replace(' ', '0'));
				} else {
					throw new Exception("Illegal Format");
				}
			}
			case "#0", "#1", "#2", "#3", "#4", "#5", "#6", "#7", "#8", "#9", "#-" -> {
				if((!a.startsWith("#-") && a.length() > 4) || (a.startsWith("#-") && a.length() > 5) || Integer.parseInt(a.substring(1)) > 127 || Integer.parseInt(a.substring(1)) < -128) {
					throw new Exception("Illegal Format");
				}
				return IntToBin(Integer.parseInt(a.substring(1)));
			}
			default -> throw new Exception("Illegal Format");
			}
		} else {
			throw new Exception("Illegal Format");
		}
	}
	
	public static String GetEa(String a, HashMap<String, String> labels) throws Exception {
		String e;
		try {
			e = String.format("%d", Integer.valueOf(a));
		} catch(NumberFormatException x) {
			e = labels.get(a);
			if(e == null) {
				throw new Exception("Illegal Format");
			}
		}
		return e;
	}
}
