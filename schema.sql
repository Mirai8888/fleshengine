-- FLESHENGINE Supabase Schema
-- Run this in your Supabase SQL Editor

-- Targets table
CREATE TABLE targets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  handle TEXT NOT NULL UNIQUE,
  display_handle TEXT,
  status TEXT DEFAULT 'queued' CHECK (status IN ('queued', 'scanning', 'active', 'archived')),
  threat_score INTEGER CHECK (threat_score >= 0 AND threat_score <= 100),
  top_vectors TEXT,
  fragment_count INTEGER DEFAULT 0,
  contributor_count INTEGER DEFAULT 0,
  -- Vulnerability scores (FE-001 through FE-012)
  fe_001 INTEGER DEFAULT 0, -- Narrative Framing
  fe_002 INTEGER DEFAULT 0, -- Repetition Saturation
  fe_003 INTEGER DEFAULT 0, -- Audience Conditioning
  fe_004 INTEGER DEFAULT 0, -- Loyalty Exploitation
  fe_005 INTEGER DEFAULT 0, -- Identity Manipulation
  fe_006 INTEGER DEFAULT 0, -- Manufactured Consensus
  fe_007 INTEGER DEFAULT 0, -- Viral Propagation
  fe_008 INTEGER DEFAULT 0, -- Urgency Fabrication
  fe_009 INTEGER DEFAULT 0, -- Attention Redirection
  fe_010 INTEGER DEFAULT 0, -- Reality Distortion
  fe_011 INTEGER DEFAULT 0, -- Cognitive Overload
  fe_012 INTEGER DEFAULT 0, -- Existential Threat Framing
  -- Communication style weights
  comm_analytical REAL DEFAULT 0,
  comm_passionate REAL DEFAULT 0,
  comm_technical REAL DEFAULT 0,
  comm_contrarian REAL DEFAULT 0,
  comm_nurturing REAL DEFAULT 0,
  comm_authoritative REAL DEFAULT 0,
  comm_ironic REAL DEFAULT 0,
  -- Network metrics
  network_community TEXT,
  network_pagerank REAL,
  network_betweenness REAL,
  network_in_degree INTEGER,
  network_out_degree INTEGER,
  network_bridge_status TEXT,
  -- Assessment
  assessment TEXT,
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  first_scan_at TIMESTAMPTZ,
  last_scan_at TIMESTAMPTZ
);

-- Fragments table (human observations)
CREATE TABLE fragments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  target_id UUID REFERENCES targets(id) ON DELETE CASCADE,
  target_handle TEXT NOT NULL,
  contributor_id TEXT NOT NULL DEFAULT 'anon',
  observation_type TEXT NOT NULL CHECK (observation_type IN (
    'behavioral_pattern', 'relationship_dynamic', 'narrative_shift',
    'tone_analysis', 'network_activity', 'other'
  )),
  body TEXT NOT NULL CHECK (char_length(body) <= 1000),
  evidence_url TEXT,
  timeframe TEXT,
  confidence TEXT DEFAULT 'medium' CHECK (confidence IN ('low', 'medium', 'high')),
  validated BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Contributors table (anonymous tracking)
CREATE TABLE contributors (
  id TEXT PRIMARY KEY DEFAULT 'anon_' || substr(gen_random_uuid()::text, 1, 8),
  fragment_count INTEGER DEFAULT 0,
  accuracy_score REAL DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  last_active TIMESTAMPTZ DEFAULT now()
);

-- Indexes
CREATE INDEX idx_targets_handle ON targets(handle);
CREATE INDEX idx_targets_status ON targets(status);
CREATE INDEX idx_targets_threat_score ON targets(threat_score DESC);
CREATE INDEX idx_targets_created ON targets(created_at DESC);
CREATE INDEX idx_fragments_target ON fragments(target_id);
CREATE INDEX idx_fragments_target_handle ON fragments(target_handle);
CREATE INDEX idx_fragments_created ON fragments(created_at DESC);
CREATE INDEX idx_fragments_contributor ON fragments(contributor_id);

-- Auto-update fragment count on target
CREATE OR REPLACE FUNCTION update_target_fragment_count()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE targets
  SET fragment_count = (SELECT COUNT(*) FROM fragments WHERE target_id = NEW.target_id),
      updated_at = now()
  WHERE id = NEW.target_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_fragment_count
AFTER INSERT ON fragments
FOR EACH ROW EXECUTE FUNCTION update_target_fragment_count();

-- Row Level Security
ALTER TABLE targets ENABLE ROW LEVEL SECURITY;
ALTER TABLE fragments ENABLE ROW LEVEL SECURITY;
ALTER TABLE contributors ENABLE ROW LEVEL SECURITY;

-- Public read access
CREATE POLICY "Anyone can read targets" ON targets FOR SELECT USING (true);
CREATE POLICY "Anyone can read fragments" ON fragments FOR SELECT USING (true);

-- Public insert (submissions)
CREATE POLICY "Anyone can submit targets" ON targets FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can submit fragments" ON fragments FOR INSERT WITH CHECK (true);

-- No public update/delete
-- (admin access via service_role key only)
