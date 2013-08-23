% Function to define the field range along which to determine the
% hysteresis.
function Field = GetField(FieldRange,angle)
Field.Hup = FieldRange;
Field.Hdn = -FieldRange;
Field.angle = angle*(pi/180);
end
