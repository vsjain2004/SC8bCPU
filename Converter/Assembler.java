
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import static java.util.Map.entry;
import java.util.Scanner;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Assembler {

    public record Instruction(String opcode, int opmode, String family, String function) {};

    Map<String, Instruction> InstList = Map.ofEntries(
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

    Map<String, Integer> PseudoInstLen = Map.ofEntries(
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
                // for (i = 0; i < Assembly.size(); i++) {
                //     String inst = Assembly.get(i);
                //     List<String> expansion = PseudoExpand(inst);
                //     if(expansion.size() != 1 || !expansion.getFirst().equals(inst)) {
                //         Assembly.remove(i);
                //         Assembly.addAll(i, expansion);
                //     }
                // }
                i = 0;
                // System.out.println(Assembly);
                HashMap<String, Integer> labels = new HashMap<>();
                HashMap<String, String> labels1 = new HashMap<>();
                String y;
                while((i < Assembly.size()) && !Assembly.get(i).equals("")) {
                    scnr2 = new Scanner(Assembly.get(i));
                    String a = scnr2.next();
                    if(a.endsWith(":")) {
                        labels.put(a.substring(0, a.length() - 1), i);
                    }
                    i++;
                }
                i++;
                while(i < Assembly.size()) {
                    scnr2 = new Scanner(Assembly.get(i));
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
            //     while(line != null && !line.equals("") && i < 16) {
            //         while(line != null && line.stripLeading().startsWith("//")) {
            //             line = scnr.nextLine();
            //         }
            //         if(line == null) {
            //             break;
            //         }
            //         scnr2 = new Scanner(line);
            //         String a = scnr2.next();
            //         String b, c, d, e;
            //         if(a.contains(":")){
            //             a = scnr2.next();
            //         }
            //         switch(a) {
            //         case "NOOP" -> {
            //             if(!scnr2.hasNext()) {
            //                 b = "0000";
            //                 c = "11";
            //                 d = "00";
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Instruction Format");
            //             }
            //         }
            //         case "IN" -> {
            //             a = scnr2.next();
            //             if(!scnr2.hasNext()) {
            //                 b = "0001";
            //                 c = "11";
            //                 d = GetD(a);
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "OUT" -> {
            //             a = scnr2.next();
            //             if(!scnr2.hasNext()) {
            //                 b = "0010";
            //                 c = "11";
            //                 d = GetD(a);
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "END" -> {
            //             if(!scnr2.hasNext()) {
            //                 b = "0001";
            //                 c = "00";
            //                 d = "00";
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "LDM", "LDD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "0000";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("LDM")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("LDD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "LDX" -> {
            //             a = scnr2.next();
            //             b = "0000";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "STO" -> {
            //             a = scnr2.next();
            //             b = "0001";
            //             c = "01";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "STX" -> {
            //             a = scnr2.next();
            //             b = "0001";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "ADDM", "ADDD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "0010";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("ADDM")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("ADDD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "ADDX" -> {
            //             a = scnr2.next();
            //             b = "0010";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "SUBM", "SUBD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "0011";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("SUBM")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("SUBD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "SUBX" -> {
            //             a = scnr2.next();
            //             b = "0011";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "INC" -> {
            //             a = scnr2.next();
            //             if(!scnr2.hasNext()) {
            //                 b = "0110";
            //                 c = "00";
            //                 d = GetD(a);
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "DEC" -> {
            //             a = scnr2.next();
            //             if(!scnr2.hasNext()) {
            //                 b = "0110";
            //                 c = "01";
            //                 d = GetD(a);
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "LSL" -> {
            //             a = scnr2.next();
            //             b = "0110";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetE(scnr2.next());
            //         }
            //         case "LSR" -> {
            //             a = scnr2.next();
            //             b = "0110";
            //             c = "11";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetE(scnr2.next());
            //         }
            //         case "ADDR" -> {
            //             a = scnr2.next();
            //             b = "0100";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             c = GetD(scnr2.next());
            //             e = "00000000";
            //         }
            //         case "SUBR" -> {
            //             a = scnr2.next();
            //             b = "0101";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             c = GetD(scnr2.next());
            //             e = "00000000";
            //         }
            //         case "CMP", "CMD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "1000";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("CMP")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("CMD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "CMX" -> {
            //             a = scnr2.next();
            //             b = "1000";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "JMP" -> {
            //             b = "1000";
            //             c = "11";
            //             d = "00";
            //             e = GetEa(scnr2.next(), labels);
            //         }
            //         case "JPN" -> {
            //             b = "1001";
            //             c = "00";
            //             d = "00";
            //             e = GetEa(scnr2.next(), labels);
            //         }
            //         case "JPE" -> {
            //             b = "1001";
            //             c = "01";
            //             d = "00";
            //             e = GetEa(scnr2.next(), labels);
            //         }
            //         case "JGT" -> {
            //             b = "1001";
            //             c = "10";
            //             d = "00";
            //             e = GetEa(scnr2.next(), labels);
            //         }
            //         case "JGE" -> {
            //             b = "1001";
            //             c = "11";
            //             d = "00";
            //             e = GetEa(scnr2.next(), labels);
            //         }
            //         case "SWAPR" -> {
            //             a = scnr2.next();
            //             b = "0111";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             c = GetD(scnr2.next());
            //             e = "00000000";
            //         }
            //         case "ANDM", "ANDD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "1010";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("ANDM")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("ANDD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "ANDX" -> {
            //             a = scnr2.next();
            //             b = "1010";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "ORM", "ORD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "1100";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("ORM")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("ORD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "ORX" -> {
            //             a = scnr2.next();
            //             b = "1100";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "XORM", "XORD" -> {
            //             y = a;
            //             a = scnr2.next();
            //             b = "1110";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             a = scnr2.next();
            //             if(a.startsWith("#") && y.equals("XORM")) {
            //                 c = "00";
            //                 e = GetE(a);
            //             } else if (y.equals("XORD")) {
            //                 c = "01";
            //                 e = GetEa(a, labels1);
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "XORX" -> {
            //             a = scnr2.next();
            //             b = "1110";
            //             c = "10";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetEa(scnr2.next(), labels1);
            //         }
            //         case "NOT" -> {
            //             a = scnr2.next();
            //             if(!scnr2.hasNext()) {
            //                 b = "1010";
            //                 c = "11";
            //                 d = GetD(a);
            //                 e = "00000000";
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         case "ASR" -> {
            //             a = scnr2.next();
            //             b = "0011";
            //             c = "11";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetE(scnr2.next());
            //         }
            //         case "CSL" -> {
            //             a = scnr2.next();
            //             b = "1100";
            //             c = "11";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetE(scnr2.next());
            //         }
            //         case "CSR" -> {
            //             a = scnr2.next();
            //             b = "1110";
            //             c = "11";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             e = GetE(scnr2.next());
            //         }
            //         case "ANDR" -> {
            //             a = scnr2.next();
            //             b = "1011";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             c = GetD(scnr2.next());
            //             e = "00000000";
            //         }
            //         case "ORR" -> {
            //             a = scnr2.next();
            //             b = "1101";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             c = GetD(scnr2.next());
            //             e = "00000000";
            //         }
            //         case "XORR" -> {
            //             a = scnr2.next();
            //             b = "1111";
            //             if(a.endsWith(",")) {
            //                 d = GetD(a.substring(0, a.length() - 1));
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //             c = GetD(scnr2.next());
            //             e = "00000000";
            //         }
            //         default -> throw new Exception("Command " + a + " not supported");
            //         }
            //         for(int j = 0; j < 8; j++) {
            //             if(e.charAt(j) == '0' || e.charAt(j) == '1') {
            //             } else {
            //                 throw new Exception("Illegal Format");
            //             }
            //         }
            //         if(i < 15) {
            //             pi.println(String.format("%4s", Integer.toHexString((Integer.parseInt(b + c + d + e,2)))).replace(' ', '0'));
            //         } else {
            //             pi.print(String.format("%4s", Integer.toHexString((Integer.parseInt(b + c + d + e,2)))).replace(' ', '0'));
            //         }
            //         try {
            //             line = scnr.nextLine();
            //         } catch(java.util.NoSuchElementException g) {
            //             line = "";
            //         }
            //         i += 1;
            //     }
            //     if(i == 16 && !"".equals(line)) {
            //         throw new Exception("Too many instruction lines");
            //     } else if(i < 16) {
            //         for(; i < 15; i++) {
            //             pi.println("0000");
            //         }
            //         pi.print("0000");
            //     }
            //     if(line == null) {
            //         throw new Exception("Illegal Format");
            //     }
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
            //             throw new Exception("Illegal Format");
            //         }
            //         if(i < 7) {
            //             pd.println(String.format("%2s", Integer.toHexString((Integer.parseInt(GetE(a),2)))).replace(' ', '0'));
            //         } else {
            //             pd.print(String.format("%2s", Integer.toHexString((Integer.parseInt(GetE(a),2)))).replace(' ', '0'));
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
            //         throw new Exception("Illegal Format");
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

    private static List<String> PseudoExpand(String inst) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
