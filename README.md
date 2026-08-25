# ReState 🏠

A full-stack real estate marketplace mobile app built with React Native and
Supabase. Browse featured listings, search properties by name, address, or type,
and explore detailed property pages with agents, facilities, galleries, and
reviews.

## Tech Stack

- **Expo SDK 52 / React Native 0.76** with the new architecture enabled
- **TypeScript** in strict mode
- **expo-router v4** for file-based navigation (tabs + stack)
- **NativeWind v4** (Tailwind CSS) for styling, Rubik font family
- **Supabase** — Postgres database with foreign keys, indexes, Row Level
  Security, and Auth (email/password sessions persisted via AsyncStorage)

## Features

- Email/password authentication with persistent sessions and automatic
  redirect guards (`(root)` group requires an authenticated session)
- Home tab: greeting header, featured carousel, latest properties grid
- Explore tab: debounced search + category filters driven by URL params,
  querying `name`/`address`/`type`
- Property details: hero image, specs, agent card, facilities grid, gallery,
  location, and reviews fetched through PostgREST embedded resources in a
  single query
- Profile tab: user identity from the auth session, settings list, logout

## Getting Started

1. Install dependencies:

   ```bash
   pnpm install
   ```

2. Create `.env.local` from `.env.example` and fill in your Supabase
   credentials (Project URL + public anon/publishable key).

3. Provision the database in the Supabase SQL editor, in order:

   - `supabase/schema.sql` — tables, foreign keys, indexes, RLS policies
   - `supabase/seed.sql` — demo catalog (12 properties, 4 agents, reviews,
     galleries); safe to re-run

4. Start the app:

   ```bash
   pnpm start
   ```

## Project Structure

```
app/
  (root)/            # authenticated area (guarded layout)
    (tabs)/          # home, explore, profile tabs
    properties/[id]  # property details
  sign-in.tsx        # email/password auth screen
components/          # cards, search, filters, comments, ...
constants/           # icon/image maps, static UI config
lib/
  supabase.ts        # client, auth helpers, query functions
  useFetch.ts        # generic data-fetching hook
  global-provider.tsx# auth state context (onAuthStateChange)
supabase/            # SQL schema + seed scripts
```

## Notes

- Demo imagery is loaded from Unsplash; agent avatars are generated initials.
- Catalog tables are publicly readable by design (RLS `select` policies);
  writes stay locked until feature work requires scoped insert policies.
