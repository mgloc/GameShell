from dashing import *

if __name__ == '__main__':

    ui = HSplit(
            VSplit(
                HGauge(val=90, title="Progression",label="90%", border_color=5),
               ),
            title='Dashing',
        )
    ui.display()
