package startUp;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import com.google.gson.*;
import jdk.nashorn.internal.parser.JSONParser;

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
        JsonArray includes = obj.get("includes").getAsJsonArray();
        String vertexShader = obj.get("vertex").getAsString();
        String fragmentShader = obj.get("fragment").getAsString();
        String output = obj.get("out").getAsString();
        List<File> includeFiles = new LinkedList<>();
        for(JsonElement s : includes){
            includeFiles.add(new File(s.getAsString()));
        }
        ShaderBundler sb = new ShaderBundler(new File(vertexShader), new File(fragmentShader), includeFiles);
        sb.bundle(new File(output));
    }


}
