package startUp;

import java.io.*;
import java.util.List;

public class ShaderBundler {

    private final File vertexShader;
    private final File fragmentShader;
    private final List<File> includes;

    public ShaderBundler(File vertexShader, File fragmentShader, List<File> includes){
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        this.includes = includes;
    }

    public void bundle(File outputFile) throws IOException {
        if(outputFile.exists()){
            outputFile.delete();
        }
        outputFile.createNewFile();
        Writer out = new FileWriter(outputFile);
        BufferedReader in = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("Prefix.txt")));
        String line;
        while((line = in.readLine()) != null){
            out.write(line+"\n");
        }
        in.close();
        for(File f: includes){
            in = new BufferedReader(new FileReader(f));
            while((line = in.readLine()) != null){
                out.write(line+"\n");
            }
            in.close();
        }
        out.write("#ifdef VERTEX\n");
        in = new BufferedReader(new FileReader(vertexShader));
        while((line = in.readLine()) != null){
            out.write(line + "\n");
        }
        in.close();
        out.write("#endif\n");
        out.write("#ifdef FRAGMENT\n");
        in = new BufferedReader(new FileReader(fragmentShader));
        while((line = in.readLine()) != null){
            out.write(line + "\n");
        }
        in.close();
        out.write("#endif\n");
        in = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("Suffix.txt")));
        while((line = in.readLine()) != null){
            out.write(line + "\n");
        }
        in.close();
        out.close();
    }
}
