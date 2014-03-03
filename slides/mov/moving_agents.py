#!/usr/bin/env python2

import sys
import random
import pygame


try:
    nframes = int (sys.argv[1])
except (IndexError, ValueError):
    sys.stderr.write ("Usage: %s [number of frames]\n" % sys.argv[0])
    sys.exit (1)

nagent = 15
agent_size = 15
agent_color = (55, 223, 10)

bkg = pygame.image.load ('map_big.png')
bkg_w = bkg.get_width ( ) - agent_size
bkg_h = bkg.get_height ( ) - agent_size

bkg_buff = pygame.image.tostring (bkg,
                                  'RGB')
print ('Creating %d frames ...' % nframes)

for nframe in range (nframes):
    frame = pygame.image.fromstring (bkg_buff,
                                     (bkg.get_width ( ), bkg.get_height ( )),
                                     'RGB')
    #
    # move the agents every 4 frames
    #
    if (nframe % 4) == 0:
        pos = []
        for i in range (nagent):
            pos.append ((random.randint (agent_size, bkg_w),
                         random.randint (agent_size, bkg_h)))
    #
    # draw the frame
    #
    for i in range (nagent):
        pygame.draw.circle (frame,
                            agent_color,
                            pos[i],
                            agent_size) # Surface, color, pos, radius, width=0
    pygame.image.save (frame,
                       'agent_frame_%04d.png' % (nframe + 1))
print ('done')
