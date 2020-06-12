function singleSubject(inimg,outdir,inlbl,space)

addpath(genpath('tools'));
mkdir(outdir);
outdir = [outdir '/']; % make sure this is a directory

if ~exist('inlbl','var')
    inlbl = [];
end
if ~exist('space','var')
    space = 'native';
end

Resample_CoronalOblique(inimg,outdir,space,inlbl); % Temporarily removed inlbl for Kayla's data
for LR = 'LR'
    inimgLR = [outdir '/hemi-' LR '/img.nii.gz'];
    outdirLR = [outdir '/hemi-' LR '/'];
    if ~isempty(inlbl)
        inlblLR = [outdir '/hemi-' LR '/manual_lbl.nii.gz'];
        if exist(inlblLR,'file')
            AutoTops_TransformAndRollOut(inimgLR,outdirLR,inlblLR);
        else
            warning([inlblLR ' not found, proceeding with Automated segmentation']);
        end
    end
    AutoTops_TransformAndRollOut(inimgLR,outdirLR);
    Resample_Native(outdirLR,outdir);
end
