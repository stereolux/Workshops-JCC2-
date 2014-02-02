void modifyMesh()
{
    Iterator<HE_Vertex> vItr = mesh.vItr();
    
    HE_Vertex v;
    
    int counter = 0;
    
    while ( vItr.hasNext() ) {
        v = vItr.next();
        if ( counter < 121 ) {
            v.y += random( 50, 100 ); // use values from a dataset instead of random numbers
        }
        counter++;
    }

}
