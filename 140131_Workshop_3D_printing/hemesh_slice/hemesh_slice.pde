import processing.opengl.*;
import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.*;
import wblut.hemesh.*;
import wblut.geom.*;

HE_Mesh mesh;
WB_Render render;

WB_Plane p;

void setup()
{
    size( 600, 600, OPENGL );
    
    // create the geodesic geometry
    HEC_Geodesic geo = new HEC_Geodesic().setRadius( 100 ).setLevel( 1 );
    
    // create a mesh from the geometry
    mesh = new HE_Mesh( geo );
    
    // Slice the mesh so it has a flat bottom for 3D printing
    p = new WB_Plane( 0, 60, 0, 0, -1, 0 );
    HEM_Slice slice = new HEM_Slice();
    slice.setPlane( p );
    
    mesh.modify( slice );
    
    // create the renderer
    render = new WB_Render( this );
}

void draw()
{
    background( 0 );
    lights();

    translate( width/2, height/2 );
    rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
    // rotateY( radians( frameCount ) );
   // rotateX( radians( frameCount ) );
    
    // draw the faces of the mesh
    noStroke();
    fill( 255 );
    render.drawFaces( mesh );
    
    // draw the edges of the mesh
    stroke( 0 );
    noFill();
    render.drawEdges( mesh );    
    
    stroke( 255, 0, 0 );
    // fill( 255, 0, 0, 128 );
    render.draw( p, 300 );
}
