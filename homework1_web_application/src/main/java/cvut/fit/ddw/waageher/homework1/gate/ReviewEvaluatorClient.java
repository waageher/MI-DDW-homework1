package cvut.fit.ddw.waageher.homework1.gate;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Corpus;
import gate.CreoleRegister;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.Resource;
import gate.creole.ConditionalSerialAnalyserController;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.util.ExtensionFileFilter;
import gate.util.GateException;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang.StringEscapeUtils;

/**
 * @author Bc. Herbert Waage
 */
public class ReviewEvaluatorClient {

    // corpus pipeline
    private static ConditionalSerialAnalyserController trainPipeline = null;

    // corpus pipeline
    private static ConditionalSerialAnalyserController testPipeline = null;

    // whether the GATE is initialised
    private static boolean isInitilised = false;

    private ProcessingResource documentResetPR = null;
    private ProcessingResource japeTransducerPR = null;
    private ProcessingResource annotationSetTransferPR = null;
    private ProcessingResource tokenizerPR = null;
    private ProcessingResource sentenceSplitterPR = null;
    private ProcessingResource POSTaggerPR = null;
    private ProcessingResource morphologicalAnalyserPR = null;
    private ProcessingResource trainBatchLearningPR = null;
    private ProcessingResource testBatchLearningPR = null;

    private ReviewEvaluatorClient() {
        initialise();
    }
    
    public static ReviewEvaluatorClient getInstance() {
        return ReviewEvaluatorClientHolder.INSTANCE;
    }
    
    private static class ReviewEvaluatorClientHolder {
        private static final ReviewEvaluatorClient INSTANCE = new ReviewEvaluatorClient();
    }

    private void cleanup() {
        deleteResource(documentResetPR);
        deleteResource(japeTransducerPR);
        deleteResource(annotationSetTransferPR);
        deleteResource(tokenizerPR);
        deleteResource(sentenceSplitterPR);
        deleteResource(POSTaggerPR);
        deleteResource(morphologicalAnalyserPR);
        deleteResource(trainBatchLearningPR);
        deleteResource(testBatchLearningPR);
        deleteResource(trainPipeline);
        deleteResource(testPipeline);
    }

    private void deleteResource(Resource PR) {
        if (PR != null) {
            Factory.deleteResource(PR);
            PR = null;
        }
    }

    /**
     *
     * @param review
     * @return rating
     */
    public synchronized Score test(String review) {
        try {
            Document document = Factory.newDocument("<?xml version='1.0' encoding='UTF-8'?>\n"
                    + "<GateDocument>\n"
                    + "<!-- The document's features-->\n"
                    + "<GateDocumentFeatures>\n"
                    + "<Feature>\n"
                    + "  <Name className=\"java.lang.String\">MimeType</Name>\n"
                    + "  <Value className=\"java.lang.String\">text/html</Value>\n"
                    + "</Feature>\n"
                    + "</GateDocumentFeatures>\n"
                    + "<!-- The document content area with serialized nodes -->\n"
                    + "<TextWithNodes>\n"
                    + "<Node id=\"0\" />"
                    + StringEscapeUtils.escapeXml(review)
                    + "<Node id=\"1\" />"
                    + "</TextWithNodes>\n"
                    + "<!-- Named annotation set -->\n"
                    + "<AnnotationSet Name=\"Key\">\n"
                    + "<Annotation Id=\"0\" Type=\"comment\" StartNode=\"0\" EndNode=\"1\">\n"
                    + "  <Feature>\n"
                    + "    <Name className=\"java.lang.String\">rating</Name>\n"
                    + "    <Value className=\"java.lang.String\">undefined</Value>\n"
                    + "  </Feature>\n"
                    + "</Annotation>"
                    + "</AnnotationSet>\n"
                    + "</GateDocument>");
            Corpus corpus = Factory.newCorpus("Test corpus");
            corpus.add(document);
            testPipeline.setCorpus(corpus);

            System.out.println("running test pipeline...");
            testPipeline.execute();

            for (Document doc : corpus) {
                AnnotationSet output = doc.getNamedAnnotationSets().get("Output");
                FeatureMap featureMap = null;
                AnnotationSet annSetOutputs = output.get("comment", featureMap);
                ArrayList outputsAnnotations = new ArrayList(annSetOutputs);
                for (Object outputsAnnotation : outputsAnnotations) {
                    Annotation outputToken = (Annotation) outputsAnnotation;
                    return new Score(
                            Integer.parseInt((String) outputToken.getFeatures().get("rating")),
                            (float) outputToken.getFeatures().get("prob") * 100);
                }
            }
        } catch (ResourceInstantiationException | ExecutionException | NumberFormatException ex) {
            Logger.getLogger(ReviewEvaluatorClient.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new Score(-1, -1);
    }

    public synchronized void train() {
        try {
            System.out.println("populating corpus...");
            Corpus trainCorpus = Factory.newCorpus("Train corpus");
            File directory = new File("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\filesAndOutputs\\train_1000");
            ExtensionFileFilter filter = new ExtensionFileFilter("XML files", "xml");
            URL url = directory.toURI().toURL();
            trainCorpus.populate(url, filter, null, false);

            trainPipeline.setCorpus(trainCorpus);

            System.out.println("running train pipeline...");
            trainPipeline.execute();

            System.out.println("Training done!");
        } catch (ResourceInstantiationException | IOException | ExecutionException ex) {
            Logger.getLogger(ReviewEvaluatorClient.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private synchronized void initialise() {
        if (!isInitilised) {
            try {
                initialiseGate();
                initialiseResources();
                initialisePipelines();
                isInitilised = true;
            } catch (GateException | MalformedURLException ex) {
                System.out.println("Initialisation has failed!");
                Logger.getLogger(ReviewEvaluatorClient.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void initialiseGate() throws GateException, MalformedURLException {
        System.out.println("initializing GATE...");
        File gateHomeFile = new File("C:\\Program Files\\GATE_Developer_8.1");
        Gate.setGateHome(gateHomeFile);
        File pluginsHome = new File("C:\\Program Files\\GATE_Developer_8.1\\plugins");
        Gate.setPluginsHome(pluginsHome);
        // set user config file (optional)
        // Gate.setUserConfigFile(new File("/Applications/GATE_Developer_7.0", "user.xml"));
        Gate.init();
        // load plugins
        CreoleRegister register = Gate.getCreoleRegister();
        URL annieHome = new File(pluginsHome, "ANNIE").toURI().toURL();
        register.registerDirectories(annieHome);
        URL toolsHome = new File(pluginsHome, "Tools").toURI().toURL();
        register.registerDirectories(toolsHome);
        URL learningHome = new File(pluginsHome, "Learning").toURI().toURL();
        register.registerDirectories(learningHome);
    }

    private void initialiseResources() throws ResourceInstantiationException, MalformedURLException {
        System.out.println("initializing PR...");

        // document reset
        FeatureMap documentResetPRfeatureMap = Factory.newFeatureMap();
        ArrayList<String> setsToKeep = new ArrayList<>();
        setsToKeep.add("Key");
        documentResetPRfeatureMap.put("setsToKeep", setsToKeep);
        documentResetPR = (ProcessingResource) Factory.createResource("gate.creole.annotdelete.AnnotationDeletePR", documentResetPRfeatureMap);

        // annotation set transfer
        FeatureMap annotationSetTransferPRfeatureMap = Factory.newFeatureMap();
        ArrayList<String> annotationTypes = new ArrayList<>();
        annotationTypes.add("comment");
        annotationSetTransferPRfeatureMap.put("annotationTypes", annotationTypes);
        annotationSetTransferPRfeatureMap.put("copyAnnotations", true);
        annotationSetTransferPRfeatureMap.put("inputASName", "Key");
        annotationSetTransferPRfeatureMap.put("outputASName", "");
        annotationSetTransferPRfeatureMap.put("tagASName", "");
        annotationSetTransferPRfeatureMap.put("textTagName", "");
        annotationSetTransferPR = (ProcessingResource) Factory.createResource("gate.creole.annotransfer.AnnotationSetTransfer", annotationSetTransferPRfeatureMap);

        // transducer
        File japeOrigFile = new File("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\filesAndOutputs\\copy_comment_spans.jape");
        java.net.URI japeURI = japeOrigFile.toURI();
        FeatureMap japeTransducerPRFeatureMap = Factory.newFeatureMap();
        japeTransducerPRFeatureMap.put("grammarURL", japeURI.toURL());
        japeTransducerPRFeatureMap.put("encoding", "UTF-8");
        japeTransducerPRFeatureMap.put("inputASName", "Key");
        japeTransducerPRFeatureMap.put("outputASName", "");
        japeTransducerPR = (ProcessingResource) Factory.createResource("gate.creole.Transducer", japeTransducerPRFeatureMap);

        // english tokeniser
        tokenizerPR = (ProcessingResource) Factory.createResource("gate.creole.tokeniser.DefaultTokeniser");

        // sentence splitter
        sentenceSplitterPR = (ProcessingResource) Factory.createResource("gate.creole.splitter.SentenceSplitter");

        // POSTagger
        POSTaggerPR = (ProcessingResource) Factory.createResource("gate.creole.POSTagger");

        // morphological analyser
        morphologicalAnalyserPR = (ProcessingResource) Factory.createResource("gate.creole.morph.Morph");

        // train batch learning
        FeatureMap trainBatchLearningPRfeatureMap = Factory.newFeatureMap();
        URL trainBatchLearningPRconfigFileURL = new File("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\filesAndOutputs\\paum.xml").toURI().toURL();
        trainBatchLearningPRfeatureMap.put("configFileURL", trainBatchLearningPRconfigFileURL);
        trainBatchLearningPRfeatureMap.put("inputASName", "");
        trainBatchLearningPRfeatureMap.put("outputASName", "");
        trainBatchLearningPRfeatureMap.put("learningMode", "TRAINING");
        trainBatchLearningPR = (ProcessingResource) Factory.createResource("gate.learning.LearningAPIMain", trainBatchLearningPRfeatureMap);

        // train batch learning
        FeatureMap testBatchLearningPRfeatureMap = Factory.newFeatureMap();
        URL testBatchLearningPRconfigFileURL = new File("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\filesAndOutputs\\paum.xml").toURI().toURL();
        testBatchLearningPRfeatureMap.put("configFileURL", testBatchLearningPRconfigFileURL);
        testBatchLearningPRfeatureMap.put("inputASName", "");
        testBatchLearningPRfeatureMap.put("outputASName", "Output");
        testBatchLearningPRfeatureMap.put("learningMode", "APPLICATION");
        testBatchLearningPR = (ProcessingResource) Factory.createResource("gate.learning.LearningAPIMain", testBatchLearningPRfeatureMap);
    }

    private void initialisePipelines() throws ResourceInstantiationException {
        // train pipeline
        trainPipeline = (ConditionalSerialAnalyserController) Factory.createResource("gate.creole.ConditionalSerialAnalyserController");
        trainPipeline.add(documentResetPR);
        //trainPipeline.add(japeTransducerPR);
        trainPipeline.add(annotationSetTransferPR);
        trainPipeline.add(tokenizerPR);
        trainPipeline.add(sentenceSplitterPR);
        trainPipeline.add(POSTaggerPR);
        trainPipeline.add(morphologicalAnalyserPR);
        trainPipeline.add(trainBatchLearningPR);
        //trainPipeline.add(testBatchLearningPR);

        // test pipeline
        testPipeline = (ConditionalSerialAnalyserController) Factory.createResource("gate.creole.ConditionalSerialAnalyserController");
        testPipeline.add(documentResetPR);
        testPipeline.add(japeTransducerPR);
        //testPipeline.add(annotationSetTransferPR);
        testPipeline.add(tokenizerPR);
        testPipeline.add(sentenceSplitterPR);
        testPipeline.add(POSTaggerPR);
        testPipeline.add(morphologicalAnalyserPR);
        //testPipeline.add(trainBatchLearningPR);
        testPipeline.add(testBatchLearningPR);
    }
}
