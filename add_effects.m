function [w] = add_effects(t, x, env, distort, lfo)
%ADD_EFFECTS Summary of this function goes here
%   Detailed explanation goes here
    arguments
        t (1, :) double
        x (1, :) double
        env.adsr (1, 5) double {validate_adsr(env.adsr)} = [0 0 0 0 0]
        distort.gain (1, 1) double = 0
        distort.dry (1, 1) double {validate_dry(distort.dry)} = 0.5
        lfo.amp (1, 1) double = 0
        lfo.hz (1, 1) double = 1
        
    end
    if sum(env.adsr(1)) ~= 0
        w = apply_adsr(t, x, env.adsr(1), env.adsr(2), ...
            env.adsr(3), env.adsr(4), env.adsr(5));
    end
    if lfo.amp ~= 0
        if exist('w', 'var')
            w = apply_lfo(t, w, lfo.amp, lfo.hz);
        else
            w = apply_lfo(t, x, lfo.amp, lfo.hz);
        end
    end
    if distort.gain ~= 0
        if exist('w', 'var')
            w = apply_distort(w, distort.gain, distort.dry);
        else
            w = apply_distort(x, distort.gain, distort.dry);
        end
    end
end

function validate_adsr(x)
    if ismember(0, x(1:4)) && sum(x(1:4)) > 0
        eid = 'adsr:zero';
        msg = 'ADSR components must be nonzero';
        throwAsCaller(MException(eid, msg))
    end
    if sum(x(1:4)) > 3000
        eid = 'adsr:outOfBonds';
        msg = 'ADSR envelope is longer than sound input';
        throwAsCaller(MException(eid, msg))
    end
    if x(5) <= 0 || x(5) > 1
        eid = 'samp:invalidInput';
        msg = 'Sustain Amplitude is not between 0 and 1';
        throwAsCaller(MException(eid, msg))
    end
end

function validate_dry(x)
    if x < 0 || x > 1
        eid = 'dry:invalidInput';
        msg = 'Amount Dry Signal is Between 0 and 1';
        throwAsCaller(MException(eid, msg))
    end
end
