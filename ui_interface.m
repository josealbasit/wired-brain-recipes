
function ui_interface(selectedModel,x,x_plot,y0,f_min,f,f_plot,initParam)
selectedModelstr=num2str(selectedModel);
close all
clear h

%graphics_toolkit qt

h.ax = axes ("position", [0.05 0.42 0.5 0.5]);
h.fcn = @(p) f([initParam]);
%set (get (h.ax, "title"), "string", equationName);
r2=0;
errorOptim=0;



function update_plot (obj, init = false)

  ## gcbo holds the handle of the control
  h = guidata (obj);
  replot = false;
  recalc = false;

  switch (gcbo)
    case {h.print_pushbutton}
      fn =  uiputfile ("*.png");
      print (fn);
    case{h.save_pushbotton}
      
    case {h.p1_slider}
      recalc = true;
    case {h.p2_slider}
      recalc = true;
    case {h.p3_slider}
      recalc = true;
  endswitch

  if (recalc || init)
    if(recalc)
    p(1) = get (h.p1_slider, "value");
    p(2) = get (h.p2_slider, "value");
    p(3) = get (h.p3_slider, "value");
    label_1=num2str(p(1));
    label_2=num2str(p(2));
    label_3=num2str(p(3));
    set (h.p1_label, "string",  ["Parameter 1 = " label_1] );
    set (h.p2_label, "string", ["Parameter 2 = " label_2]);
    set (h.p3_label, "string", ["Parameter 3 = " label_3]);
    initParam=p
    end
    [optimParam r2 errorOptim]=optimizationProcess(x,y0,f_min,f,initParam,1);
    set(h.statistics_r2,"string",["R2=" num2str(r2)]);
    set(h.statistics_error,"string",["Error optim= " num2str(errorOptim)]);
    y_optim_plot=f_plot(optimParam);
    if (init)
      h.plot = plot (x , y0,'+');
      hold on
      h.plot = plot(x_plot,y_optim_plot,'r')
      guidata (obj, h);
      r2=0.2;
      errorOptim=1e-2;
    elseif(recalc)
      h.plot = plot (x , y0,'+');
      hold on
      h.plot=plot(x_plot, y_optim_plot,'b');
    endif
  endif

  if (replot)
    cb_red = get (h.linecolor_radio_red, "value");
    lstyle = get (h.linestyle_popup, "string"){get (h.linestyle_popup, "value")};
    lstyle = strtrim (lstyle(1:2));

    mstyle = get (h.markerstyle_list, "string"){get (h.markerstyle_list, "value")};
    if (strfind (mstyle, "none"))
      mstyle = "none";
    else
      mstyle = mstyle(2);
    endif

    set (h.plot, "color", merge (cb_red, [1 0 0 ], [0 0 1]),
                 "linestyle", lstyle,
                 "marker", mstyle);
  endif

endfunction


## plot title
if (selectedModel==1)
  equationName="Quadratic";

endif

##Label 


h.label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", equationName,
                           "fontweight","bold",
                           "horizontalalignment", "left",
                           "position", [0.25 0.93 0.2 0.05]);

## print figure
h.print_pushbutton = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Save plot",
                                "callback", @update_plot,
                                "position", [0.6 0.45 0.35 0.09]);
                                
# Save parameters
                                h.save_pushbotton = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Save parameters' statistics",
                                "callback", @update_plot,
                                "position", [0.6 0.45 0.35 0.09]);
## p1
h.p1_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 1",
                           "horizontalalignment", "left",
                           "position", [0.05 0.3 0.35 0.08]);

h.p1_slider = uicontrol ("style", "slider",
                            "Min" , -100,
                            "Max",100,
                            "SliderStep",[0.01 0.01],
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(1),
                            "position", [0.05 0.25 0.35 0.06]);

## p1

h.p2_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 2",
                           "horizontalalignment", "left",
                           "position", [0.05 0.15 0.35 0.08]);

h.p2_slider = uicontrol ("style", "slider",
                            "Min" , -100,
                            "Max",100,
                            "SliderStep",[0.01 0.01],
                            "units", "normalized",
                            "string", "slider",
                            "callback",s,
                            "value", initParam(2),
                            "position", [0.05 0.1 0.35 0.06]);
% p3

h.p3_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 3",
                           "horizontalalignment", "left",
                           "position", [0.45 0.3 0.35 0.08]);

h.p3_slider = uicontrol ("style", "slider",
                            "Min" , -100,
                            "Max",100,
                            "SliderStep",[0.01 0.01],
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(3),
                            "position", [0.45 0.25 0.35 0.06]);

h.statistics = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Statistics",
                           "fontweight","bold",
                           "horizontalalignment", "left",
                           "position", [0.6 0.85 0.2 0.1]);
h.statistics_r2 = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["R2= " num2str(r2) ],
                           "fontweight","bold",
                           "horizontalalignment", "left",
                           "position", [0.6 0.75 0.2 0.05]);
h.statistics_error = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["Relative error= " num2str(errorOptim) ],
                           "fontweight","bold",
                           "horizontalalignment", "left",
                           "position", [0.6 0.7 0.2 0.05]);


## linecolor
%h.linecolor_label = uicontrol ("style", "text",
%                               "units", "normalized",
%                               "string", "Linecolor:",
%                               "horizontalalignment", "left",
%                               "position", [0.05 0.12 0.35 0.08]);
%
%h.linecolor_radio_blue = uicontrol ("style", "radiobutton",
%                                    "units", "normalized",
%                                    "string", "blue",
%%                                    "callback", @update_plot,
%                                    "position", [0.05 0.08 0.15 0.04]);%

%h.linecolor_radio_red = uicontrol ("style", "radiobutton",
 %                                  "units", "normalized",
  %                                 "string", "red",
   %                                "callback", @update_plot,
    %                               "value", 0,
     %                              "position", [0.05 0.02 0.15 0.04]);

## linestyle
%h.linestyle_label = uicontrol ("style", "text",
 %                              "units", "normalized",
  %                             "string", "Linestyle:",
   %                            "horizontalalignment", "left",
    %                           "position", [0.25 0.12 0.35 0.08]);
%
%h.linestyle_popup = uicontrol ("style", "popupmenu",
 %                              "units", "normalized",
  %                             "string", {"-  solid lines",
   %                                       "-- dashed lines",
    %                                      ":  dotted lines",
     %                                     "-. dash-dotted lines"},
      %                         "callback", @update_plot,
       %                        "position", [0.25 0.05 0.3 0.06]);

## markerstyle
%h.markerstyle_label = uicontrol ("style", "text",
 %                                "units", "normalized",
  %                               "string", "Marker style:",
   %                              "horizontalalignment", "left",
    %                             "position", [0.58 0.3 0.35 0.08]);
%
%h.markerstyle_list = uicontrol ("style", "listbox",
 %                               "units", "normalized",
  %                              "string", {"none",
   %                                        "'+' crosshair",
    %                                       "'o'  circle",
     %                                      "'*'  star",
      %                                     "'.'  point",
       %                                    "'x'  cross",
        %                                   "'s'  square",
         %                                  "'d'  diamond",
          %                                 "'^'  upward-facing triangle",
           %                                "'v'  downward-facing triangle",
            %                               "'>'  right-facing triangle",
             %                              "'<'  left-facing triangle",
              %                             "'p'  pentagram",
               %                            "'h'  hexagram"},
                %                "callback", @update_plot,
                 %               "position", [0.58 0.04 0.38 0.26]);

set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (gcf, h)
update_plot (gcf, true);
waitforbuttonpress()
end
