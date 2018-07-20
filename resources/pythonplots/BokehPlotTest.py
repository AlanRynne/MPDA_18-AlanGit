from bokeh.plotting import *
from bokeh.models import ColumnarDataSource
from bokeh.io import export_svgs
from pandas import read_csv
import io

x1 = [1,2,3,4,5]
y1 = [1,2,3,4,5]
x2 = [0,1,2,3,4]
y2 = [4,3,2,1,0]
x3 = [5,4,3,2,1]
y3 = [1,2,3,4,5]


output_file('BokehPlotTest.html')

p = Figure(tools='save', title='First Bokeh Plot', x_axis_label='Horizontal Title', y_axis_label='Vertical Title',)

p.line(x1,y1,legend='One',line_width=2,line_color='red')
p.circle_cross(x1,y1,legend='One',line_color='white', fill_color='red',size=8)
p.line(x2,y2,legend='Two',line_width=2,line_color='black',line_dash='4 4 1 4')
p.circle(x2,y2,legend='Two',line_width=3,line_color='black',fill_color='white',size=8)
p.step(x3,y3,legend='Three',line_width=1,line_dash='4 4')
p.diamond(x3,y3,legend='Three',line_width=2,fill_color='white',size=8)

export_svgs(p,filename="plot1.svg")