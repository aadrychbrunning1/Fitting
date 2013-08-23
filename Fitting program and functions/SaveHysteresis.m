% Function to save the hysteresis output as a plain text file.
% Include some headers with important values e.g. anisotropies, etc.
% Values to save: Hup, Hdn, theta, magnetisation
function SaveHysteresis()
% Plot of magnetisation vs applied field
hold on
plot(FieldParams.Hup*(1e-4),minMag(1,:)/Ms,'r', 'linewidth', 2);
plot(FieldParams.Hdn*(1e-4),minMag(2,:)/Ms,'b', 'linewidth', 2);
xlabel('Applied field (T)')
ylabel('M/M_{s}')
hold off
end
% save the structure hysteresis to a text file, also fieldparams, strain
% params as comment headers in this file
% Plot of magnetisation angle vs applied field
% figure;
% hold on
% plot(FieldRange,upAngle,'r-', 'linewidth', 2);
% plot(FieldRange,dnAngle,'b-', 'linewidth', 2);
% title(sprintf('Mag. angle for Applied field angle %d',FieldParams.angle*(180/pi)));
% hold off
% xlabel('Applied field')
% ylabel('Magnetisation Angle')
% legend('-2000:1:2000', '2000:-1:-2000','location', 'best')