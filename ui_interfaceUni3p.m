function ui_interfaceUni3p(selectedModel,x,x_plot,y0,f_min,f,f_plot,initParam)
  pkg load optim
selectedModelstr=num2str(selectedModel);
close all
clear h
n=length(initParam)
%graphics_toolkit qt
h.ax = axes ("position", [0.05 0.42 0.5 0.5]);
h.fcn = @(p) f([initParam]);
r2=0;
errorOptim=0;
optimParam=initParam;

function update_plot (obj, init = false)

  ## gcbo holds the handle of the control
  h = guidata (obj);
  replot = false;
  recalc = false;

  switch (gcbo)%Handle of the object whose callback is currently executing
    case {h.print_pushbutton}
      fn =  uiputfile ("*.png");
      print (fn);
    case{h.save_pushbotton}
       disp("Saving the file...")
    case {h.p1_slider}
      recalc = true;
    case {h.p2_slider}
      recalc = true;
    case {h.p3_slider}
      recalc = true;
  endswitch

  if (recalc || init)
    if(recalc==true)
      p(1) = get (h.p1_slider, "value");
      p(2) = get (h.p2_slider, "value");
      label_1=num2str(p(1));
      label_2=num2str(p(2));
      set (h.p1_label, "string",  ["Parameter 1 = " label_1] );
      set (h.p2_label, "string", ["Parameter 2 = " label_2]);
      if(n==3)
        p(3) = get (h.p3_slider, "value");
        label_3=num2str(p(3));
        set (h.p3_label, "string", ["Parameter 3 = " label_3]);
      end
    initParam=p
    [optimParam r2 errorOptim]=optimizationProcess(x,y0,f_min,f,initParam,1)
    end
    initParam
    set(h.p1_optim,"string",["Optimal Parameter 1 = " num2str(optimParam(1))]);
    set(h.p2_optim,"string",["Optimal Parameter 2 = " num2str(optimParam(2))]);
    if(n==3)
      set(h.p3_optim,"string",["Optimal Parameter 3 = " num2str(optimParam(3))]);
    end
    set(h.statistics_r2,"string",["R^2=" num2str(r2)]);
    set(h.statistics_error,"string",["Error optim= " num2str(errorOptim)]);
    y_optim_plot=f_plot(optimParam);

    if (init)
      label_1=num2str(initParam(1));
      label_2=num2str(initParam(2));
      set (h.p1_label, "string",  ["Parameter 1 = " label_1] );
      set (h.p2_label, "string", ["Parameter 2 = " label_2]);
      if(n==3)
        label_3=num2str(initParam(3));
        set (h.p3_label, "string", ["Parameter 3 = " label_3]);
      end
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
    set (h.plot, "color", merge (cb_red, [1 0 0], [0 0 1]),
                 "linestyle", lstyle,
                 "marker", mstyle);
  endif

endfunction
h.position=get(0,"screensize")([3,4,3,4]).*[0.1 0.1 0.8 0.8]
%set(h,"position",get(0,"screensize")([3,4,3,4]).*[0.1 0.1 0.8 0.8])
## plot title
switch(selectedModel)
  case 1
  equationName="Linear SS";
  case 2
  equationName="Quadratic SS";
  case 3
  equationName="Neue/Polarity ";
  case 4
  equationName="Neue-Kuss";
  case 5
  equationName="Jandera 2p";
  case 6
  equationName="Jandera 3p";
  case 7
  equationName="Elution g";
  case 8
  equationName="Micelar";
endswitch

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
                           "fontsize",12,
                           "fontweight","bold",
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
                           "fontsize",12,
                           "fontweight","bold",
                           "position",[0.45 0.3 0.35 0.08] );

h.p2_slider = uicontrol ("style", "slider",
                            "Min" , -100,
                            "Max",100,
                            "SliderStep",[0.01 0.01],
                            "units", "normalized",
                            "string", "slider",
                            "callback",@update_plot,
                            "value", initParam(2),
                            "position", [0.45 0.25 0.35 0.06]);
% p3
if(n==3)
h.p3_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Parameter 3",
                           "horizontalalignment", "left",
                           "fontsize",12,
                           "fontweight","bold",
                           "position",[0.05 0.15 0.35 0.08] );

h.p3_slider = uicontrol ("style", "slider",
                            "Min" , -100,
                            "Max",100,
                            "SliderStep",[0.01 0.01],
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", initParam(3),
                            "position",[0.05 0.1 0.35 0.06] );
end
if(n==2)
h.p3_label= zeros(0,0)
h.p3_slider=zeros(0,0)
end
h.statistics = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Statistics:",
                           "fontsize",15,
                           "fontweight","bold",
                           "horizontalalignment", "left",
                           "position", [0.7 0.9 0.2 0.1]);
h.statistics_r2 = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["R2= " num2str(r2) ],
                           "horizontalalignment", "left",
                           "position", [0.6 0.85 0.2 0.05]);
h.statistics_error = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["Relative error= " num2str(errorOptim) ],
                           "horizontalalignment", "left",
                           "position", [0.6 0.8 0.2 0.05]);

h.optimParameters = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Optimal parameters:",
                           "fontsize",15,
                           "fontweight","bold",
                           "horizontalalignment", "left",
                           "position", [0.68 0.7 0.2 0.1]);
h.p1_optim = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["Optimal parameter 1 = " num2str(initParam(1))] ,
                           "horizontalalignment", "left",
                           "position", [0.6 0.68 0.2 0.05]);
h.p2_optim = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["Optimal parameter 2 =  " num2str(initParam(2)) ],
                           "horizontalalignment", "left",
                           "position", [0.6 0.64 0.2 0.05]);
if(n==3)
h.p3_optim = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", ["Optimal parameter 1 = " num2str(initParam(3)) ],
                           "horizontalalignment", "left",
                           "position", [0.6 0.6 0.2 0.05]);
end

set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (gcf, h)
%set(gcf,"position",get(0,"screensize")([3,4,3,4]).*[0.1 0.1 0.8 0.9])
update_plot (gcf, true);
waitforbuttonpress()
end
