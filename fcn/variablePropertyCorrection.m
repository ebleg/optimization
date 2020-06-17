function corrected = variablePropertyCorrection(uncorrected, e, Te, Ts)
    %% Variable property correction
    % cfr. Basic Heat and Mass Transfer p268, 277
    % - uncorrected: uncorrected f or Nu
    % - e: exponent from Table 4.6
    % - Te: air inlet temperature
    % - Ts: wall temperature
    
    corrected = (Ts/Te)^e*uncorrected;
end

