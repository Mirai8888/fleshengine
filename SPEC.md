# FLESHENGINE — Distributed Cognitive Profiling Platform
## Seithar Group Intelligence Division

---

## CONCEPT

人肉搜索 (human flesh search engine) reimagined as a structured cognitive profiling instrument. Crowdsourced intelligence collection where distributed human observers contribute behavioral fragments that assemble into composite cognitive profiles.

Not doxing. Not harassment. Cognitive cartography at population scale.

The shock value is the name. The working tool is the substance. Both are the weapon.

## CORE LOOP

1. **TARGET SUBMISSION** — anyone can submit a public account/entity for analysis
2. **AUTOMATED SCAN** — HoleSpawn runs initial profile (public data, communication patterns, network position)
3. **DISTRIBUTED COLLECTION** — community contributes structured observations (behavioral fragments, relationship dynamics, tone shifts, narrative patterns)
4. **AGGREGATION** — system assembles fragments into composite cognitive profile with SCT vulnerability mapping
5. **OUTPUT** — structured intelligence brief, network position map, cognitive vulnerability surface, suggested engagement vectors

## SITE STRUCTURE

### Landing Page
- Title: FLESHENGINE (or 人肉搜索)
- Subtitle: "distributed cognitive profiling"
- Single input field: "SUBMIT TARGET" (accepts Twitter/X handle, URL, or name)
- Below: live feed of recent analyses (anonymized or public, depending on policy)
- Seithar.com style: white, monochromatic, system sans-serif, weight 300, wide letter-spacing

### Target Page (per-target)
- Automated profile summary (HoleSpawn output)
- SCT vulnerability surface map (radar chart)
- Communication style analysis
- Network position (community membership, bridge status)
- **CONTRIBUTE** section: structured form for human observations
- Timeline of contributed intelligence fragments
- Composite confidence score (automated + human observations weighted)

### Contribution Form
Structured fields:
- **Observation type**: behavioral pattern / relationship dynamic / narrative shift / tone analysis / network activity / other
- **Description**: free text (500 char max)
- **Evidence**: link to specific post/content (optional)
- **Timeframe**: when was this observed
- **Confidence**: low / medium / high

### Leaderboard / Contributors
- Anonymous contributor IDs
- Contribution count, accuracy score (validated by subsequent observations)
- Gamification without identity exposure

### Live Scanner
- Embed the SCT scanner: paste any URL or text, get instant SCT analysis
- Results feed into the platform's aggregate intelligence

## TECHNICAL ARCHITECTURE

### Frontend
- Static site (HTML/CSS/JS), seithar.com aesthetic
- No framework dependencies, loads instantly
- Client-side SCT scanning (reuse scanner code)
- API calls to backend for submissions/retrieval

### Backend Options (in order of feasibility)
1. **GitHub Issues as database** — each target is an issue, contributions are comments, labels for SCT codes. Free, public, crawlable, zero infrastructure. Ugly but functional.
2. **Supabase** — free tier, PostgreSQL, real-time subscriptions, auth. More polished.
3. **Simple JSON API on GitHub Pages** — static JSON files updated by GitHub Actions. Zero cost, read-only public access.
4. **Self-hosted** — if Director provides compute.

### Integration with HoleSpawn
- HoleSpawn's `profile/analyzer.py` generates initial automated profile
- HoleSpawn's `scraper/graphql.py` pulls network data
- HoleSpawn's `sct/mapper.py` maps vulnerability surface
- FLESHENGINE adds the human intelligence layer on top

### Data Flow
```
Target Submitted
    ↓
HoleSpawn Automated Scan (async)
    ↓
Initial Profile Published to Target Page
    ↓
Community Contributes Observations
    ↓
Aggregation Engine Weights + Merges
    ↓
Composite Profile Updated (continuous)
    ↓
Intelligence Brief Generated
```

## CONTENT FRAMING

The site copy must be clinical. Not edgy for edge's sake. The provocation is structural: the tool exists, it works, and the name is what it is.

Key copy:
- "Distributed cognitive profiling for the open internet"
- "Every public account is a readable substrate"
- "The crowd sees what the algorithm misses"
- "人肉搜索 — human-powered intelligence at machine scale"

## WHAT MAKES THIS DIFFERENT FROM DOXING TOOLS

1. **Cognitive, not personal** — we map communication patterns, narrative vulnerabilities, and network position. Not home addresses.
2. **Structured taxonomy** — SCT codes, not free-form harassment
3. **Bidirectional** — you can scan yourself to see your own vulnerability surface
4. **Defensive framing** — understanding how you can be manipulated is cognitive self-defense

## LAUNCH STRATEGY

1. Build MVP site with static frontend + GitHub Issues backend
2. Seed with 5-10 pre-built profiles (public figures, already analyzed)
3. Post to Hacker News as "Show HN: Human flesh search engine for cognitive profiling"
4. Cross-post to Moltbook, Discord
5. The Wikipedia article for 人肉搜索 does the contextual marketing for free

## REPO

New repo: `github.com/Mirai8888/fleshengine`
Standalone. Links to HoleSpawn for analysis, seithar-cogdef for SCT scanning.

---

```
Seithar Group Intelligence Division
認知作戦 | seithar.com
```
