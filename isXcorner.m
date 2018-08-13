% �ж��Ƿ�ΪX���䣬����Ϊx,y���꣬ͼ������Լ��жϾ����������ֵ��б�ԽǵĲ������ƣ����ڵĲ������졣�жϸþ����ڵ�ͼ���Ƿ�Գ�
% ע��x������������y����������
% mark = isXcorner(x,y,image,dist,thr_same,thr_diff)
function mark = isXcorner(x,y,image,dist,thr_same,thr_diff)
    gray=double(image);
    [a,b,c]=size(image)
    if c~=1
        error('Image format has to be NxMx1')
    end
    if (x<dist) || (y<dist)
        mark = false;
        return 
    end
        
    % 4 squares around the middle point
    sq_lu=gray([y-dist:y],[x-dist:x]);  % square left-up
    sq_ru=gray([y-dist:y],[x:x+dist]); % square right-up
    sq_ld=gray([y:y+dist],[x-dist:x]); % square left-down
    sq_rd=gray([y:y+dist],[x:x+dist]); % square right-down

    % average value
    av_lu=sum(sq_lu(:))/numel(sq_lu);
    av_ru=sum(sq_ru(:))/numel(sq_ru);
    av_ld=sum(sq_ld(:))/numel(sq_ld);
    av_rd=sum(sq_rd(:))/numel(sq_rd);
    
    % punkt-symmetrisch
    diff_lu_rd=abs(av_lu-av_rd);
    diff_ru_ld=abs(av_ru-av_ld);
    diff_lu_ld=abs(av_lu-av_ld);
    diff_ru_rd=abs(av_ru-av_rd);
    
    % Judgment
     if (diff_lu_rd<thr_same)&&(diff_ru_ld<thr_same)
         mark_same = true;
     else
         mark_same = false;
     end
     
     if (diff_lu_ld>thr_diff)&&(diff_ru_rd>thr_diff)
         mark_diff = true;
     else
         mark_diff=false;  
     end
     
     mark = mark_same & mark_diff;
  
     
end