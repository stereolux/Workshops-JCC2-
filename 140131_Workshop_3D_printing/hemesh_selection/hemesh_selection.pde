import processing.opengl.*;
import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.*;
import wblut.hemesh.*;
import wblut.geom.*;

// If you use Processing 2.x, you need to import the Iterator class.
// Imports that are not part of the Processing API have been removed from 2.x
// More information: http://wiki.processing.org/w/Changes
import java.util.Iterator;

HE_Mesh mesh;
WB_Render render;

void setup()
{
    size( 600, 600, OPENGL );
    
    createMesh();

    for ( int i = 0; i < 6; i++ ) {
        if ( random( 100 ) < 50 ) {
            subdivideMesh();
        
        } else {
            modifyMesh();
        
        }    
    
    }            
    // create the renderer
    render = new WB_Render( this );
}

void draw()
{
    background( 0 );
    lights();

    translate( width/2, height/2 );
    rotateY( radians( frameCount ) );
    rotateX( radians( frameCount ) );
    
    // draw the faces of the mesh
    noStroke();
    fill( 255 );
    render.drawFaces( mesh );
    
    // draw the edges of the mesh
    stroke( 0 );
    noFill();
    render.drawEdges( mesh );    
}
