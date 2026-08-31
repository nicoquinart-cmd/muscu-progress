-- FitPilot V5.1.1
-- Conserve l'intensité, le ressenti et les notes des cours Fitness dans Supabase.

alter table public.fitness_classes
  add column if not exists intensity text default 'moderate',
  add column if not exists feeling integer default 3,
  add column if not exists note text;

update public.fitness_classes
set intensity = coalesce(intensity, 'moderate'),
    feeling = coalesce(feeling, 3)
where intensity is null or feeling is null;

alter table public.fitness_classes
  drop constraint if exists fitness_classes_intensity_check;

alter table public.fitness_classes
  add constraint fitness_classes_intensity_check
  check (intensity in ('light','moderate','high'));

alter table public.fitness_classes
  drop constraint if exists fitness_classes_feeling_check;

alter table public.fitness_classes
  add constraint fitness_classes_feeling_check
  check (feeling between 1 and 5);
