-- Add vulnerability assessment columns to targets table
ALTER TABLE targets ADD COLUMN IF NOT EXISTS vuln_composite integer DEFAULT 0;
ALTER TABLE targets ADD COLUMN IF NOT EXISTS vuln_top_vectors text;
