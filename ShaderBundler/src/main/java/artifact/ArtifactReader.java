package artifact;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class ArtifactReader {
    private Map<String,ArtifactType> types;

    public ArtifactReader(JsonObject artifacts) {
        types = new HashMap<>();

        for(String artifactName : artifacts.keySet()){
            JsonObject artifact = artifacts.get(artifactName).getAsJsonObject();

            ArtifactType t = new ArtifactType(artifact.get("template").getAsString());
            JsonArray parameterArray = artifact.get("parameters").getAsJsonArray();
            parseParameters(t, parameterArray);
            types.put(artifactName, t);
        }
    }

    private void parseParameters(ArtifactType artifactType, JsonArray parameterArray){
        for(JsonElement e : parameterArray){
            JsonObject parameterObject = e.getAsJsonObject();
            String name = parameterObject.get("name").getAsString();
            String typeString = parameterObject.get("type").getAsString();
            ArtifactType.Type type;
            if(typeString.equals("float")){
                type = ArtifactType.Type.FLOAT;
            }else{
                throw new RuntimeException("unknown type: " + typeString);
            }
            artifactType.addParameter(name, type);
        }
    }

    public List<Artifact> getArtifacts(JsonArray source){
        List<Artifact> ret = new LinkedList<>();
        for(JsonElement e: source){
            JsonObject artifact = e.getAsJsonObject();
            ArtifactType type = types.get(artifact.get("type").getAsString());
            Artifact a = new Artifact(type);
            for(String parameterName : type.parameters()){
                ArtifactType.Type parameterType = type.getType(parameterName);
                JsonElement parameterElement = artifact.get(parameterName);
                Object parameter;
                if(parameterType == ArtifactType.Type.FLOAT){
                    parameter = parameterElement.getAsFloat();
                }else{
                    throw new RuntimeException("Not Implemented");
                }
                a.addParameter(parameter);
            }
            ret.add(a);
        }
        return ret;
    }
}
