(* Computation of the dominance frontier using the algorithm
 * of Cytron, Ferrante, Rosen, Wegman and Zadeck in TOPLAS 91
 *)

functor DominanceFrontiersFn (Dom : DOMINATOR_TREE) 
   : DOMINANCE_FRONTIERS =
struct

   structure Dom   = Dom
   structure G     = Graph
   structure A     = Array

   type dominance_frontiers = G.node_id list A.array

   fun DFs (Dom as G.GRAPH dom) =
   let val N           = #capacity dom ()
       val DF          = A.array(N,[]) : dominance_frontiers
       val G.GRAPH cfg = Dom.cfg Dom
       val methods     = Dom.methods Dom
       val immediately_dominates = #immediately_dominates methods
       fun computeDF X =
       let (* the successors in X that are not strictly dominated by X *)
           val S = foldr (fn ((_,Y,_),S) =>
                          if immediately_dominates(X,Y) 
                          then S else Y::S) [] (#out_edges cfg X)
             (* Nodes in the dominance frontier of n that are not
              * dominated by n's immediate dominator
              *)
           fun computeChild((_,Z,_),S) =
           let val DF_Z = computeDF Z
               val S    = foldr (fn (Y,S) =>
                             if immediately_dominates(X,Y) 
                             then S else Y::S) S DF_Z
           in  S
           end
           val S = foldl computeChild S (#out_edges dom X) 
       in
           A.update(DF,X,S);
           S
       end 

       val [root] = #entries dom ()
       val _ = computeDF root
   in
       DF
   end

end

(*
 * $Log: dominance-frontier.sml,v $
 * Revision 1.1.1.1  1998/11/16 21:48:47  george
 *   Version 110.10
 *
 *)
