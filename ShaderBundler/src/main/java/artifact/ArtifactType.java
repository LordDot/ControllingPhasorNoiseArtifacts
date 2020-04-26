package artifact;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class ArtifactType {
    public enum Type{
        FLOAT
    }

    private Map<String, Type> parameters;
    private String template;

    public ArtifactType(String template) {
        this.template = template;
        this.parameters = new LinkedHashMap<>();
    }

    public void addParameter(String name, Type type){
        parameters.put(name, type);
    }

    public Type getType(String name){
        return parameters.get(name);
    }

    public Iterable<String> parameters(){
        return parameters.keySet();
    }

    public String getTemplate() {
        return template;
    }
}
