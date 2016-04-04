package cvut.fit.ddw.waageher.homework1.gate;

/**
 * @author Bc. Herbert Waage
 */
public class Score {

    private final int rating;
    private final float percentage;

    public Score(int rating, float percentage) {
        this.rating = rating;
        this.percentage = percentage;
    }

    public int getRating() {
        return rating;
    }

    public double getPercentage() {
        return percentage;
    }
}
