#!/usr/bin/env python3

from csv import reader
from datetime import datetime
from graphviz import Digraph

groups = {}
group_members = {}
group_females = {}
group_yudansha = {}
inactive = None
for line in reader(open('groups.tsv'), delimiter='\t'):
    id, name, *rest = line
    if name == 'INACTIF':
        groups[id] = {'name':name, 'active':False}
        inactive = id
    else:
        groups[id] = {'name':name, 'active':True}
    group_members[id] = 0
    group_females[id] = 0
    group_yudansha[id] = 0

dojos = {}
dojo_members = {}
dojo_females = {}
dojo_yudansha = {}
for line in reader(open('dojos.tsv'), delimiter='\t'):
    id, name, dojocho, *rest = line
    gid = line[-1]
    if gid == inactive:
        dojos[id] = {'name':name, 'dojocho':dojocho, 'gid':gid, 'active':False}
    else:
        dojos[id] = {'name':name, 'dojocho':dojocho, 'gid':gid, 'active':True}
    dojo_members[id] = 0
    dojo_females[id] = 0
    dojo_yudansha[id] = 0

for line in reader(open('aikidokas.tsv'), delimiter='\t'):
    female = line[2]
    dan1 = line[24]
    dan2 = line[25]
    dan3 = line[26]
    dan4 = line[27]
    dan5 = line[28]
    dan6 = line[29]
    dan7 = line[30]
    dan8 = line[31]
    dojo_id = line[32]
    dojo_members[dojo_id] += 1
    if female == '1':
        dojo_females[dojo_id] += 1
    if dan1 != 'NULL' or dan2 != 'NULL' or dan3 != 'NULL' or dan4 != 'NULL' or dan5 != 'NULL' or dan6 != 'NULL' or dan7 != 'NULL' or dan8 != 'NULL':
        dojo_yudansha[dojo_id] += 1

members = 0
females = 0
yudansha = 0
for id, values in dojos.items():
    group_members[values['gid']] += dojo_members[id] 
    group_females[values['gid']] += dojo_females[id]
    group_yudansha[values['gid']] += dojo_yudansha[id]
    members += dojo_members[id] 
    females += dojo_females[id]
    yudansha += dojo_yudansha[id]



d = Digraph(name='Aikido Switzerland Organogram', filename='aikido_switzerland_organogram.gv', format='png', engine='twopi')
d.attr('graph', ranksep='4:5', label="\nAikido Switzerland – Membership Organogram – {}".format(datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')))
d.attr('edge', arrowhead='none')

d.attr('node', shape='circle', fontsize='18')
if members != 0:
    males = members - females
    femaler = round(10 * females / members)
    d.node('0', 'Aikido Switzerland\n{} ({} yudansha)\n{} ♀ / {} ♂ ≈ {}:{}'.format(members, yudansha, females, males, femaler, 10 - femaler))
else:
    d.node('0', 'Aikido Switzerland')




inactive = None
d.attr('node', shape='ellipse', fontsize='14')
for id, values in sorted(groups.items()):
    if not values['active']:
        d.attr('node', color='grey', fontcolor='grey')
        d.attr('edge', color='grey')
        d.node('g{}'.format(id), values['name'])
    if group_members[id] != 0:
        males = group_members[id] - group_females[id]
        femaler = round(10 * group_females[id] / group_members[id])
        d.node('g{}'.format(id), '{}\n{} ({} yudansha)\n{} ♀ / {} ♂ ≈ {}:{}'.format(values['name'], group_members[id], group_yudansha[id], group_females[id], males, femaler, 10 - femaler))
    else:
        d.node('g{}'.format(id), values['name'])
    d.edge('g{}'.format(id), '0')
    if not values['active']:
        d.attr('node', color='black', fontcolor='black')
        d.attr('edge', color='black')

d.attr('node', shape='box', fontsize='10')
for id, values in sorted(dojos.items()):
    if not values['active']:
        d.attr('node', color='grey', fontcolor='grey')
        d.attr('edge', color='grey')
    if dojo_members[id] != 0:
        males = dojo_members[id] - dojo_females[id]
        femaler = round(10 * dojo_females[id] / dojo_members[id])
        d.node(id, '{}\n{}\n{} ({} yudansha)\n{} ♀ / {} ♂ ≈ {}:{}'.format(values['name'], values['dojocho'], dojo_members[id], dojo_yudansha[id], dojo_females[id], males, femaler, 10 - femaler))
    else:
        d.node(id, '{}\n{}\n'.format(values['name'], values['dojocho']))
    d.edge(id, 'g{}'.format(values['gid']))
    if not values['active']:
        d.attr('node', color='black', fontcolor='black')
        d.attr('edge', color='black')

d.render()