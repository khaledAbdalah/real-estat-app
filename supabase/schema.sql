-- ReState schema — run once in the Supabase SQL Editor.

create extension if not exists "pgcrypto";

-- ============ Tables ============

create table public.agents (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  avatar text not null,
  email text,
  phone text
);

create table public.properties (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  address text not null,
  type text not null check (
    type in ('House', 'Condos', 'Duplexes', 'Studios', 'Villa', 'Apartments', 'Townhomes', 'Others')
  ),
  price numeric(12, 2) not null check (price >= 0),
  area integer not null check (area > 0),
  bedrooms smallint not null check (bedrooms >= 0),
  bathrooms smallint not null check (bathrooms >= 0),
  rating numeric(2, 1) not null default 0 check (rating between 0 and 5),
  image text not null,
  description text,
  facilities text[] not null default '{}',
  agent_id uuid references public.agents (id) on delete restrict,
  created_at timestamptz not null default now()
);

create table public.reviews (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references public.properties (id) on delete cascade,
  agent_id uuid not null references public.agents (id) on delete restrict,
  review text not null,
  rating numeric(2, 1) not null check (rating between 0 and 5),
  date date not null default current_date
);

create table public.galleries (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references public.properties (id) on delete cascade,
  image text not null
);

-- ============ Indexes ============

create index properties_created_at_idx on public.properties (created_at desc);
create index properties_type_idx on public.properties (type);
create index properties_agent_id_idx on public.properties (agent_id);
create index galleries_property_id_idx on public.galleries (property_id);
create index reviews_property_id_idx on public.reviews (property_id);
create index reviews_agent_id_idx on public.reviews (agent_id);

-- ============ Row Level Security ============
-- Catalog data is publicly readable; writes stay closed until a future
-- feature needs authenticated inserts (then add scoped policies).

alter table public.properties enable row level security;
alter table public.agents enable row level security;
alter table public.reviews enable row level security;
alter table public.galleries enable row level security;

create policy "Anyone can read properties"
  on public.properties for select
  to anon, authenticated
  using (true);

create policy "Anyone can read agents"
  on public.agents for select
  to anon, authenticated
  using (true);

create policy "Anyone can read reviews"
  on public.reviews for select
  to anon, authenticated
  using (true);

create policy "Anyone can read galleries"
  on public.galleries for select
  to anon, authenticated
  using (true);
