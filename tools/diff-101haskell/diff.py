#! /usr/bin/env python

import os
import copy
import filecmp
import simplejson as json

# Deserialize baseline
baselineFile = open("baseline.json", 'r')
baseline = json.load(baselineFile)

# Root for analysis
root = "../../contributions"

# Keep track of contributions and their files
contrs = set()
cstems = dict()

# Dictionary for filename sharing
fnshare = dict()

# Go over all files starting from some root
for absolute, dirnames, filenames in \
        os.walk(os.path.join(root), True, None, False):

    # Determine name relative to root
    relative = absolute[len(root)+1:]

    # Do not look into root directory for files
    if relative != "":

        # Split directory name 
        parts = relative.rsplit("/")

        # Skip "dist" as perhaps left behind by cabal
        if "dist" in dirnames:
            dirnames.remove("dist")
        
        # Keep track of contributions and their files
        contr = parts[0]
        if not contr in contrs:
            contrs.add(contr)
            cstems[contr] = list()

        # Skip anything but files in "src"
        if len(parts) < 2 or not parts[1] == 'src':
            continue

        # Determine local file prefix (excluding contribution)
        local = relative[len(contr)+1:]

        # Go over the files in the current directory
        for filename in filenames:

            # Split up basename and remove "src"
            qfilename = os.path.join(local,filename)
            split = os.path.splitext(qfilename)
            stem = split[0][4:]
            ext = split[-1]

            # Consider Haskell files with .hs extension only
            if ext == '.hs':
                if not stem in fnshare:
                    fnshare[stem] = list()
                fnshare[stem].append(contr)

                # Keep track of contributions and their files
                cstems[contr].append(stem)


# Dismiss files with only one contribution
for stem in copy.copy(fnshare):
    if len(fnshare[stem])==1:
        del fnshare[stem]

# Dictionary for file content sharing
fcshare = dict()

# Process all shared filenames
for stem in fnshare:
    fcshare[stem] = list()
    for contr1 in fnshare[stem]:

        # Reconstruct file name
        f1 = os.path.join(root, contr1, "src", stem + '.hs')

        # Remember whether clone was found
        clone = False

        # Iterate over clone groups
        for group in fcshare[stem]:

            # Pick a representative of the clone group
            contr2 = group[0]

            # Reconstruct file name
            f2 = os.path.join(root, contr2, "src", stem + '.hs')

            # Compare files
            if filecmp.cmp(f1, f2, True):
                group.append(contr1)
                clone = True
                break

        # Start a new clone group if necessary
        if not clone:
            newgroup = list()
            newgroup.append(contr1)
            fcshare[stem].append(newgroup)

# Dismiss clone groups with only one contribution
equals = dict()
for stem in fcshare:
    for group in fcshare[stem]:
        if len(group) > 1:
            if not stem in equals:
                equals[stem] = list()
            equals[stem].append(group)

# Serialize result to JSON
equalsFile = open("equals.json", 'w')
equalsFile.write(json.dumps(equals))

# Report number of stems affected
report = dict()
report["stems"] = len(equals)

# Report number of clone groups found
groups = 0
for stem in equals:
    groups += len(equals[stem])
report["groups"] = groups

# Report number of affected contributions
acontrs = set()
for stem in equals:
    for group in equals[stem]:
        for contr in group:
            acontrs.add(contr)
report["contributions"] = len(acontrs)

# Report delta between baseline and result
delta = dict()
report["delta"] = delta

# Report added stems with clone groups
delta["+"] = list()
for stem in equals:
    if not stem in baseline:
        delta["+"].append(stem)

# Report removed stems with clone groups
delta["-"] = list()
for stem in baseline:
    if not stem in equals:
        delta["-"].append(stem)
 
# Serialize report to JSON
reportFile = open("report.json", 'w')
reportFile.write(json.dumps(report))

# Project equals to each contribution
for contr in contrs:
    proj = dict()
    for stem in equals:

        # Report a group that contains present contribution
        for group in equals[stem]:
            if contr in group:
                proj[stem] = group
                break

    # Determine unequals for contribution
    unequals = list()
    for stem in cstems[contr]:
        if not stem in proj:
            unequals.append(stem)

    # Create contribution directory, if necessary
    projDir = os.path.join("contributions",contr)
    try:
         os.makedirs(projDir)
    except OSError:
         pass

    # Serialze per-contribution reports
    projFile = open(os.path.join(projDir,"equals.json"), 'w')
    projFile.write(json.dumps(proj))
    projFile = open(os.path.join(projDir,"unequals.json"), 'w')
    projFile.write(json.dumps(unequals))
