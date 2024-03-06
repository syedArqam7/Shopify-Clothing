public class Products {

    private int productID,categoryID,brandID,sizeID;
    private String productName,productDescription,availabilityStatus, image;
    private double price;
    public Products() {}

    public Products(int productID, String productName, String productDescription, double price,
                   int categoryID, int brandID, int sizeID, String availabilityStatus, String image) {
        this.productID = productID;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.categoryID = categoryID;
        this.brandID = brandID;
        this.sizeID = sizeID;
        this.availabilityStatus = availabilityStatus;
        this.image = image;
    }

    public Products(int productID, String productName, double price, String image) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.image = image;
    }

    // Getters and setters

    public int getProductID() {
        return productID;
    }
    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDescription() {
        return productDescription;
    }
    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public int getCategoryID() {
        return categoryID;
    }
    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }
    public int getBrandID() {
        return brandID;
    }
    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }
    public int getSizeID() {
        return sizeID;
    }
    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }
    public String getAvailabilityStatus() {
        return availabilityStatus;
    }
    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
}
