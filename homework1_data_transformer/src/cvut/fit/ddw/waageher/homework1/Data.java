package cvut.fit.ddw.waageher.homework1;

/**
 *
 * @author waageher
 */
public class Data {

    private final String text;
    private final String annotation;

    public Data(String text, String annotation) {
        this.text = text;
        this.annotation = annotation;
    }

    public String getText() {
        return text;
    }

    public String getAnnotation() {
        return annotation;
    }
}
