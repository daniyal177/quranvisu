import fs from "fs";
import path from "path";

const SURAH_DIR = path.join(process.cwd(), "public", "surahs");
const OUT_FILE  = path.join(process.cwd(), "public", "surah-index.json");

function safeReadJSON(p) {
  try {
    return JSON.parse(fs.readFileSync(p, "utf8"));
  } catch {
    return null;
  }
}

if (!fs.existsSync(SURAH_DIR)) {
  console.error(`❌ Missing folder: ${SURAH_DIR}`);
  process.exit(1);
}

const files = fs.readdirSync(SURAH_DIR)
  .filter(f => f.toLowerCase().endsWith(".json"))
  .sort((a,b) => a.localeCompare(b, undefined, {numeric:true, sensitivity:"base"}));

const surahs = files.map(file => {
  const full = path.join(SURAH_DIR, file);
  const json = safeReadJSON(full) || {};
  const meta = (json && typeof json === "object" && json.meta && typeof json.meta === "object") ? json.meta : {};
  const title = meta.surah || file.replace(/\.json$/i, "");
  const audio = meta.audio_url || "";
  const segmentsCount = Array.isArray(json.segments) ? json.segments.length : 0;

  return {
    title,
    file: `/surahs/${file}`,
    audio,
    segments: segmentsCount
  };
});

const out = {
  generated_at: new Date().toISOString(),
  surahs
};

fs.writeFileSync(OUT_FILE, JSON.stringify(out, null, 2), "utf8");
console.log(`✅ Wrote ${OUT_FILE} with ${surahs.length} surahs`);
