export interface Agent {
  id: string;
  name: string;
  avatar: string;
  email: string | null;
  phone: string | null;
}

export interface Property {
  id: string;
  name: string;
  address: string;
  type: string;
  price: number;
  area: number;
  bedrooms: number;
  bathrooms: number;
  rating: number;
  image: string;
  description: string | null;
  created_at: string;
}

export interface GalleryImage {
  id: string;
  property_id: string;
  image: string;
}

export interface Review {
  id: string;
  property_id: string;
  agent_id: string;
  review: string;
  rating: number;
  date: string;
}

export interface PropertyFilters {
  filter: string;
  query: string;
  limit?: number;
}
