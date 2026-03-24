
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
        entry("JMPL", 5),
        entry("JAL", 3),
        entry("JLAL", 5),
        entry("JALR", 3),
        entry("JLALR", 5),
        entry("JRAL", 1),
        entry("JPLN", 2),
        entry("JPLE", 2),
        entry("JLGT", 2),
        entry("JGE", 7),
        entry("JLGE", 6),
        entry("JGTU", 8),
        entry("JLGTU", 6),
        entry("JGEU", 8),
        entry("JLGEU", 6),
        entry("LDWL", 2),
        entry("LDHL", 2),
        entry("LDBL", 2),
        entry("STWL", 2),
        entry("STHL", 2),
        entry("STBL", 2),
        entry("LDML", 4)
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

        FilePaths.add(new File("./Test.asm"));

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
                for (; i < Assembly.size(); i++) {
                    String inst = Assembly.get(i);
                    if(inst.equals(""))
                        break;
                    String expansion = UnAlias(inst);
                    if(!expansion.equals(inst)) {
                        Assembly.remove(i);
                        Assembly.add(i, expansion);
                    }
                }
                System.out.println(Assembly);
                i = 0;
                int currpc = 0;
                System.out.println(Assembly);
                HashMap<String, Integer> labels = new HashMap<>();
                HashMap<String, Integer> labels1 = new HashMap<>();
                while((i < Assembly.size()) && !Assembly.get(i).equals("")) {
                    scnr2 = new Scanner(Assembly.get(i));
                    String a = scnr2.next();
                    if(a.endsWith(":")) {
                        labels.put(a.substring(0, a.length() - 1), currpc);
                        a = scnr2.next();
                    }
                    Instruction inst = InstList.get(a);
                    if(inst == null) {
                        currpc = currpc + PseudoInstLen.get(a);
                    } else {
                        currpc = currpc + inst.opmode() + 1;
                    }
                    i++;
                }
                int memStart = i++;
                i = 0;
                int size = 0;
                while((memStart + i) < Assembly.size()) {
                    scnr2 = new Scanner(Assembly.get(memStart + i));
                    String a = scnr2.next();
                    if(a.endsWith(":")) {
                        if(a.contains("[")){
                            labels1.put(a.substring(0, a.indexOf('[')), size);
                        } else {
                            labels1.put(a.substring(0, a.length() - 2), size);
                        }
                        size = size + GetDataSize(Assembly.get(memStart + i));
                    } 
                    i++;
                }
                currpc = 0;
                for (i = 0; i < Assembly.size(); i++) {
                    String inst = Assembly.get(i);
                    List<String> expansion;
                    if(inst.matches(".*(LD[WHBM]L|ST[WHB]L).*")) {
                        expansion = PseudoExpand(inst, labels1, currpc);
                    } else {
                        expansion = PseudoExpand(inst, labels, currpc);
                    }
                    
                    if(expansion.size() != 1 || !expansion.getFirst().equals(inst)) {
                        Assembly.remove(i);
                        Assembly.addAll(i, expansion);
                    }
                    currpc = currpc + InstList.get(expansion.getFirst().split("\\s+")[0]).opmode() + 1;
                }
                System.out.println(labels.toString());
                System.out.println(labels1.toString());
                System.out.println(currpc);
                System.out.println("");
                i = 0;
                size = 0;
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

    public static List<String> PseudoExpand(String inst, HashMap<String, Integer> labels, int currpc) throws Exception {
        ArrayList<String> instLine = new ArrayList<>(Arrays.asList(inst.split("\\s+")));
        List<String> ret = new ArrayList<>();
        if(instLine.getFirst().contains(":")) {
            instLine.removeFirst();
        }

        String op = instLine.get(0);
        if(InstList.containsKey(op)) {
            ret.add(inst);
            return ret;
        }
        String r1, r2, r3, r4, newOp;
        switch (op) {
            case "ADDM", "SUBM", "ANDM", "XORM" -> {
                r1 = instLine.get(1);
                r2 = instLine.get(2);
                r3 = GetImmediate(instLine.get(3));
                newOp = op.substring(0, op.length() - 2) + "R";
                // ret.add("LDMU A, #B" + r3.substring(0, 16));
                ret.add("LDMU A, #&0000");
                ret.add("ORM A, A, #B" + r3);
                ret.add(newOp + " " + r1 + ",  "+ r2 + ", A");
            }
            case "ADDX", "SUBX", "ANDX", "ORX", "XORX" -> {
                r1 = instLine.get(1);
                r2 = instLine.get(2);
                r3 = instLine.get(3);
                newOp = op.substring(0, op.length() - 1) + "R";
                ret.add("LDW A, " + r3);
                ret.add(newOp + " " + r1 + ",  "+ r2 + ", A");
            }
            case "MULTM", "MULTMU", "DIVM", "DIVMU" -> {
                r1 = instLine.get(1);
                r2 = instLine.get(2);
                r3 = instLine.get(3);
                r4 = GetImmediate(instLine.get(4));
                if(op.endsWith("U")) {
                    newOp = op.substring(0, op.length() - 2) + "RU";
                } else {
                    newOp = op.substring(0, op.length() - 1) + "R";
                }
                ret.add("LDMU A, #&0000");
                ret.add("ORM A, A, #B" + r4);
                ret.add(newOp + " " + r1 + ",  "+ r2 + ", "+ r3 + "A");
            }
            case "MULTX", "MULTXU", "DIVX", "DIVXU" -> {
                r1 = instLine.get(1);
                r2 = instLine.get(2);
                r3 = instLine.get(3);
                r4 = instLine.get(4);
                if(op.endsWith("U")) {
                    newOp = op.substring(0, op.length() - 2) + "RU";
                } else {
                    newOp = op.substring(0, op.length() - 1) + "R";
                }
                ret.add("LDW A, " + r4);
                ret.add(newOp + " " + r1 + ",  "+ r2 + ", "+ r3 + "A");
            }
            case "CMP", "CMX" -> {
                r1 = instLine.get(1);
                r2 = instLine.get(2);
                if(op.endsWith("P")) {
                    ret.add("LDMU A, #&0000");
                    ret.add("ORM A, A, #B" + GetImmediate(r2));
                } else {
                    ret.add("LDW A, " + r2);
                }
                ret.add("CMPR " + r1 + ", A");
            }
            case "JMP" -> {
                ret.add("LDJ A, #B" + GetImmediate(instLine.get(1)));
                ret.add("JMPR A");
            }
            case "JMPL" -> {
                r1 = IntToBin(labels.get(instLine.get(1)));
                ret.add("LDMU A, #B" + r1.substring(0, 16));
                ret.add("ORM A, A, #B" + r1.substring(16));
                ret.add("JMPR A");
            }
            case "JAL" -> {
                ret.add("LDJ A, #B" + GetImmediate(instLine.get(1)));
                ret.add("JRALR A, RA");
            }
            case "JLAL" -> {
                r1 = IntToBin(labels.get(instLine.get(1)));
                ret.add("LDMU A, #B" + r1.substring(0, 16));
                ret.add("ORM A, A, #B" + r1.substring(16));
                ret.add("JRALR A, RA");
            }
            case "JALR" -> {
                ret.add("LDJ A, #B" + GetImmediate(instLine.get(2)));
                ret.add("JRALR A, " + instLine.get(1));
            }
            case "JLALR" -> {
                r1 = IntToBin(labels.get(instLine.get(2)));
                ret.add("LDMU A, #B" + r1.substring(0, 16));
                ret.add("ORM A, A, #B" + r1.substring(16));
                ret.add("JRALR A, " + instLine.get(1));
            }
            case "JRAL" -> {
                ret.add("JRALR " + instLine.get(1) + ", RA");
            }
            case "JPLN", "JPLE" -> {
                int label = labels.get(instLine.get(1));
                label = (label >> 1) - (currpc + 2);
                ret.add("JP" + op.charAt(3) + " #B" + IntToBin(label).substring(16));
            }
            case "JLGT" -> {
                int label = labels.get(instLine.get(1));
                label = (label >> 1) - (currpc + 2);
                ret.add("JGT #B" + IntToBin(label).substring(16));
            }
            case "JGE", "JGTU", "JGEU" -> {
                r1 = GetImmediate(instLine.get(1));
                int imm = Integer.parseInt(String.format("%32s", r1).replace(' ', r1.charAt(0)), 2);
                if(op.endsWith("U")) {
                    imm = imm + 8;
                    newOp = op.substring(0, 3) + "RU";
                } else {
                    imm = imm + 7;
                    newOp = op + "R";
                }
                ret.add("LDM A, #B" + GetImmediate(Integer.toString(imm)));
                ret.add("LSL A, A, 1");
                ret.add("ADDPC A, A");
                ret.add(newOp + " A");
            }
            case "JLGE", "JLGTU", "JLGEU" -> {
                r1 = IntToBin(labels.get(instLine.get(1)));
                if(op.endsWith("U")) {
                    newOp = "JG" + op.charAt(3) + "RU";
                } else {
                    newOp = "JGER";
                }
                ret.add("LDMU A, #B" + r1.substring(0, 16));
                ret.add("ORM A, A, #B" + r1.substring(16));
                ret.add(newOp + " A");
            }
            case "LDWL", "LDHL", "LDBL", "STWL", "STHL", "STBL" -> {
                ret.add(op.substring(0, 3) + " " + instLine.get(1) + " (#B" + IntToBin(labels.get(instLine.get(2))).substring(16) + ")[Z]");
            }
            case "LDML" -> {
                r1 = instLine.get(1);
                r2 = IntToBin(labels.get(instLine.get(1)));
                ret.add("LDMU " + r1 + " #B" + r2.substring(0, 16));
                ret.add("ORM " + r1 + " " + r1 + " #B" + r2.substring(16));
            }
            default -> throw new Exception("Pseudoinstruction " + op + " is not supported.");
        }
        return ret;
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

	public static String HexToBin(String a) throws Exception {
		String x = "";
		for(int i = 0; i < a.length(); i++) {
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
			case 'A', 'a' -> x += "1010";
			case 'B', 'b' -> x += "1011";
			case 'C', 'c' -> x += "1100";
			case 'D', 'd' -> x += "1101";
			case 'E', 'e' -> x += "1110";
			case 'F', 'f' -> x += "1111";
			default -> throw new Exception("Illegal Format");
			}
		}
        return String.format("%32s", x).replace(' ', x.charAt(0));
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
					return HexToBin(Imm.substring(2)).substring(16);
				} else {
					throw new Exception("Illegal Immediate Format");
				}
			}
			case "#0", "#1", "#2", "#3", "#4", "#5", "#6", "#7", "#8", "#9", "#-" -> {
				if((!Imm.startsWith("#-") && Imm.length() > 6) || (Imm.startsWith("#-") && Imm.length() > 7) || Integer.parseInt(Imm.substring(1)) > 65535 || Integer.parseInt(Imm.substring(1)) < -32768) {
                    throw new Exception("Illegal Immediate Format");
				}
                if(Integer.parseInt(Imm.substring(1)) > 32767 && Integer.parseInt(Imm.substring(1)) <= 65535) {
                    int imm = Integer.parseInt(Imm.substring(1)) - 65536;
                    return IntToBin(imm).substring(16);
                } else {
				    return IntToBin(Integer.parseInt(Imm.substring(1))).substring(16);
                }
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

    public static String UnAlias(String inst) throws Exception {
        ArrayList<String> instLine = new ArrayList<>(Arrays.asList(inst.split("\\s+")));
        if(instLine.getFirst().contains(":")) {
            instLine.removeFirst();
        }

        String op = instLine.get(0);
        switch (op) {
            case "LDMU", "LDWD", "LDWX", "LDWL", "LDHD", "LDHX", "LDHL", "LDBD", "LDBX", "LDBL", "STWD", "STWX", 
                 "STWL", "STHD", "STHX", "STHL", "STBD", "STBX", "STBL", "LDJ", "ADDM", "ADDD", "ADDX", "ADDPC", "SUBM",
                 "SUBD", "SUBX", "NOT", "ANDM", "ANDD", "ANDX", "ANDR", "ORM", "ORD", "ORX", "ORR", "XORM", "XORD", "XORX",
                 "XORR", "ASR", "ASRR", "LSL", "LSLR", "LSR", "LSRR", "CSL", "CSLR", "CSR", "CSRR", "MULTM", "MULTD",
                 "MULTX", "MULTR", "MULTMU", "MULTDU", "MULTXU", "MULTRU", "DIVM", "DIVD", "DIVX", "DIVR", "DIVMU", 
                 "DIVDU", "DIVXU", "DIVRU", "CMD", "CMX", "CMPR", "JMPL", "JMPR", "JLALR", "JRALR",
                 "JPLN", "JPNR", "JPLE", "JPER", "JLGT", "JGTR", "JLGTU", "JGTRU", "JLGE", "JGER", "JLGEU", "JGERU",
                 "NOOP", "END", "INC", "DEC", "MOV", "SWAPR" -> {
                return inst;
            }
            case "LDM" -> {
                String op2 = instLine.get(2);
                if(op2.startsWith("#")) {
                    return inst;
                } else {
                    return inst.replace(op, op + "L");
                }
            }
            case "LDW", "LDH", "LDB", "STW", "STH", "STB" -> {
                String addr = instLine.get(2);
                if(addr.startsWith("[")) {
                    return inst.replace(op, op + "D");
                } else if(addr.startsWith("(")) {
                    return inst.replace(op, op + "X");
                } else {
                    return inst.replace(op, op + "L");
                }
            }
            case "ADD", "SUB", "ADDR", "SUBR", "AND", "OR", "XOR" -> {
                if(instLine.size() == 3) {
                    if(op.endsWith("R")) {
                        return inst.replace(op, op + "_DEST");
                    } else {
                        return inst.replace(op, op + "R_DEST");
                    }
                }
                String op2 = instLine.get(3);
                if(op2.startsWith("#")) {
                    return inst.replace(op, op + "M");
                } else if(op2.startsWith("[")) {
                    return inst.replace(op, op + "D");
                } else if(op2.startsWith("(")) {
                    return inst.replace(op, op + "X");
                } else {
                    return inst.replace(op, op + "R");
                }
            }
            case "MULT", "MULTH", "MULTU", "MULTHU", "DIV", "REM", "DIVU", "REMU" -> {
                if(instLine.size() == 4) {
                    String type;
                    String op2 = instLine.get(3);
                    if(op2.startsWith("#")) {
                       type = "M";
                    } else if(op2.startsWith("[")) {
                        type = "D";
                    } else if(op2.startsWith("(")) {
                        type = "X";
                    } else {
                        type = "R";
                    }
                    if(op.endsWith("H")) {
                        return inst.replaceFirst(instLine.get(1), "Z, " + instLine.get(1)).replace(op, "MULT" + type);
                    } else if(op.endsWith("HU")) {
                        return inst.replaceFirst(instLine.get(1), "Z, " + instLine.get(1)).replace(op, "MULT" + type + "U");
                    } else if(op.endsWith("M")) {
                        return inst.replaceFirst(instLine.get(1), "Z, " + instLine.get(1)).replace(op, "DIV" + type);
                    } else if(op.endsWith("MU")) {
                        return inst.replaceFirst(instLine.get(1), "Z, " + instLine.get(1)).replace(op, "DIV" + type + "U");
                    } else if(op.endsWith("U")) {
                        return inst.replaceFirst(instLine.get(1), instLine.get(1) + " Z,").replace(op, op.substring(0, op.length() - 1) + type + "U");
                    } else {
                        return inst.replaceFirst(instLine.get(1), instLine.get(1) + " Z,").replace(op, op + type);
                    }
                }
                String type;
                String op2 = instLine.get(3);
                if(op2.startsWith("#")) {
                    type = "M";
                } else if(op2.startsWith("[")) {
                    type = "D";
                } else if(op2.startsWith("(")) {
                    type = "X";
                } else {
                    type = "R";
                }
                if(op.endsWith("U")) {
                    return inst.replace(op, op.substring(0, op.length() - 1) + type + "U");
                } else {
                    return inst.replace(op, op + type);
                }
            }
            case "CMP" -> {
                String op2 = instLine.get(2);
                if(op2.startsWith("#")) {
                    return inst;
                } else if(op2.startsWith("[")) {
                    return inst.replace(op, "CMD");
                } else if(op2.startsWith("(")) {
                    return inst.replace(op, "CMX");
                } else {
                    return inst.replace(op, op + "R");
                }
            }
            case "JMP" -> {
                String op2 = instLine.get(1);
                if(op2.startsWith("#")){
                    return inst;
                }
                try {
                    GetReg(op2);
                    return inst.replace(op, op + "R");
                } catch (Exception e) {
                    return inst.replace(op, op + "L");
                }
            }
            case "JAL" -> {
                if(instLine.size() == 2) {
                    String op2 = instLine.get(1);
                    if(op2.startsWith("#")) {
                        return inst;
                    }
                    try {
                        GetReg(op2);
                        return inst.replace(op, "JRAL");
                    } catch (Exception e) {
                        return inst.replace(op, "JLAL");
                    }
                }
                String op2 = instLine.get(2);
                if(op2.startsWith("#")) {
                    return inst.replace(op, "JALR");
                }
                try {
                    GetReg(op2);
                    return inst.replace(op, "JRALR");
                } catch (Exception e) {
                    return inst.replace(op, "JLALR");
                }
            }
            case "JLAL", "JRAL" -> {
                if(instLine.size() == 3) {
                    return inst.replace(op, op + "R");
                } else {
                    return inst;
                }
            }
            case "JALR" -> {
                String op2 = instLine.get(2);
                if(op2.startsWith("#")) {
                    return inst;
                }
                try {
                    GetReg(op2);
                    return inst.replace(op, "JRALR");
                } catch (Exception e) {
                    return inst.replace(op, "JLALR");
                }
            }
            case "JPN", "JPE" -> {
                String op2 = instLine.get(1);
                if(op2.startsWith("#")) {
                    return inst;
                }
                try {
                    GetReg(op2);
                    return inst.replace(op, op + "R");
                } catch (Exception e) {
                    return inst.replace(op, "JPL" + op.charAt(2));
                }
            }
            case "JGT", "JGE" -> {
                String op2 = instLine.get(1);
                if(op2.startsWith("#")) {
                    return inst;
                }
                try {
                    GetReg(op2);
                    return inst.replace(op, op + "R");
                } catch (Exception e) {
                    return inst.replace(op, "JL" + op.substring(1));
                }
            }
            case "JGTU", "JGEU" -> {
                String op2 = instLine.get(1);
                if(op2.startsWith("#")) {
                    return inst;
                }
                try {
                    GetReg(op2);
                    return inst.replace(op, op.substring(0, 3) + "RU");
                } catch (Exception e) {
                    return inst.replace(op, "JL" + op.substring(1));
                }
            }
            default -> throw new Exception("Alias/Instruction/Pseudoinstruction " + op + " is not supported.");
        }
    }

    public static int GetDataSize(String datatype) throws Exception {
        int baseSize = 0;
        int arraySize = 1;
        ArrayList<String> dataLine = new ArrayList<>(Arrays.asList(datatype.split("\\s+")));
        String type = dataLine.get(0).substring(0, dataLine.get(0).length() - 2);
        String baseType = type;
        if(type.contains("[")){
            baseType = type.substring(0, type.indexOf('['));
        }

        switch(baseType) {
            case "byte", "char", "string" -> {
                baseSize = 8;
            }
            case "short", "half" -> {
                baseSize = 16;
            }
            case "int", "word" -> {
                baseSize = 32;
            }
            default -> throw new Exception("Data type " + baseType + " is not supported.");
        }

        if(type.contains("[") && !baseType.equals("string")) {
            if(type.indexOf('[') + 1 != type.indexOf(']')) {
                arraySize = Integer.parseInt(type.substring(type.indexOf('[') + 1, type.indexOf(']')));
            } else if(!dataLine.get(1).startsWith("[") || !dataLine.getLast().endsWith("]")) {
                throw new Exception("Incorrect array format.");
            } else {
                arraySize = dataLine.size() - 1;
            }
        } else if(!type.contains("[") && baseType.equals("string")) {
            arraySize = dataLine.get(1).length() + 1;
        } else if(type.contains("[") && baseType.equals("string")) {
            if(!dataLine.get(1).startsWith("[") || !dataLine.getLast().endsWith("]")){
                throw new Exception("Incorrect array format.");
            }
            arraySize = -2;
            for(int j = 1; j < dataLine.size(); j++) {
                arraySize = arraySize + dataLine.get(j).length() + 1;
            }
        }

        return baseSize * arraySize;
    }
}
