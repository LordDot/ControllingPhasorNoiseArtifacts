package artifact;

import java.util.LinkedList;
import java.util.List;

public class Artifact {
    private List<Object> parameters;
    private ArtifactType type;

    public Artifact(ArtifactType type) {
        this.type = type;
        parameters = new LinkedList<>();
    }

    public void addParameter(Object o){
        parameters.add(o);
    }

    public String format(){
        return String.format(type.getTemplate(),parameters.toArray());
    }
}
