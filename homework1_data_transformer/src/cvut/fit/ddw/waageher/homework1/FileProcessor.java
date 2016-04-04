package cvut.fit.ddw.waageher.homework1;

import java.io.File;
import java.io.IOException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;

/**
 *
 * @author waageher
 */
public class FileProcessor {

    private int nodeCounter;
    private int annotationCounter;
    private int fileProcessed;

    private FileProcessor() {
        nodeCounter = 0;
        annotationCounter = 0;
        fileProcessed = 0;
    }

    public static FileProcessor getInstance() {
        return FileProcessorHolder.INSTANCE;
    }

    private static class FileProcessorHolder {

        private static final FileProcessor INSTANCE = new FileProcessor();
    }

    private String getFileRating(File file) {
        return (file.getName().substring(0, file.getName().lastIndexOf(".txt")))
                .substring(file.getName().lastIndexOf("_") + 1);
    }

    private String escapeXMLEntities(String s) {
        String tmp = s;
        tmp = tmp.replace("<br />", "");
        tmp = tmp.replace("<br/>", "");
        tmp = tmp.replace("<br>", "");
        //tmp = tmp.replaceAll("\"", "&quot;");
        //tmp = tmp.replace("\'", "&apos;");
        tmp = tmp.replace("<", "&lt;");
        tmp = tmp.replace(">", "&gt;");
        tmp = tmp.replace("&", "&amp;");
        return tmp;
    }

    public Data processFile(File file) throws IOException {
        if (++fileProcessed % 1000 == 0) {
            System.out.println(fileProcessed + " files processed.");
        }
        LineIterator it = FileUtils.lineIterator(file, "UTF-8");
        String fileContent = "";
        try {
            while (it.hasNext()) {
                fileContent += it.nextLine();
            }
        } finally {
            it.close();
        }
        String preString = (nodeCounter == 0)?"":"\r\n";
        return new Data(
                preString + "<Node id=\"" + (nodeCounter++) + "\" />\r\n" + escapeXMLEntities(fileContent),
                "<Annotation Id=\"" + (annotationCounter++) + "\" Type=\"comment\" StartNode=\"" + (nodeCounter - 1) + "\" EndNode=\"" + nodeCounter + "\">\r\n"
                + "  <Feature>\r\n"
                + "    <Name className=\"java.lang.String\">rating</Name>\r\n"
                + "    <Value className=\"java.lang.String\">" + getFileRating(file) + "</Value>\r\n"
                + "  </Feature>\r\n"
                + "</Annotation>\r\n"
        );
    }

    public void resetCounters() {
        nodeCounter = 0;
        annotationCounter = 0;
    }

    public String getCurrentNode() {
        return "\r\n<Node id=\"" + (nodeCounter) + "\" />\r\n";
    }

    public int getAnnotationCounter() {
        return annotationCounter;
    }
}
