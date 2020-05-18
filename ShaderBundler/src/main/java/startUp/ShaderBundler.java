package startUp;

import artifact.Artifact;

import java.io.*;
import java.util.List;

public class ShaderBundler {

    private File vertexShader;
    private File fragmentShader;
    private File geometryShader;
    private List<File> includes;
    private List<Artifact> artifacts;

    public ShaderBundler(File vertexShader, File geometryShader, File fragmentShader, List<File> includes, List<Artifact> artifacts){
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
        this.geometryShader = geometryShader;
        this.includes = includes;
        this.artifacts = artifacts;
    }

    private String getArtifactsString(){
        StringBuilder b = new StringBuilder();
        for(Artifact a : artifacts){
            b.append(a.format() + "\n");
        }
        return b.toString();
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
                if(line.trim().equals("{ARTIFACTS}")){
                    out.write(getArtifactsString());
                }else {
                    out.write(line + "\n");
                }
            }
            in.close();
        }
        out.write("#ifdef VERTEX\n");
        in = new BufferedReader(new FileReader(vertexShader));
        while((line = in.readLine()) != null){
            if(line.trim().equals("{ARTIFACTS}")){
                out.write(getArtifactsString());
            }else {
                out.write(line + "\n");
            }
        }
        in.close();
        out.write("#endif\n");

        if(geometryShader != null) {
            out.write("#ifdef GEOMETRY\n");
            in = new BufferedReader(new FileReader(geometryShader));
            while((line = in.readLine()) != null){
                if(line.trim().equals("{ARTIFACTS}")){
                    out.write(getArtifactsString());
                }else {
                    out.write(line + "\n");
                }
            }
            out.write("#endif\n");
        }

        out.write("#ifdef FRAGMENT\n");
        in = new BufferedReader(new FileReader(fragmentShader));
        while((line = in.readLine()) != null){
            if(line.trim().equals("{ARTIFACTS}")){
                out.write(getArtifactsString());
            }else {
                out.write(line + "\n");
            }
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
