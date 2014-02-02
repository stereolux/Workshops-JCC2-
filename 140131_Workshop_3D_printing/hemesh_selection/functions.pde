void createMesh()
{
    // create the cube geometry
    HEC_Cube cube = new HEC_Cube();
    cube.setEdge( 200 );
    cube.setDepthSegments( 4 );
    cube.setHeightSegments( 4 );
    cube.setWidthSegments( 4 );
    
    // create a mesh from the geometry
    mesh = new HE_Mesh( cube );    
}

void subdivideMesh()
{
    HE_Selection selection = new HE_Selection( mesh );
    
    HE_Face f;
    Iterator<HE_Face> fItr = mesh.fItr();
    while ( fItr.hasNext() ) {
        f = fItr.next();
        if ( random( 100 ) < 60 ) {
            selection.add( f );
        }
    }
    
    HES_Planar planar = new HES_Planar();
    planar.setRandom( true );
    planar.setRange( 0.4 );
    
    // modify the mesh
    mesh.subdivideSelected( planar, selection );
   // mesh.subdivide( planar );
}

void modifyMesh()
{
    HE_Selection selection = new HE_Selection( mesh );
    
    HE_Face f;
    Iterator<HE_Face> fItr = mesh.fItr();
    while ( fItr.hasNext() ) {
        f = fItr.next();
        if ( random( 100 ) < 20 ) {
            selection.add( f );
        }
    }
    
    
    // create the extruder
    HEM_Extrude ext = new HEM_Extrude();
    ext.setDistance( 20 ).setChamfer( 0.5 );
    
    // modify the mesh
    mesh.modifySelected( ext, selection );
}
