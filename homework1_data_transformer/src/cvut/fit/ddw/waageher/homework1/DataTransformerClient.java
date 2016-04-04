package cvut.fit.ddw.waageher.homework1;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author waageher
 */
public class DataTransformerClient {

    private void addHeader(Writer writer, String location) throws IOException {
        writer.write("<?xml version='1.0' encoding='UTF-8'?>\r\n"
                + "<GateDocument>\r\n"
                + "<!-- The document's features-->\r\n"
                + "<GateDocumentFeatures>\r\n"
                + "<Feature>\r\n"
                + "  <Name className=\"java.lang.String\">gate.SourceURL</Name>\r\n"
                + "  <Value className=\"java.lang.String\">" + location + "</Value>\r\n"
                + "</Feature>\r\n"
                + "<Feature>\r\n"
                + "  <Name className=\"java.lang.String\">MimeType</Name>\r\n"
                + "  <Value className=\"java.lang.String\">text/html</Value>\r\n"
                + "</Feature>\r\n"
                + "</GateDocumentFeatures>\r\n");
    }

    private void addFooter(Writer writer) throws IOException {
        writer.write("</GateDocument>\r\n");
    }

    private void addTexts(Writer writer, List<Data> allData) throws IOException {
        writer.write("<!-- The document content area with serialized nodes -->\r\n");
        writer.write("<TextWithNodes>\r\n");
        for (Data data : allData) {
            writer.write(data.getText());
        }
        writer.write(FileProcessor.getInstance().getCurrentNode());
        writer.write("</TextWithNodes>\r\n");
    }

    private void addAnotations(Writer writer, List<Data> allData) throws IOException {
        writer.write("<!-- Named annotation set -->\r\n");
        writer.write("<AnnotationSet Name=\"Key\">\r\n");
        for (Data data : allData) {
            writer.write(data.getAnnotation());
        }
        writer.write("</AnnotationSet>\r\n");
    }

    private void transformData(Directory directory, String outputFileLocation) {
        System.out.println("Processing files...");
        try (Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFileLocation), "utf-8"))) {
            addHeader(writer, outputFileLocation);
            List<Data> allData = new ArrayList();
            //while (directory.hasNext()) {
            for (int i = 0; i < 1500; i++) {
                allData.add(FileProcessor.getInstance().processFile(directory.getFile()));
            }
            addTexts(writer, allData);
            addAnotations(writer, allData);
            addFooter(writer);
        } catch (IOException ex) {
            Logger.getLogger(DataTransformerClient.class.getName()).log(Level.SEVERE, null, ex);
        }
        FileProcessor.getInstance().resetCounters();
    }

    public void run() {
        transformData(
                new Directory(Locations.positiveTrainDirectoryString.getValue()),
                Locations.positiveTrainOutputFileLocation.getValue()
        );
        transformData(
                new Directory(Locations.negativeTrainDirectoryString.getValue()),
                Locations.negativeTrainOutputFileLocation.getValue()
        );
        transformData(
                new Directory(Locations.positiveTestDirectoryString.getValue()),
                Locations.positiveTestOutputFileLocation.getValue()
        );
        transformData(
                new Directory(Locations.negativeTestDirectoryString.getValue()),
                Locations.negativeTestOutputFileLocation.getValue()
        );
    }
}
