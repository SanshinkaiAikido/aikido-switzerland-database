#!/usr/bin/env python3

from csv import reader
from datetime import datetime
from graphviz import Digraph
from shutil import copyfile

groups = {}
inactive = None
for line in reader(open('groups.tsv'), delimiter='\t'):
    id, name, *rest = line
    if name == 'INACTIF':
        groups[id] = {'name':name, 'active':False}
        inactive = id
    else:
        groups[id] = {'name':name, 'active':True, 'members':0, 'yudansha':0, 'females':0, 'males':0, 'female_rate':0,  'male_rate':0}

dojos = {}
for line in reader(open('dojos.tsv'), delimiter='\t'):
    id, name, dojocho, *rest = line
    gid = line[-1]
    if gid == inactive:
        dojos[id] = {'name':name, 'dojocho':dojocho, 'gid':gid, 'active':False}
    else:
        dojos[id] = {'name':name, 'dojocho':dojocho, 'gid':gid, 'active':True, 'members':0, 'yudansha':0, 'females':0, 'males':0, 'female_rate':0,  'male_rate':0}

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
    try:
        dojos[dojo_id]['members'] += 1
    except:
        print('ERROR: Member {} with id {} has a dojo id {} of a dojo that is probably inactive.'.format(line[1], line[0], dojo_id))
        exit(1)
    if dan1 != 'NULL' or dan2 != 'NULL' or dan3 != 'NULL' or dan4 != 'NULL' or dan5 != 'NULL' or dan6 != 'NULL' or dan7 != 'NULL' or dan8 != 'NULL':
        dojos[dojo_id]['yudansha'] += 1
    if female == '1':
        dojos[dojo_id]['females'] += 1

members = 0
yudansha = 0
females = 0
for id, values in dojos.items():
    if not values['active']:
        continue #TODO
    values['males'] = values['members'] - values['females'] 
    values['female_rate'] = round(10 * values['females'] / values['members'])
    values['male_rate'] = 10 - values['female_rate']
    groups[values['gid']]['members'] += values['members'] 
    groups[values['gid']]['yudansha'] += values['yudansha']
    groups[values['gid']]['females'] += values['females']
    groups[values['gid']]['males'] += values['members'] - values['females']
    members += values['members']
    yudansha += values['yudansha']
    females += values['females']
males = members - females
female_rate = 0
male_rate = 0
if members != 0:
    female_rate = round(10 * females / members)
    male_rate = 10 - female_rate



title = 'Members Aikido Switzerland'
now = datetime.utcnow()
now_text = now.strftime('%Y-%m-%d %H:%M:%S')
now_name = now.strftime('%Y%m%d_%H%M%S')
base = 'members_aikido_switzerland'
d = Digraph(name=title, filename='{}.gv'.format(base), format='png', engine='twopi')
d.attr('graph', ranksep='4:5', label="\nMembers Aikido Switzerland {}".format(now_text))
d.attr('edge', arrowhead='none')

d.attr('node', shape='circle', fontsize='18')
if members == 0:
    d.node('0', 'Aikido Switzerland')
else:
    d.node('0', 'Aikido Switzerland\n{} ({} yudansha)\n{} ♀ / {} ♂ ≈ {}:{}'.format(members, yudansha, females, males, female_rate, male_rate))

inactive = None
d.attr('node', shape='ellipse', fontsize='14')
for id, values in sorted(groups.items()):
    if not values['active']:
        continue #TODO
        d.attr('node', color='grey', fontcolor='grey')
        d.attr('edge', color='grey')
    if values['members'] == 0:
        d.node('g{}'.format(id), values['name'])
    else:
        values['female_rate'] = round(10 * values['females'] / values['members'])
        values['male_rate'] = 10 - values['female_rate']
        d.node('g{}'.format(id), '{}\n{} ({} yudansha)\n{} ♀ / {} ♂ ≈ {}:{}'.format(values['name'], values['members'], values['yudansha'], values['females'], values['males'], values['female_rate'], values['male_rate']))
    d.edge('g{}'.format(id), '0')
    if not values['active']:
        d.attr('node', color='black', fontcolor='black')
        d.attr('edge', color='black')



d.attr('node', shape='box', fontsize='10')
for id, values in sorted(dojos.items()):
    if not values['active']:
        continue #TODO
        d.attr('node', color='grey', fontcolor='grey')
        d.attr('edge', color='grey')
    if values['members'] == 0:
        d.node(id, '{}\n{}\n'.format(values['name'], values['dojocho']))
    else:
        d.node(id, '{}\n{}\n{} ({} yudansha)\n{} ♀ / {} ♂ ≈ {}:{}'.format(values['name'], values['dojocho'], values['members'], values['yudansha'], values['females'], values['males'], values['female_rate'], values['male_rate']))
    d.edge(id, 'g{}'.format(values['gid']))
    if not values['active']:
        d.attr('node', color='black', fontcolor='black')
        d.attr('edge', color='black')

d.render()
copyfile('{}.gv.png'.format(base), '{}_{}.png'.format(base, now_name))



markdown = open('{}.md'.format(base), 'w')
markdown.write('# {} {}\n\n'.format(title, now_text))
markdown.write('Name                                      | Members | Yudansha | Female  | Male    | Ratio\n')
markdown.write('------------------------------------------|--------:|---------:|--------:|--------:|--------\n')
markdown.write('*Federation "Aikido Switzerland"*         |  *{:>3}*  |   *{:>3}*  |  *{:>3}*  |  *{:>3}*  |  *{}:{}*\n'.format(members, yudansha, females, males, female_rate, male_rate))
for gid, gvalues in sorted(groups.items()):
    if not gvalues['active']:
        continue #TODO
    markdown.write('{:<41} | {:>7} |  {:>7} | {:>7} | {:>7} | **{}:{}**\n'.format('**Group "{}"**'.format(gvalues['name']), '**{}**'.format(gvalues['members']), '**{}**'.format(gvalues['yudansha']), '**{}**'.format(gvalues['females']), '**{}**'.format(gvalues['males']), gvalues['female_rate'], gvalues['male_rate']))
    for id, values in sorted(dojos.items()):
        if not values['active']:
            continue #TODO
        if values['gid'] == gid:
            markdown.write('{:<41} |   {:>3}   |    {:>3}   |   {:>3}   |   {:>3}   |   {}:{}\n'.format('- Dojo "{}"'.format(values['name']), values['members'], values['yudansha'], values['females'], values['males'], values['female_rate'], values['male_rate']))
markdown.close()
copyfile('{}.md'.format(base), '{}_{}.md'.format(base, now_name))
