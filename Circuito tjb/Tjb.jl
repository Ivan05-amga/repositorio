using Gtk, Gtk.ShortNames

"""
    Linguagem utilizada: Julia 1.6.2
    Autor : Jorge Ivan Augusto de Oliveira filho 
"""


# Configurações para a montagem de uma GUI simples

win = Window("Análise cc do TJB ", 400, 400)
hbox = Box(:h)
vbox = Box(:v)
label = Label("")
vFrame = Frame("Tensão da fonte Vcc")
βFrame = Frame("Ganho de corrente cc do TJB (β)")
R1Frame = Frame("RB")
R1Grid = Grid()
R2Frame = Frame("RC")
R2Grid = Grid()
r1ComboBox  = GtkComboBoxText()
r2ComboBox  = GtkComboBoxText()
image = GtkImage()


choices = Dict("μΩ" => 10e-6 , "mΩ" => 10e-3, "Ω" => 1, "kΩ" => 10e3 ,"MΩ" => 10e6)
for choice in keys(choices)
  push!(r1ComboBox,choice)
  push!(r2ComboBox,choice)
end


set_gtk_property!(r1ComboBox,:active,4)
set_gtk_property!(r2ComboBox,:active,4)
set_gtk_property!(image,:file,joinpath(pwd(),"imagem.png"))
set_gtk_property!(image,:icon_size,0.0001)

vEntry = Entry(); set_gtk_property!(vEntry, :text, 3)
βEntry = Entry(); set_gtk_property!(βEntry, :text, 4)
R1Entry = Entry(); set_gtk_property!(R1Entry, :text, 4)
R2Entry = Entry(); set_gtk_property!(R2Entry, :text, 4)


push!(win, hbox)
push!(hbox,image)
push!(hbox, vbox)
push!(vbox, vFrame); push!(vFrame, vEntry)
push!(vbox, βFrame); push!(βFrame, βEntry)
R1Grid[1,1] = R1Entry
R1Grid[2,1] = r1ComboBox
push!(vbox, R1Frame);push!(R1Frame, R1Grid)
R2Grid[1,1] = R2Entry
R2Grid[2,1] = r2ComboBox
push!(vbox, R2Frame); push!(R2Frame, R2Grid)
push!(vbox, label)



set_gtk_property!(hbox, :expand, image, true)
set_gtk_property!(vbox, :expand, true)
set_gtk_property!(R1Entry, :hexpand , true)
set_gtk_property!(R2Entry, :hexpand,  true)

a = 

set_gtk_property!(label, :use_markup, true)
set_gtk_property!(label, :label, "<span>
Vbe = 0,7V 
<span font=\"15\">Press enter to see the results</span>
</span>
")
showall(win)

# Função principal do programa

function calcvals()
    V =  parse(Float64,get_gtk_property(vEntry,:text,String))
    β = parse(Float64,get_gtk_property(βEntry,:text,String))
    R1 = parse(Float64,get_gtk_property(R1Entry,:text,String))*choices[Gtk.bytestring(GAccessor.active_text(r1ComboBox))]
    R2 =   parse(Float64,get_gtk_property(R2Entry,:text,String))*choices[Gtk.bytestring(GAccessor.active_text(r2ComboBox))]

    Ib = (V-0.7)/(R1)
    Ic = β*Ib
    Vce = V - Ic*R2
    text = "<span font=\"15\">Ib = $(Ib) \nIc = $(Ic) \nIc = $(Ic) \nPb = $(R1*Ib^2) \nPc = $(R2*Ic^2) </span>"
    set_gtk_property!(label, :label, text )
    return nothing
end


signal_connect(x -> calcvals(), βEntry, "activate")
signal_connect(x -> calcvals(), vEntry, "activate")
signal_connect(x -> calcvals(), R1Entry, "activate")
signal_connect(x -> calcvals(), R2Entry, "activate")


if !isinteractive()
    c = Condition()
    signal_connect(win, :destroy) do widget
        notify(c)
    end
    wait(c)
end
