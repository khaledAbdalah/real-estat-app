import "react-native-url-polyfill/auto";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { createClient } from "@supabase/supabase-js";
import type { Property, PropertyFilters } from "./types";

export const config = {
  url: process.env.EXPO_PUBLIC_SUPABASE_URL,
  anonKey: process.env.EXPO_PUBLIC_SUPABASE_KEY,
};

if (!config.url || !config.anonKey) {
  throw new Error(
    "Missing Supabase configuration. Set EXPO_PUBLIC_SUPABASE_URL and EXPO_PUBLIC_SUPABASE_KEY in .env.local."
  );
}

export const supabase = createClient(config.url, config.anonKey, {
  auth: {
    storage: AsyncStorage,
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: false,
  },
});

export async function getLatestProperties(): Promise<Property[]> {
  const { data, error } = await supabase
    .from("properties")
    .select("*")
    .order("created_at", { ascending: true })
    .limit(5);

  if (error) {
    console.error("getLatestProperties:", error.message);
    return [];
  }

  return data ?? [];
}

export async function getProperties({
  filter,
  query,
  limit,
}: PropertyFilters): Promise<Property[]> {
  let builder = supabase
    .from("properties")
    .select("*")
    .order("created_at", { ascending: false });

  if (filter && filter !== "All") {
    builder = builder.eq("type", filter);
  }

  if (query) {
    const pattern = `%${query.trim()}%`;
    builder = builder.or(
      `name.ilike.${pattern},address.ilike.${pattern},type.ilike.${pattern}`
    );
  }

  if (limit) {
    builder = builder.limit(limit);
  }

  const { data, error } = await builder;

  if (error) {
    console.error("getProperties:", error.message);
    return [];
  }

  return data ?? [];
}

export async function getPropertyById(id: string): Promise<Property | null> {
  const { data, error } = await supabase
    .from("properties")
    .select("*")
    .eq("id", id)
    .single();

  if (error) {
    console.error("getPropertyById:", error.message);
    return null;
  }

  return data;
}
