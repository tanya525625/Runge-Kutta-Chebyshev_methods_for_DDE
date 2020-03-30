function res = interpolation(time_point, prev_t, next_t, yn, ynn)
    tetta = (time_point - prev_t) / (next_t - prev_t);
    res = yn * (1 - tetta) + ynn*tetta;
end