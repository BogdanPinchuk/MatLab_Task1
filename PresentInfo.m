function PresentInfo(head, data, coche, chose)
% Презентація інформації на графіку
% head - заголовок
% data - дані SNR
% coche - інформація про "латки" patches
% chose - вибір відображення графіків, true - всі разом, false - окремо

% Name of chanels
RGB = ['R', 'G', 'B'];

% chose present information
if chose
    hold on;
    
    for i = 1 : size(data, 1)
        plot(data(i, :), lower(RGB(i)), 'LineWidth', 2, 'DisplayName', RGB(i));
    end

    xlim([1 size(coche, 1)]);
    ylim([0 max(max(data))]);
    
    xticks(1:size(coche, 1))
    xtickangle(90);
    xticklabels(coche(:, 1));

    grid on

    title(head);
    xlabel('Patches of ColorChecker');
    ylabel('SNR');

    legend('show');
else
    for i = 1 : size(data, 1)
        subplot(size(data, 1), 4, (i - 1) * 4 + 1 : (i - 1) * 4 + 3);
        plot(data(i, :), lower(RGB(i)), 'LineWidth', 2, 'DisplayName', RGB(i));
        
        xlim([1 size(coche, 1)]);
        ylim([0 max(max(data))]);
        
        xticks(1:size(coche, 1))
        % не дуже наглядно на малому графіку відображення через налізання
        % одне на одне, для розкриття на весь екран розкоментувати
%         xtickangle(90);
%         xticklabels(coche(:, 1));
        
        grid on

        title([head, ': chanel ', RGB(i)]);
        xlabel('Patches of ColorChecker');
        ylabel('SNR');
    end
    
    % help information
    subplot(1, 4, 4);
    ylim([1 size(coche, 1)]);
    axis off;
   
    for i = 1 : size(coche, 1)
        text(0.35, i, strcat(num2str(size(coche, 1) - i + 1),...
            ' { }', coche(size(coche, 1) - i + 1, 1)));
    end
end


end

