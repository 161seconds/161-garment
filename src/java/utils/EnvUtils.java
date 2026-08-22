package utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
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
                System.getProperty("user.dir") + File.separator + ".env",
                System.getProperty("catalina.base") + File.separator + ".env"
            };

            File envFile = null;
            for (String path : possiblePaths) {
                if (path == null) continue;
                File f = new File(path);
                if (f.exists() && f.isFile()) {
                    envFile = f;
                    break;
                }
            }

            // Also check class protection domain location (inside war/webroot)
            if (envFile == null) {
                try {
                    File classDir = new File(EnvUtils.class.getProtectionDomain().getCodeSource().getLocation().toURI());
                    // classDir is WEB-INF/classes/utils or similar, traverse up
                    File current = classDir;
                    for (int i = 0; i < 5 && current != null; i++) {
                        File candidate = new File(current, ".env");
                        if (candidate.exists() && candidate.isFile()) {
                            envFile = candidate;
                            break;
                        }
                        File webInfCandidate = new File(current, "WEB-INF" + File.separator + ".env");
                        if (webInfCandidate.exists() && webInfCandidate.isFile()) {
                            envFile = webInfCandidate;
                            break;
                        }
                        current = current.getParentFile();
                    }
                } catch (Exception ignored) {}
            }

            if (envFile != null) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(envFile), StandardCharsets.UTF_8))) {
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
