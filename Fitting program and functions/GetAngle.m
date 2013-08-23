% [theta_up theta_dn] = GetAngle(FieldAngle)
% Function to correctly align the initial magnetisation.
function [theta_up theta_dn] = GetAngle(FieldAngle)
global axis
% axis=FieldAngle;
if FieldAngle < 0
    %-pi; % field is initially negative, i.e. the [-100] direction.
    theta_up = FieldAngle;
    
    % field is initially positive, i.e. along the [100] direction.
    theta_dn = FieldAngle-pi;
else
    %-pi; % field is initially negative, i.e. the [-100] direction.
    theta_up = FieldAngle-pi;
    
    % field is initially positive, i.e. along the [100] direction.
    theta_dn = FieldAngle;
end
        