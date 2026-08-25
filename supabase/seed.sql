-- ReState demo data — run after schema.sql.
-- Safe to re-run: truncates the catalog tables before inserting.
-- Deterministic UUIDs keep cross-references readable (hex chars only).

begin;

truncate public.reviews, public.galleries, public.properties, public.agents cascade;

-- ============ Agents ============

insert into public.agents (id, name, avatar, email, phone) values
  ('a0000000-0000-4000-8000-000000000001', 'Sophie Moore',
   'https://api.dicebear.com/9.x/initials/png?seed=Sophie%20Moore&backgroundColor=0061FF',
   'sophie@restate.app', '+1 (555) 010-0001'),
  ('a0000000-0000-4000-8000-000000000002', 'Matt Cooper',
   'https://api.dicebear.com/9.x/initials/png?seed=Matt%20Cooper&backgroundColor=191D31',
   'matt@restate.app', '+1 (555) 010-0002'),
  ('a0000000-0000-4000-8000-000000000003', 'Caroline Lang',
   'https://api.dicebear.com/9.x/initials/png?seed=Caroline%20Lang&backgroundColor=F75555',
   'caroline@restate.app', '+1 (555) 010-0003'),
  ('a0000000-0000-4000-8000-000000000004', 'Omar Hassan',
   'https://api.dicebear.com/9.x/initials/png?seed=Omar%20Hassan&backgroundColor=666876',
   'omar@restate.app', '+1 (555) 010-0004');

-- ============ Properties ============

insert into public.properties (id, name, address, type, price, area, bedrooms, bathrooms, rating, image, description) values
  ('b0000000-0000-4000-8000-000000000001', 'Willow Creek House',
   '132 Willow Creek Rd, Portland, OR 97205', 'House', 485000, 2100, 4, 3, 4.8,
   'https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=900&q=60',
   'A charming craftsman house with a covered porch, open-plan living area, and a fenced backyard perfect for families.'),
  ('b0000000-0000-4000-8000-000000000002', 'Maple Grove Residence',
   '88 Maple Grove Ave, Austin, TX 78701', 'House', 612000, 2450, 5, 4, 4.6,
   'https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=900&q=60',
   'Spacious two-story home with a modern kitchen, home office nook, and a large patio with mature oak trees.'),
  ('b0000000-0000-4000-8000-000000000003', 'Sunset Ridge Villa',
   '7 Sunset Ridge Dr, Los Angeles, CA 90210', 'Villa', 1450000, 4200, 6, 5, 4.9,
   'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=900&q=60',
   'Luxury hillside villa with an infinity pool, floor-to-ceiling glass walls, and panoramic city-to-ocean views.'),
  ('b0000000-0000-4000-8000-000000000004', 'Palm Court Villa',
   '21 Palm Ct, Miami, FL 33139', 'Villa', 1180000, 3800, 5, 4, 4.7,
   'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?auto=format&fit=crop&w=900&q=60',
   'Mediterranean-style villa with a resort-style pool deck, summer kitchen, and private dock access.'),
  ('b0000000-0000-4000-8000-000000000005', 'Downtown Loft 4B',
   '401 Main St Apt 4B, Seattle, WA 98104', 'Apartments', 389000, 1100, 2, 2, 4.3,
   'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=900&q=60',
   'Bright industrial loft with exposed brick, quartz counters, and skyline views from every window.'),
  ('b0000000-0000-4000-8000-000000000006', 'Riverside Flat',
   '18 Riverside Walk Apt 12, Chicago, IL 60606', 'Apartments', 275000, 950, 2, 1, 4.1,
   'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=900&q=60',
   'Cozy riverside flat steps from the Loop with hardwood floors, updated bath, and shared rooftop terrace.'),
  ('b0000000-0000-4000-8000-000000000007', 'Skyline Condo 2208',
   '500 Harbor Blvd Unit 2208, San Diego, CA 92101', 'Condos', 452000, 1250, 2, 2, 4.5,
   'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?auto=format&fit=crop&w=900&q=60',
   'High-floor condo with wraparound balcony, concierge service, gym, and direct bay views.'),
  ('b0000000-0000-4000-8000-000000000008', 'Oakwood Duplex',
   '76 Oakwood Ln, Denver, CO 80209', 'Duplexes', 534000, 1900, 4, 3, 4.2,
   'https://images.unsplash.com/photo-1449844908441-8829872d2607?auto=format&fit=crop&w=900&q=60',
   'Well-maintained duplex with separate entrances, ideal for owner-occupants or investors seeking rental income.'),
  ('b0000000-0000-4000-8000-000000000009', 'Cedar Park Townhome',
   '2331 Cedar Park Way, Phoenix, AZ 85016', 'Townhomes', 368000, 1650, 3, 2, 4.4,
   'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=900&q=60',
   'End-unit townhome with a private garage, low-maintenance courtyard, and community pool.'),
  ('b0000000-0000-4000-8000-000000000010', 'Midtown Studio 9A',
   '310 W 38th St Apt 9A, New York, NY 10018', 'Studios', 315000, 520, 1, 1, 4.0,
   'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=900&q=60',
   'Efficient Midtown studio with custom storage wall, chef-style kitchenette, and doorman building amenities.'),
  ('b0000000-0000-4000-8000-000000000011', 'Lakeside Modern House',
   '9 Lakeshore Dr, Madison, WI 53703', 'House', 720000, 2800, 4, 3, 4.7,
   'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=900&q=60',
   'Architect-designed modern house on the lake with a floating staircase, smart-home system, and boathouse.'),
  ('b0000000-0000-4000-8000-000000000012', 'Garden Terrace Apartment',
   '52 Garden Terrace Apt 3, Boston, MA 02116', 'Apartments', 425000, 1050, 2, 2, 4.5,
   'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=900&q=60',
   'South-facing apartment overlooking a private garden square, minutes from the waterfront promenade.');

-- ============ Galleries ============

insert into public.galleries (property_id, image) values
  ('b0000000-0000-4000-8000-000000000001', 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000001', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000001', 'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000002', 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000002', 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000002', 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000003', 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000003', 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000003', 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000004', 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000004', 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000004', 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000005', 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000005', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000005', 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000006', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000006', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000006', 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000007', 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000007', 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000007', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000008', 'https://images.unsplash.com/photo-1449844908441-8829872d2607?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000008', 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000008', 'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000009', 'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000009', 'https://images.unsplash.com/photo-1449844908441-8829872d2607?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000009', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000010', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000010', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000010', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000011', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000011', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000011', 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000012', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000012', 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=1200&q=60'),
  ('b0000000-0000-4000-8000-000000000012', 'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=1200&q=60');

-- ============ Reviews ============

insert into public.reviews (id, property_id, agent_id, review, rating, date) values
  ('c0000000-0000-4000-8000-000000000001', 'b0000000-0000-4000-8000-000000000001', 'a0000000-0000-4000-8000-000000000001',
   'The backyard sold us instantly. Sophie walked us through every detail of the inspection.', 5.0, '2025-11-02'),
  ('c0000000-0000-4000-8000-000000000002', 'b0000000-0000-4000-8000-000000000002', 'a0000000-0000-4000-8000-000000000002',
   'Great school district nearby. Negotiation went smoother than we expected.', 4.5, '2025-12-14'),
  ('c0000000-0000-4000-8000-000000000003', 'b0000000-0000-4000-8000-000000000003', 'a0000000-0000-4000-8000-000000000001',
   'Views are unreal at sunset. Pool maintenance contract transfers with the sale.', 5.0, '2026-01-08'),
  ('c0000000-0000-4000-8000-000000000004', 'b0000000-0000-4000-8000-000000000005', 'a0000000-0000-4000-8000-000000000003',
   'Perfect starter loft. Street parking is competitive but the garage spot helps.', 4.0, '2026-02-21'),
  ('c0000000-0000-4000-8000-000000000005', 'b0000000-0000-4000-8000-000000000007', 'a0000000-0000-4000-8000-000000000004',
   'HOA is responsive and the amenities are exactly as listed.', 4.5, '2026-03-15'),
  ('c0000000-0000-4000-8000-000000000006', 'b0000000-0000-4000-8000-000000000008', 'a0000000-0000-4000-8000-000000000002',
   'Rented both units within three weeks. Solid investment math.', 4.0, '2026-04-30'),
  ('c0000000-0000-4000-8000-000000000007', 'b0000000-0000-4000-8000-000000000009', 'a0000000-0000-4000-8000-000000000004',
   'Quiet complex, friendly neighbors, and the end-unit windows make a big difference.', 4.5, '2026-05-19'),
  ('c0000000-0000-4000-8000-000000000008', 'b0000000-0000-4000-8000-000000000010', 'a0000000-0000-4000-8000-000000000003',
   'Tiny but brilliantly laid out. The storage wall fits more than you would think.', 4.0, '2026-06-07'),
  ('c0000000-0000-4000-8000-000000000009', 'b0000000-0000-4000-8000-000000000011', 'a0000000-0000-4000-8000-000000000001',
   'Waking up to lake views never gets old. Smart home controls are genuinely useful.', 4.8, '2026-07-12');

commit;
