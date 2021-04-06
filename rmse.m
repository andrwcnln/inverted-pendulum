% Calculate Root Mean Squared Error for angle
rmse_phi = sum((full_output.phi).^2);
rmse_phi = rmse_phi/length(full_output.phi);
rmse_phi = sqrt(rmse_phi);

% Calculate Root Mean Squared Error for speed
rmse_x_dot = sum((full_output.x_dot).^2);
rmse_x_dot = rmse_x_dot/length(full_output.x_dot);
rmse_x_dot = sqrt(rmse_x_dot);

% Print values
rmse_phi
rmse_x_dot

% Calculate number of failures
failures = full_output.phi > 1.57;
failures = sum(failures);

% Print
failures
