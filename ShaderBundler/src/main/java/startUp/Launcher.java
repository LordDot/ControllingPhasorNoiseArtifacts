package startUp;

import artifact.Artifact;
import artifact.ArtifactReader;
import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import com.google.gson.*;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

public class Launcher {
    @Parameter
    private List<String> parameters;

    public static void main(String[] args) throws IOException {
        Launcher l = new Launcher();
        JCommander.newBuilder().addObject(l).build().parse(args);
        l.launch();
    }

    private void launch() throws IOException {
        JsonObject obj = JsonParser.parseReader(new FileReader(parameters.get(0))).getAsJsonObject();
        String workingDir = "";
        if(parameters.size() > 1){
            workingDir = parameters.get(1) + "/";
        }
        JsonArray includes = obj.get("includes").getAsJsonArray();
        String vertexShader = workingDir + obj.get("vertex").getAsString();
        JsonElement geometryShader = obj.get("geometry");
        String fragmentShader = workingDir + obj.get("fragment").getAsString();
        String output = workingDir + obj.get("out").getAsString();
        List<File> includeFiles = new LinkedList<>();
        for(JsonElement s : includes){
            includeFiles.add(new File(workingDir + s.getAsString()));
        }

        JsonObject artifactTypes = obj.get("artifactTypes").getAsJsonObject();
        ArtifactReader reader = new ArtifactReader(artifactTypes);
        List<Artifact> artifacts = reader.getArtifacts(obj.get("artifacts").getAsJsonArray());

        File geometryFile = null;
        if (geometryShader != null) {
            String geomFile = geometryShader.getAsString();
            if (!(geomFile.equals(""))) {
                geometryFile = new File(workingDir + geomFile);
            }
        }
        ShaderBundler sb = new ShaderBundler(new File(vertexShader), geometryFile, new File(fragmentShader), includeFiles, artifacts);
        sb.bundle(new File(output));
    }


}
