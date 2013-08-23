function FieldIndex = FieldPlotSelect(FieldRange,FieldSelection)
if length(FieldRange) > 1
    FieldIndex = find(FieldRange == FieldSelection);
else
    FieldIndex = 1;
end
end