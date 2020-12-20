import glob, os, sys, math
import matplotlib.cm as cm  
import matplotlib.pyplot as plot
from glbase3 import *
import scipy.stats

config.draw_mode = 'pdf'

num_stages = len(sorted(glob.glob('loops/*.bed')))

fig = plot.figure(figsize=[6,num_stages+1])
fig.subplots_adjust(top=0.95, bottom=0.1, left=0.3, right=0.6, hspace=0.2)

for i, stage in enumerate(sorted(glob.glob('loops/*.bed'))):
    bedpe = genelist(filename=stage,
        format={'loc1': 'location(chr=column[0], left=column[1], right=column[2])',
                'loc2': 'location(chr=column[3], left=column[4], right=column[5])',
                'force_tsv': True},
                gzip=True)

    stage = os.path.split(stage)[1].split('.')[0]

    m = {}

    print(stage)

    for sample in sorted(glob.glob('/mnt/g/project/human_loops/hiccy/low/*_r2_*.hiccy')):
        #if ['150k','400k'] in sample: continue
        print(sample)
        #if '_r' in sample: continue
        h = hic(sample)
        sample = os.path.split(sample)[1].replace('.hiccy', '')

        d = h.measure_loop_strength(bedpe=bedpe, log=2)

        k = sample
        m[k] = d['loop_strength']

    ax = fig.add_subplot(num_stages, 1, i+1)

    ax.violinplot(m.values(), vert=False, showmeans=True, positions=[1,2])
    ax.set_yticks([1,2])
    ax.set_yticklabels(list(m.keys()))

    mmax = max([max(m[k]) for k in m])
    mmax += (mmax/5)
    ax.text(mmax, 1.5, '{}'.format(stage))
    ax.tick_params(labelsize=6)

fig.savefig('h.top.loop_strengths.pdf')




