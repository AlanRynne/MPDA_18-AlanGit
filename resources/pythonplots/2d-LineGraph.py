from bokeh.plotting import *
from bokeh.models import ColumnDataSource
import bokeh.palettes as bp
from bokeh.io import export, export_svgs, export_png
import pandas as pd
import io

# TO-DO 
# Implement input and output arguments
# Connect into makefile


#Read CSV file and convert it to CDS
df = pd.read_csv('resources/rawData/testData.csv')
cds_df = ColumnDataSource(df)

# Set plot properties 
plotTitle='PlotTitle' #Plot title should come freom the .CSV filename
paletteName= 'Spectral'
plotPalette = bp.brewer['Spectral'][10]
p = Figure(tools='', title='First Bokeh Plot', x_axis_label='Horizontal Title', y_axis_label='Vertical Title', plot_height=400, plot_width=400)

fontStyle = 'italic'
font = 'times'
p.title.text_font = font
p.xaxis.axis_label_text_font = font
p.yaxis.axis_label_text_font = font
p.title.text_font_style = fontStyle
p.xaxis.axis_label_text_font_style = fontStyle
p.yaxis.axis_label_text_font_style = fontStyle

p.title.text_font_size = '14pt'
p.xaxis.axis_label_text_font_size = '12pt'
p.yaxis.axis_label_text_font_size = '12pt'


p.toolbar.logo = None

p.legend.orientation = 'horizontal'
p.legend.location = 'bottom_right'
p.legend.margin = 0



## Plot the data
for x in range(0, len(df.columns)):
    if x%2==0:
        p.line(df.columns[x],df.columns[x+1], source=df, color=plotPalette[x], line_width=3, legend=' '+list(df)[x])
        p.circle_cross(df.columns[x],df.columns[x+1], source=df, color=plotPalette[x], size=10, fill_alpha=0.5)


# Setup export
# HTML
show(p)
output_file('resources/images/html/%s.html' % plotTitle)
# SVG
p.output_backend = "svg"
export_svgs(p, filename="resources/images/svg/%s.svg" % plotTitle)