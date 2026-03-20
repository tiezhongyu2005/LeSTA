function v = boundConstraint (v, Varmin, Varmax)
% Handle the elements of the state vector which violate the boundary
low_state = repmat(Varmin,size(v,1),1);
up_state = repmat(Varmax,size(v,1),1);
vioLow = v < low_state;
v(vioLow) = min(up_state(vioLow), 2 .* low_state(vioLow) - v(vioLow));
vioUpper = v > up_state;
v(vioUpper) = max(low_state(vioUpper), 2 .* up_state(vioUpper) - v(vioUpper));

end