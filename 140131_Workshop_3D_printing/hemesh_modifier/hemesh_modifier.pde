import processing.opengl.*;
import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.*;
import wblut.hemesh.*;
import wblut.geom.*;

HE_Mesh mesh;
WB_Render render;

void setup()
{
    size( 600, 600, OPENGL );
    
    // create the cube geometry
    HEC_Cube cube = new HEC_Cube();
    cube.setEdge( 200 );
    cube.setDepthSegments( 1 );
    cube.setHeightSegments( 2 );
    cube.setWidthSegments( 1 );
    
    // create a mesh from the geometry
    mesh = new HE_Mesh( cube );    
    
    // create the extruder
    HEM_Extrude ext = new HEM_Extrude();
    ext.setDistance( 20 ).setChamfer( 0.5 );
    
    // modify the mesh
   // mesh.modify( ext );
    
    // create a lattice
    HEM_Lattice lat = new HEM_Lattice().setWidth( 30 ).setDepth( 30 );
    
    // modify the mesh
    mesh.modify( lat );
    
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
