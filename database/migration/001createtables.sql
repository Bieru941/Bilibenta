-- Enable UUID Extension
create extension if not exists "uuid-ossp";

-- Users (from Supabase Auth)
-- This table is managed by Supabase Auth

-- User Profiles
create table profiles (
  id uuid references auth.users on delete cascade primary key,
  email text not null,
  phone text,
  full_name text not null,
  username text not null unique,
  bio text default null,
  profile_image text default null,
  province text not null,
  city text not null,
  barangay text default null,
  joined_date timestamp with time zone not null default now(),
  is_verified boolean default false,
  rating numeric(3,1) default 0.0,
  review_count integer default 0,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- User Verification
create table user_verifications (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references profiles(id) on delete cascade,
  verification_type text not null, -- 'email', 'phone', 'identity'
  document_url text,
  status text not null default 'pending', -- 'pending', 'approved', 'rejected'
  rejection_reason text default null,
  submitted_at timestamp with time zone default now(),
  reviewed_at timestamp with time zone default null,
  reviewed_by uuid default null,
  updated_at timestamp with time zone default now()
);

-- Categories
create table categories (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique,
  slug text not null unique,
  description text,
  icon_name text,
  is_active boolean default true,
  sort_order integer default 0,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Listings
create table listings (
  id uuid primary key default uuid_generate_v4(),
  seller_id uuid not null references profiles(id) on delete cascade,
  category_id uuid not null references categories(id),
  title text not null,
  description text not null,
  price numeric(12,2) not null,
  condition text not null, -- 'new', 'like_new', 'used'
  province text not null,
  city text not null,
  barangay text default null,
  status text not null default 'active', -- 'draft', 'active', 'reserved', 'sold', 'removed', 'rejected', 'expired'
  is_negotiable boolean default false,
  is_featured boolean default false,
  views integer default 0,
  brand text default null,
  model text default null,
  color text default null,
  size text default null,
  quantity integer default 1,
  delivery_options text array default null,
  image_urls text array default array[]::text[],
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  sold_at timestamp with time zone default null
);

-- Listing Images (for organized storage)
create table listing_images (
  id uuid primary key default uuid_generate_v4(),
  listing_id uuid not null references listings(id) on delete cascade,
  image_url text not null,
  sort_order integer default 0,
  created_at timestamp with time zone default now()
);

-- Favorites
create table favorites (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references profiles(id) on delete cascade,
  listing_id uuid not null references listings(id) on delete cascade,
  created_at timestamp with time zone default now(),
  unique(user_id, listing_id)
);

-- Conversations
create table conversations (
  id uuid primary key default uuid_generate_v4(),
  buyer_id uuid not null references profiles(id) on delete cascade,
  seller_id uuid not null references profiles(id) on delete cascade,
  listing_id uuid references listings(id) on delete set null,
  last_message text default null,
  last_message_time timestamp with time zone default now(),
  buyer_unread_count integer default 0,
  seller_unread_count integer default 0,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  unique(buyer_id, seller_id, listing_id)
);

-- Messages
create table messages (
  id uuid primary key default uuid_generate_v4(),
  conversation_id uuid not null references conversations(id) on delete cascade,
  sender_id uuid not null references profiles(id) on delete cascade,
  receiver_id uuid not null references profiles(id) on delete cascade,
  message text not null,
  is_read boolean default false,
  image_url text default null,
  offer_data jsonb default null,
  created_at timestamp with time zone default now()
);

-- Offers
create table offers (
  id uuid primary key default uuid_generate_v4(),
  conversation_id uuid not null references conversations(id) on delete cascade,
  buyer_id uuid not null references profiles(id) on delete cascade,
  seller_id uuid not null references profiles(id) on delete cascade,
  listing_id uuid not null references listings(id) on delete cascade,
  original_price numeric(12,2) not null,
  offered_price numeric(12,2) not null,
  status text not null default 'pending', -- 'pending', 'accepted', 'declined', 'countered', 'cancelled', 'expired'
  counter_message text default null,
  counter_price numeric(12,2) default null,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  expires_at timestamp with time zone default now() + interval '7 days'
);

-- Transactions
create table transactions (
  id uuid primary key default uuid_generate_v4(),
  buyer_id uuid not null references profiles(id) on delete cascade,
  seller_id uuid not null references profiles(id) on delete cascade,
  listing_id uuid not null references listings(id) on delete cascade,
  final_price numeric(12,2) not null,
  status text not null default 'pending', -- 'pending', 'meetup_scheduled', 'completed', 'cancelled'
  meetup_date timestamp with time zone default null,
  meetup_location text default null,
  buyer_review_submitted boolean default false,
  seller_review_submitted boolean default false,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Reviews/Ratings
create table reviews (
  id uuid primary key default uuid_generate_v4(),
  transaction_id uuid not null references transactions(id) on delete cascade,
  reviewer_id uuid not null references profiles(id) on delete cascade,
  reviewee_id uuid not null references profiles(id) on delete cascade,
  rating integer not null check (rating >= 1 and rating <= 5),
  comment text,
  created_at timestamp with time zone default now(),
  unique(transaction_id, reviewer_id)
);

-- Reports
create table reports (
  id uuid primary key default uuid_generate_v4(),
  reporter_id uuid not null references profiles(id) on delete cascade,
  reported_user_id uuid references profiles(id) on delete cascade,
  reported_listing_id uuid references listings(id) on delete cascade,
  reported_message_id uuid default null,
  reason text not null, -- 'fraud_scam', 'prohibited_item', 'fake_listing', 'harassment', 'counterfeit_product', 'suspicious_account', 'other'
  description text,
  evidence_urls text array default null,
  status text not null default 'pending', -- 'pending', 'investigating', 'resolved', 'dismissed'
  admin_notes text default null,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  resolved_at timestamp with time zone default null
);

-- Blocks
create table blocks (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references profiles(id) on delete cascade,
  blocked_user_id uuid not null references profiles(id) on delete cascade,
  created_at timestamp with time zone default now(),
  unique(user_id, blocked_user_id)
);

-- Notifications
create table notifications (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references profiles(id) on delete cascade,
  type text not null, -- 'message', 'offer', 'review', 'listing_update', etc.
  title text not null,
  body text not null,
  related_id uuid default null,
  is_read boolean default false,
  created_at timestamp with time zone default now()
);

-- Admin Users
create table admin_users (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references profiles(id) on delete cascade,
  role text not null, -- 'moderator', 'admin', 'super_admin'
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  unique(user_id)
);

-- Audit Logs
create table audit_logs (
  id uuid primary key default uuid_generate_v4(),
  admin_id uuid not null references profiles(id) on delete cascade,
  action text not null, -- 'suspend_user', 'remove_listing', 'approve_verification', etc.
  target_type text not null, -- 'user', 'listing', 'review', etc.
  target_id uuid not null,
  details jsonb default null,
  created_at timestamp with time zone default now()
);

-- Featured Listings
create table featured_listings (
  id uuid primary key default uuid_generate_v4(),
  listing_id uuid not null unique references listings(id) on delete cascade,
  featured_until timestamp with time zone not null,
  promotion_cost numeric(12,2) not null,
  created_at timestamp with time zone default now()
);

-- Indexes for Performance
create index idx_profiles_username on profiles(username);
create index idx_listings_seller_id on listings(seller_id);
create index idx_listings_category_id on listings(category_id);
create index idx_listings_status on listings(status);
create index idx_listings_created_at on listings(created_at desc);
create index idx_conversations_buyer_id on conversations(buyer_id);
create index idx_conversations_seller_id on conversations(seller_id);
create index idx_messages_conversation_id on messages(conversation_id);
create index idx_messages_created_at on messages(created_at desc);
create index idx_transactions_buyer_id on transactions(buyer_id);
create index idx_transactions_seller_id on transactions(seller_id);
create index idx_reviews_reviewee_id on reviews(reviewee_id);
create index idx_favorites_user_id on favorites(user_id);
create index idx_reports_status on reports(status);
create index idx_audit_logs_created_at on audit_logs(created_at desc);

-- Row Level Security Policies
alter table profiles enable row level security;
alter table listings enable row level security;
alter table conversations enable row level security;
alter table messages enable row level security;
alter table favorites enable row level security;

-- Profiles RLS
create policy "Users can view all profiles" on profiles for select using (true);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);

-- Listings RLS
create policy "Anyone can view active listings" on listings for select using (status = 'active');
create policy "Users can view own listings" on listings for select using (seller_id = auth.uid());
create policy "Users can create listings" on listings for insert with check (seller_id = auth.uid());
create policy "Users can update own listings" on listings for update using (seller_id = auth.uid());
create policy "Users can delete own listings" on listings for delete using (seller_id = auth.uid());

-- Conversations RLS
create policy "Users can view own conversations" on conversations for select using (buyer_id = auth.uid() or seller_id = auth.uid());
create policy "Users can create conversations" on conversations for insert with check (buyer_id = auth.uid() or seller_id = auth.uid());

-- Messages RLS
create policy "Users can view messages in their conversations" on messages for select 
  using (
    exists (
      select 1 from conversations 
      where conversations.id = messages.conversation_id 
      and (conversations.buyer_id = auth.uid() or conversations.seller_id = auth.uid())
    )
  );
create policy "Users can insert messages" on messages for insert with check (sender_id = auth.uid());

-- Favorites RLS
create policy "Users can view own favorites" on favorites for select using (user_id = auth.uid());
create policy "Users can create favorites" on favorites for insert with check (user_id = auth.uid());
create policy "Users can delete favorites" on favorites for delete using (user_id = auth.uid());