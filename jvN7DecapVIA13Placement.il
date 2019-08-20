/* jvN7DecapVIA13Placement.il
 *
 *
 * Author       Joel Viray
 * Language     SKILL
 * Date         July 7, 2019
 *
 * After Decap power placement, this scripts helps remove unwated VIA13.  
 * 
 *  
 */


procedure(abGetOverlapShape(overlap)
  if(listp(overlap) then
      abGetOverlapShape(cadr(overlap))
  else
      overlap
  );if
);procedure

cv=geGetEditCellView()

procedure(jvN7DecapVIA13Placement_remove()


    foreach(decap_via13 geGetSelSet()

        decapVia13Bbox=decap_via13~>bBox

        x1bbox=xCoord(lowerLeft(decapVia13Bbox))
		y1bbox=yCoord(lowerLeft(decapVia13Bbox))
        x2bbox=xCoord(upperRight(decapVia13Bbox))
		y2bbox=yCoord(upperRight(decapVia13Bbox))

        reduced_decapVia13Bbox=list(x1bbox+0.0:y1bbox+0.0 x2bbox-0.0:y2bbox-0.0)

        
        M13_overlaps=dbProduceOverlap(cv reduced_decapVia13Bbox 32 list("M13" "drawing"))
        M14_overlaps=dbProduceOverlap(cv reduced_decapVia13Bbox 32 list("M14" "drawing"))
      


        flattened_M13_overlaps=foreach(mapcar overlap M13_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

        flattened_M14_overlaps=foreach(mapcar overlap M14_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach


       
       


        if(length(flattened_M13_overlaps)<2||length(flattened_M14_overlaps)<2
            then
            dbDeleteObject(decap_via13)
        );if
      
               
    );foreach

);procedure



