# Fire Emblem Unit Growth Projection
function [uname, growproj] = FEUnitGrow (uname, blevel, bases, growths, promo)
  # name - The name of the character [string]
  # blevel - The base level of the character [int]
  # bases - The units base stats [array]
  # growths - The units growths [array]
  # promo - The promotion bonuses a unit gets [array]
  #       - 0 for prepromote
  # Stats are [HP, POW, SKL, SPD, LK, DEF, RES]

  uname = uname;

  # rows are stats at a given level
  # columns are a stat across all projected levels
  if (promo == 0)
    num_level_ups = 20 - blevel;
  else
    num_level_ups = 40 - blevel;
  endif

  cur_stats = zeros(num_level_ups, size(bases, 2));

  for i = 1:size(cur_stats, 2);
    cur_stats(1,i) = bases(1,i);
  endfor

  cur_level = blevel; # for controlling the growth loop

  while (cur_level < 20) # first stage of growth

    cur_level++; # level up
    cur_stats(cur_level,:) = cur_stats(cur_level - 1, :) + growths; # increase stats

  endwhile

  # Does unit promote?
  if (promo == 0) # prepromote, no promo bonuses
     growproj = cur_stats;
     return;
  endif

  # Else, apply promo bonuses
  cur_stats(cur_level - blevel,:) += promo;

  cur_level = 21; # now do promotion

  while (cur_level < 40)

    cur_level++;
    cur_stats(cur_level,:) = cur_stats(cur_level - 1, :) + growths;

  endwhile

  growproj = cur_stats;
endfunction
