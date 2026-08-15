package utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class EnvUtils {

    private static final Map<String, String> ENV_CACHE = new HashMap<>();
    private static boolean isLoaded = false;

    static {
        loadEnv();
    }

    private static synchronized void loadEnv() {
        if (isLoaded) return;
        try {
            // Check common paths for .env
            String[] possiblePaths = {
                ".env",
                "../.env",
                "../../.env",
                System.getProperty("user.dir") + File.separator + ".env"
            };

            File envFile = null;
            for (String path : possiblePaths) {
                File f = new File(path);
                if (f.exists() && f.isFile()) {
                    envFile = f;
                    break;
                }
            }

            if (envFile != null) {
                try (BufferedReader reader = new BufferedReader(new FileReader(envFile, StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        line = line.trim();
                        if (line.isEmpty() || line.startsWith("#")) continue;
                        int eqIdx = line.indexOf('=');
                        if (eqIdx > 0) {
                            String key = line.substring(0, eqIdx).trim();
                            String value = line.substring(eqIdx + 1).trim();
                            // Strip quotes if any
                            if ((value.startsWith("\"") && value.endsWith("\"")) ||
                                (value.startsWith("'") && value.endsWith("'"))) {
                                value = value.substring(1, value.length() - 1);
                            }
                            ENV_CACHE.put(key, value);
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[EnvUtils] Could not load .env file: " + e.getMessage());
        } finally {
            isLoaded = true;
        }
    }

    public static String get(String key, String defaultValue) {
        if (!isLoaded) loadEnv();
        String val = ENV_CACHE.get(key);
        if (val != null && !val.isEmpty()) return val;
        String sysEnv = System.getenv(key);
        if (sysEnv != null && !sysEnv.isEmpty()) return sysEnv;
        return defaultValue;
    }

    public static String get(String key) {
        return get(key, null);
    }
}
