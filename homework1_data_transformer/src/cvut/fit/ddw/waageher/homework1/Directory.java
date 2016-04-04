package cvut.fit.ddw.waageher.homework1;

import java.io.File;
import java.util.Iterator;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author waageher
 */
public class Directory {

    private String directory;
    private Iterator it;

    public Directory(String directoryString) {
        directory = directoryString;
        System.out.println("Loading directory " + directory);
        it = FileUtils.iterateFiles(new File(directory), null, false);
    }

    public File getFile() {
        if (it.hasNext()) {
            return (File) it.next();
        }
        return null;
    }
    
    public boolean hasNext() {
        return it.hasNext();
    }

    public void resetIterator() {
        it = FileUtils.iterateFiles(new File(directory), null, false);
    }
}
