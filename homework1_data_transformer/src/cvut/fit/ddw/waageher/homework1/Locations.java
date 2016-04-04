package cvut.fit.ddw.waageher.homework1;

/**
 *
 * @author waageher
 */
public enum Locations {

    positiveTrainDirectoryString("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\aclImdb\\train\\pos"),
    negativeTrainDirectoryString("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\aclImdb\\train\\neg"),
    positiveTestDirectoryString("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\aclImdb\\test\\pos"),
    negativeTestDirectoryString("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\aclImdb\\test\\neg"),
    positiveTrainOutputFileLocation("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\extracted_train_pos.xml"),
    negativeTrainOutputFileLocation("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\extracted_train_neg.xml"),
    positiveTestOutputFileLocation("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\extracted_test_pos.xml"),
    negativeTestOutputFileLocation("C:\\Users\\waage\\Documents\\MI-DDW\\homework1\\myGateExample\\extracted_test_neg.xml");

    private final String value;

    Locations(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
