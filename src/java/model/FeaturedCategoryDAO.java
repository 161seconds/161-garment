package model;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

public class FeaturedCategoryDAO {

    private static List<FeaturedCategoryDTO> CACHED_ITEMS = null;

    private static List<FeaturedCategoryDTO> getDefaultList() {
        List<FeaturedCategoryDTO> list = new ArrayList<>();
        list.add(new FeaturedCategoryDTO(
            1, 
            "THỜI TRANG NỮ", 
            "Thanh lịch, dịu mát & tôn dáng tối ưu", 
            "BST NỮ 2026", 
            "WOMEN_02", 
            "products/women/cover/cover-outerwear-women-1.avif", 
            true
        ));
        list.add(new FeaturedCategoryDTO(
            2, 
            "THỜI TRANG NAM", 
            "Phóng khoáng, chỉn chu & năng động", 
            "BST NAM 2026", 
            "MEN_02", 
            "products/men/cover/cover-outerwear-men-1.avif", 
            true
        ));
        list.add(new FeaturedCategoryDTO(
            3, 
            "QUẦN BARREL", 
            "Thiết kế phom cong thời thượng", 
            "HOT TREND", 
            "WOMEN_03", 
            "products/women/cover/cover-bottom-women-1.avif", 
            true
        ));
        return list;
    }

    public synchronized List<FeaturedCategoryDTO> getAllFeaturedCategories(ServletContext context) {
        if (CACHED_ITEMS != null) {
            return new ArrayList<>(CACHED_ITEMS);
        }

        List<FeaturedCategoryDTO> list = loadFromFile(context);
        if (list == null || list.isEmpty()) {
            list = getDefaultList();
            saveToFile(context, list);
        }
        CACHED_ITEMS = new ArrayList<>(list);
        return list;
    }

    public synchronized boolean updateFeaturedCategory(ServletContext context, FeaturedCategoryDTO updated) {
        List<FeaturedCategoryDTO> list = getAllFeaturedCategories(context);
        boolean found = false;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getId() == updated.getId()) {
                list.set(i, updated);
                found = true;
                break;
            }
        }
        if (!found) {
            list.add(updated);
        }
        CACHED_ITEMS = new ArrayList<>(list);
        return saveToFile(context, list);
    }

    private List<FeaturedCategoryDTO> loadFromFile(ServletContext context) {
        if (context == null) return null;
        try {
            String path = context.getRealPath("/WEB-INF/featured_categories.txt");
            if (path == null) return null;
            File file = new File(path);
            if (!file.exists()) return null;

            List<FeaturedCategoryDTO> list = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    line = line.trim();
                    if (line.isEmpty() || line.startsWith("#")) continue;
                    // Format: id|title|subtitle|badge|categoryID|image|status
                    String[] parts = line.split("\\|", -1);
                    if (parts.length >= 7) {
                        try {
                            int id = Integer.parseInt(parts[0]);
                            String title = parts[1];
                            String subtitle = parts[2];
                            String badge = parts[3];
                            String categoryID = parts[4];
                            String image = parts[5];
                            boolean status = Boolean.parseBoolean(parts[6]);
                            list.add(new FeaturedCategoryDTO(id, title, subtitle, badge, categoryID, image, status));
                        } catch (NumberFormatException ignored) {}
                    }
                }
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private boolean saveToFile(ServletContext context, List<FeaturedCategoryDTO> list) {
        if (context == null) return false;
        try {
            String deployedPath = context.getRealPath("/WEB-INF/featured_categories.txt");
            if (deployedPath != null) {
                File deployedFile = new File(deployedPath);
                deployedFile.getParentFile().mkdirs();
                writeToFile(deployedFile, list);
            }

            // Also save to source directory if running locally
            try {
                String srcPath = context.getRealPath("").replace("build" + File.separator + "web", "web") 
                        + File.separator + "WEB-INF" + File.separator + "featured_categories.txt";
                File srcFile = new File(srcPath);
                if (srcFile.getParentFile().exists()) {
                    writeToFile(srcFile, list);
                }
            } catch (Exception ignored) {}

            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private void writeToFile(File file, List<FeaturedCategoryDTO> list) throws Exception {
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), StandardCharsets.UTF_8))) {
            writer.write("# ONE61 LifeWear Featured Categories Configuration\n");
            writer.write("# Format: id|title|subtitle|badge|categoryID|image|status\n");
            for (FeaturedCategoryDTO item : list) {
                writer.write(item.getId() + "|"
                        + item.getTitle() + "|"
                        + item.getSubtitle() + "|"
                        + item.getBadge() + "|"
                        + item.getCategoryID() + "|"
                        + item.getImage() + "|"
                        + item.isStatus() + "\n");
            }
        }
    }
}
