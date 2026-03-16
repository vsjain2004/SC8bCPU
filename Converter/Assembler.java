
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import static java.util.Map.entry;
import java.util.NoSuchElementException;
import java.util.Scanner;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Assembler {

    public record Instruction(String opcode, int opmode, String family, String function) {};

    static Map<String, Instruction> InstList = Map.ofEntries(
        entry("NOOP", new Instruction("0000", 0, "", "")),
        entry("END", new Instruction("0001", 0, "", "")),
        entry("INC", new Instruction("0010", 0, "", "")),
        entry("DEC", new Instruction("0011", 0, "", "")),
        entry("MOV", new Instruction("0100", 0, "", "")),
        entry("SWAPR", new Instruction("0101", 0, "", "")),
        entry("CMPR", new Instruction("0110", 0, "", "")),
        entry("NOT", new Instruction("0111", 0, "", "")),
        entry("ADDR_DEST", new Instruction("1000", 0, "", "")),
        entry("SUBR_DEST", new Instruction("1001", 0, "", "")),
        entry("JMPR", new Instruction("1010", 0, "", "")),
        entry("JRALR", new Instruction("1011", 0, "", "")),
        entry("JPNR", new Instruction("1100", 0, "", "")),
        entry("JPER", new Instruction("1101", 0, "", "")),
        entry("JGTR", new Instruction("1110", 0, "", "")),
        entry("JGER", new Instruction("1111", 0, "", "")),
        entry("LDM", new Instruction("0000", 1, "", "")),
        entry("LDMU", new Instruction("0001", 1, "", "")),
        entry("LDW", new Instruction("0010", 1, "", "")),
        entry("LDH", new Instruction("0011", 1, "", "")),
        entry("LDB", new Instruction("0100", 1, "", "")),
        entry("STW", new Instruction("0101", 1, "", "")),
        entry("STH", new Instruction("0110", 1, "", "")),
        entry("STB", new Instruction("0111", 1, "", "")),
        entry("ORM", new Instruction("1000", 1, "", "")),
        entry("JPN", new Instruction("1001", 1, "", "")),
        entry("JPE", new Instruction("1010", 1, "", "")),
        entry("JGT", new Instruction("1011", 1, "", "")),
        entry("JDJ", new Instruction("1100", 1, "", "")),
        entry("ADDD", new Instruction("1101", 1, "00", "000000000")),
        entry("ADDR", new Instruction("1101", 1, "00", "000000001")),
        entry("SUBD", new Instruction("1101", 1, "00", "000000010")),
        entry("SUBR", new Instruction("1101", 1, "00", "000000011")),
        entry("ANDD", new Instruction("1101", 1, "01", "000000000")),
        entry("ANDR", new Instruction("1101", 1, "01", "000000001")),
        entry("ORD", new Instruction("1101", 1, "01", "000000010")),
        entry("ORR", new Instruction("1101", 1, "01", "000000011")),
        entry("XORD", new Instruction("1101", 1, "01", "000000100")),
        entry("XORR", new Instruction("1101", 1, "01", "000000101")),
        entry("ASR", new Instruction("1101", 1, "01", "000000110")),
        entry("ASRR", new Instruction("1101", 1, "01", "000000111")),
        entry("LSL", new Instruction("1101", 1, "01", "000001000")),
        entry("LSLR", new Instruction("1101", 1, "01", "000001001")),
        entry("LSR", new Instruction("1101", 1, "01", "000001010")),
        entry("LSRR", new Instruction("1101", 1, "01", "000001011")),
        entry("CSL", new Instruction("1101", 1, "01", "000001100")),
        entry("CSLR", new Instruction("1101", 1, "01", "000001101")),
        entry("CSR", new Instruction("1101", 1, "01", "000001110")),
        entry("CSRR", new Instruction("1101", 1, "01", "000001111")),
        entry("MULTD", new Instruction("1101", 1, "10", "0000")),
        entry("MULTR", new Instruction("1101", 1, "10", "0001")),
        entry("MULTDU", new Instruction("1101", 1, "10", "0010")),
        entry("MULTRU", new Instruction("1101", 1, "10", "0011")),
        entry("DIVD", new Instruction("1101", 1, "10", "0100")),
        entry("DIVR", new Instruction("1101", 1, "10", "0101")),
        entry("DIVDU", new Instruction("1101", 1, "10", "0110")),
        entry("DIVRU", new Instruction("1101", 1, "10", "0111")),
        entry("JGTRU", new Instruction("1101", 1, "11", "000000000")),
        entry("JGERU", new Instruction("1101", 1, "11", "000000001")),
        entry("CMD", new Instruction("1101", 1, "11", "000000010")),
        entry("ADDPC", new Instruction("1101", 1, "11", "000000011"))
    );

    static Map<String, Integer> PseudoInstLen = Map.ofEntries(
        entry("ADDM", 6),
        entry("ADDX", 4),
        entry("SUBM", 6),
        entry("SUBX", 4),
        entry("ANDM", 6),
        entry("ANDX", 4),
        entry("ORX", 4),
        entry("XORM", 6),
        entry("XORX", 4),
        entry("MULTM", 6),
        entry("MULTX", 4),
        entry("MULTMU", 6),
        entry("MULTXU", 4),
        entry("DIVM", 6),
        entry("DIVX", 4),
        entry("DIVMU", 6),
        entry("DIVXU", 4),
        entry("CMP", 5),
        entry("CMX", 3),
        entry("JMP", 3),
        entry("JAL", 3),
        entry("JALR", 3),
        entry("JRAL", 1),
        entry("JGE", 7),
        entry("JGTU", 8),
        entry("JGEU", 8)
    );

    public static void main(String[] args) throws IOException{
        ArrayList<File> FilePaths = new ArrayList<>();

        for (String arg : args) {
            Path path = Paths.get(arg);
            if(Files.exists(path)){
                if(Files.isRegularFile(path) && path.toString().endsWith(".asm")){
                    FilePaths.add(path.toFile());
                } else if(Files.isDirectory(path)){
                        Stream<Path> stream = Files.list(path);
                        for(Path fp : stream.filter(Files::isRegularFile).collect(Collectors.toList())){
                            if(fp.toString().endsWith(".asm")) {
                                FilePaths.add(fp.toFile());
                            }
                        }
                }
            }
        }

        FilePaths.add(new File("./instLine.asm"));

        for(File f : FilePaths){
            String BasePath = f.getPath().substring(0, f.getPath().lastIndexOf('.'));
            File imem = new File(BasePath + "_IMEM.hex");
		    File dmem = new File(BasePath + "_DMEM.hex");
            imem.createNewFile();
		    dmem.createNewFile();
            Scanner scnr2 = null;
            Scanner scnr = null;
            PrintWriter pi = new PrintWriter(imem);
            PrintWriter pd = new PrintWriter(dmem);

            try {
                int i = 0;
                scnr = new Scanner(f);
                pi = new PrintWriter(imem);
                String line = scnr.nextLine();
                LinkedList<String> Assembly = new LinkedList<>();
                while(line != null) {
                    scnr2 = new Scanner(line);
                    String a = scnr2.next();
                    if(!a.startsWith("//")){
                        Assembly.add(line);
                    }
                    try {
                        line = scnr.nextLine();
                        if(line.equals("")) {
                            Assembly.add(line);
                            line = scnr.nextLine();
                        }
                    } catch(java.util.NoSuchElementException d) {
                        line = null;
                    }
                }
                for (i = 0; i < Assembly.size(); i++) {
                    String inst = Assembly.get(i);
                    String expansion = UnAlias(inst);
                    if(!expansion.equals(inst)) {
                        Assembly.remove(i);
                        Assembly.add(i, expansion);
                    }
                }
                i = 0;
                System.out.println(Assembly);
                HashMap<String, Integer> labels = new HashMap<>();
                HashMap<String, String> labels1 = new HashMap<>();
                while((i < Assembly.size()) && !Assembly.get(i).equals("")) {
                    scnr2 = new Scanner(Assembly.get(i));
                    String a = scnr2.next();
                    if(a.endsWith(":")) {
                        labels.put(a.substring(0, a.length() - 1), i);
                    }
                    i++;
                }
                int memStart = i++;
                for (i = 0; i < Assembly.size(); i++) {
                    String inst = Assembly.get(i);
                    List<String> expansion = PseudoExpand(inst, labels);
                    if(expansion.size() != 1 || !expansion.getFirst().equals(inst)) {
                        Assembly.remove(i);
                        Assembly.addAll(i, expansion);
                    }
                }
                i = 0;
                System.out.println(Assembly);
                while((memStart + i) < Assembly.size()) {
                    scnr2 = new Scanner(Assembly.get(memStart + i));
                    String a = scnr2.next();
                    if(a.endsWith(":")) {
                        labels1.put(a.substring(0, a.length() - 1), IntToBin(i));
                    }
                    i++;
                }

                System.out.println(labels.toString());
                System.out.println(labels1.toString());
                System.out.println("");
                i = 0;
                int size = 0;
                while(i < Assembly.size() && !Assembly.get(i).equals("") && size < (1<<11)) {
                    ArrayList<String> instLine = new ArrayList<>(Arrays.asList(Assembly.get(i).split("\\s+")));
                    if(instLine.getFirst().contains(":")) {
                        instLine.removeFirst();
                    }
                    String op = instLine.getFirst();
                    Instruction inst = InstList.get("NOOP");
                    String R1_Rd_Rd1="00000", R2_R1="00000", R2="00000", Rd2="00000", Imm="0000000000000000", a;
                    switch(op) {
                    case "NOOP", "END" -> {
                        if(instLine.size() == 1) {
                            inst = InstList.get(op);
                            R1_Rd_Rd1 = "00000";
                            R2_R1 = "00000";
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "INC", "DEC", "JMPR", "JPNR", "JPER", "JGTR", "JGER" -> {
                        if(instLine.size() == 2) {
                            inst = InstList.get(op);
                            R1_Rd_Rd1 = GetReg(instLine.get(1));
                            R2_R1 = "00000";
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "MOV", "SWAPR", "CMPR", "ADDR_DEST", "SUBR_DEST", "NOT", "JRALR", "ADDPC" -> {
                        a = instLine.get(1);
                        if(a.endsWith(",") || instLine.size() != 3) {
                            inst = InstList.get(op);
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        R2_R1 = instLine.get(2);
                    }
                    case "LDM", "LDMU", "LDJ" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 3) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                            R2_R1 = "00000";
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith("#")) {
                            Imm = GetImmediate(a);
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "LDW", "LDH", "LDB", "STW", "STH", "STB" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 3) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith("(") || a.startsWith("[")) {
                            String[] Address = GetAddress(a);
                            R2_R1 = Address[0];
                            Imm = Address[1];
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "ORM" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 4) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith(",")) {
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(3);
                        if(a.startsWith("#")) {
                            Imm = GetImmediate(a);
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "JPN", "JPE", "JGT" -> {
                        inst = InstList.get(op);
                        if(instLine.size() != 2) {
                            R1_Rd_Rd1 = "00000";
                            R2_R1 = "00000";
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(1);
                        if(a.startsWith("#")) {
                            Imm = GetImmediate(a);
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "ADDD", "SUBD", "ANDD", "ORD", "XORD" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 4) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith(",")) {
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(3);
                        if(a.startsWith("[")) {
                            R2 = GetAddress(a)[0];
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "ADDR", "SUBR", "ANDR", "ORR", "XORR", "ASRR", "LSLR", "LSRR", "CSLR", "CSRR" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 4) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith(",")) {
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        R2 = GetReg(instLine.get(3));
                    }
                    case "ASR", "LSL", "LSR", "CSL", "CSR" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 4) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith(",")) {
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        if(a.startsWith("#")) {
                            R2 = GetImmediate(a).substring(11);
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "MULTD", "MULTDU", "DIVD", "DIVDU" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 5) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith(",")) {
                            Rd2 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(3);
                        if(a.startsWith(",")) {
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(4);
                        if(a.startsWith("[")) {
                            R2 = GetAddress(a)[0];
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "MULTR", "MULTRU", "DIVR", "DIVRU" -> {
                        a = instLine.get(1);
                        inst = InstList.get(op);
                        if(a.endsWith(",") || instLine.size() != 5) {
                            R1_Rd_Rd1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(2);
                        if(a.startsWith(",")) {
                            Rd2 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        a = instLine.get(3);
                        if(a.startsWith(",")) {
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        R2 = GetReg(instLine.get(4));
                    }
                    case "JGTRU", "JGERU" -> {
                        inst = InstList.get(op);
                        if(instLine.size() != 2) {
                            R2_R1 = GetReg(instLine.get(1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                    }
                    case "CMD" -> {
                        a = instLine.get(1);
                        if(a.endsWith(",") || instLine.size() != 3) {
                            inst = InstList.get(op);
                            R2_R1 = GetReg(a.substring(0, a.length() - 1));
                        } else {
                            throw new Exception("Illegal Instruction Format");
                        }
                        R2 = instLine.get(2);
                    }
                    default -> throw new Exception("Command " + op + " not supported");
                    }
                    if(inst.opmode() == 0) {
                        pi.print(String.format("%4s", Integer.toHexString((Integer.parseInt(inst.opcode() + R1_Rd_Rd1 + R2_R1 + "00",2)))).replace(' ', '0'));
                        size += 1;
                    } else if(!inst.opcode().equals("1101")) {
                        String instHex = String.format("%8s", Integer.toHexString((Integer.parseInt(inst.opcode() + R1_Rd_Rd1 + R2_R1 + Imm + "01",2)))).replace(' ', '0');
                        pi.print(instHex.substring(0, 16));
                        pi.print(instHex.substring(16));
                        size += 2;
                    } else if(!inst.family().equals("10")) {
                        String instHex = String.format("%8s", Integer.toHexString((Integer.parseInt(inst.opcode() + R1_Rd_Rd1 + R2_R1 + R2 + inst.family() + inst.function() + "01",2)))).replace(' ', '0');
                        pi.print(instHex.substring(0, 16));
                        pi.print(instHex.substring(16));
                        size += 2;
                    } else {
                        String instHex = String.format("%8s", Integer.toHexString((Integer.parseInt(inst.opcode() + R1_Rd_Rd1 + R2_R1 + R2 + inst.family() + Rd2 + inst.function() + "01",2)))).replace(' ', '0');
                        pi.print(instHex.substring(0, 16));
                        pi.print(instHex.substring(16));
                        size += 2;
                    }
                    i += 1;
                }
                if(size == (1<<11) && !"".equals(Assembly.get(i))) {
                    throw new Exception("Too many instruction lines");
                } else if(size < (1<<11)) {
                    for(; size < (1<<11); size++) {
                        pi.print("0000");
                    }
                }
                if(line == null) {
                    throw new Exception("Illegal Instruction Format");
                }
            //     i = 0;
            //     try {
            //         line = scnr.nextLine();
            //     } catch(java.util.NoSuchElementException g) {
            //         line = null;
            //     }
            //     pd = new PrintWriter(dmem);
                
            //     while(line != null && i < 8) {
            //         while(line != null && line.startsWith("//")) {
            //             line = scnr.nextLine();
            //         }
            //         if(line == null) {
            //             break;
            //         }
            //         scnr2 = new Scanner(line);
            //         String a = scnr2.next();
            //         if(labels1.containsKey(a.substring(0, a.length() - 1))) {
            //             a = scnr2.next();
            //         } else if (a.endsWith(":")) {
            //             throw new Exception("Illegal Instruction Format");
            //         }
            //         if(i < 7) {
            //             pd.println(String.format("%2s", Integer.toHexString((Integer.parseInt(GetImmediate(a),2)))).replace(' ', '0'));
            //         } else {
            //             pd.print(String.format("%2s", Integer.toHexString((Integer.parseInt(GetImmediate(a),2)))).replace(' ', '0'));
            //         }
            //         try {
            //             line = scnr.nextLine();
            //         } catch(java.util.NoSuchElementException d) {
            //             line = null;
            //         }
            //         i++;
            //     }
            //     if(i == 8 && line != null) {
            //         throw new Exception("Too many data lines");
            //     }else if(i < 8 && line == null) {
            //         for(; i < 7; i++) {
            //             pd.println("00");
            //         }
            //         pd.print("00");
            //     } else if(!(i == 8 && line == null)) {
            //         throw new Exception("Illegal Instruction Format");
            //     }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                pi.flush();
                pi.close();
                pd.flush();
                pd.close();
                scnr.close();
                scnr2.close();
            }
        }

        System.out.println("Hex Files generated.");
    }

    public static String IntToBin(int a) {
		String x;
		if(a >= 0) {
			x = String.format("%32s", Integer.toBinaryString(a)).replace(' ', '0');
		} else {
			x = Integer.toBinaryString(a);
		}
		return x;
	}

    public static List<String> PseudoExpand(String inst, HashMap<String, Integer> labels) {
        ArrayList<String> instLine = new ArrayList<>(Arrays.asList(inst.split("\\s+")));
        String start = null;
        if(instLine.getFirst().contains(":")) {
            start = instLine.removeFirst();
        }

        String op = instLine.get(1);
        switch (op) {
            case "" -> {
            }
            default -> throw new AssertionError();
        }
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public static String GetReg(String Reg) {
        switch (Reg) {
            case "Z" -> {
                return "00000";
            }
            case "A" -> {
                return "00001";
            }
            case "RA" -> {
                return "11111";
            }
            case "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15", "R16", 
                 "R17", "R18", "R19", "R20", "R21", "R22", "R23", "R24", "R25", "R26", "R27", "R28", "R29", "R30" -> {
                return String.format("%5s", Integer.toBinaryString(Integer.parseInt(Reg.substring(1)))).replace(' ', '0');
            }
            default -> throw new NoSuchElementException("Reg " + Reg + " does not exist.");
        }
    }

    public static String GetImmediate(String Imm) throws Exception {
        if (Imm.startsWith("#")) {
			switch(Imm.substring(0, 2)) {
			case "#B" -> {
				if(Imm.length() <= 18) {
					return String.format("%16s", Imm.substring(2)).replace(' ', '0');
				} else {
					throw new Exception("Illegal Immediate Format");
				}
			}
			case "#&" -> {
				if(Imm.length() <= 6) {
					return String.format("%16s", Integer.toBinaryString(Integer.parseInt(String.format("%4s", Imm.substring(2)), 16))).replace(' ', '0');
				} else {
					throw new Exception("Illegal Immediate Format");
				}
			}
			case "#0", "#1", "#2", "#3", "#4", "#5", "#6", "#7", "#8", "#9", "#-" -> {
				if((!Imm.startsWith("#-") && Imm.length() > 6) || (Imm.startsWith("#-") && Imm.length() > 7) || Integer.parseInt(Imm.substring(1)) > 32767 || Integer.parseInt(Imm.substring(1)) < -32768) {
					throw new Exception("Illegal Immediate Format");
				}
				return IntToBin(Integer.parseInt(Imm.substring(1))).substring(16);
			}
			default -> throw new Exception("Illegal Immediate Format");
			}
		} else {
			throw new Exception("Illegal Immediate Format");
		}
    }

    public static String[] GetAddress(String Addr) throws Exception {
        String[] ret = new String[2];
        if(Addr.startsWith("(")){
            String Imm = Addr.substring(1, Addr.lastIndexOf(')'));
            if(Imm.startsWith("#")){
                ret[1] = GetImmediate(Imm);
            } else if (Pattern.matches("[0-9a-fA-F]+", Imm)) {
                ret[1] = GetImmediate("#&" + Imm);
            } else if (Pattern.matches("\\d*[2-9]\\d*", Imm)) {
                ret[1] = GetImmediate("#" + Imm);
            } else if (Pattern.matches("[01]+", Imm)) {
                ret[1] = GetImmediate("#B" + Imm);
            }
            ret[0] = GetReg(Addr.substring(Addr.lastIndexOf('[') + 1, Addr.lastIndexOf(']')));
        } else if(Addr.startsWith("[")){
            ret[0] = GetReg(Addr.substring(1, Addr.lastIndexOf(']')));
            ret[1] = "0000000000000000";
        } else {
			throw new Exception("Illegal Address Format");
		}
        return ret;
    }

    public static String UnAlias(String inst) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
