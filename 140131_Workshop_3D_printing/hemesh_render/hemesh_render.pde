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
    
    // create the geodesic geometry
    HEC_Geodesic geo = new HEC_Geodesic().setRadius( 100 ).setLevel( 1 );
    
    // create a mesh from the geometry
    mesh = new HE_Mesh( geo );    
    
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
    
    // draw the faces of the mesh (smooth)
    noStroke();
    fill( 255 );
    render.drawFacesSmooth( mesh );
    
    // draw the edges of the mesh
    stroke( 0 );
    noFill();
    render.drawEdges( mesh );
    
    // draw the vertices of the mesh
    stroke( 255, 0, 0 );
    noFill();
    render.drawVertices( 6, mesh );
    
    // draw the vertex normals
    stroke( 0, 255, 0 );
    noFill();
    render.drawVertexNormals( 20, mesh );

    // draw the face normals
    stroke( 0, 0, 255 );
    noFill();
    render.drawFaceNormals( 20, mesh );

}
