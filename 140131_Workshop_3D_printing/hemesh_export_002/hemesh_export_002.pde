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
    // the radius is set to 10, which is really small to display on the screen,
    // but is ideal for 3D printing. 1 pixel = 1 mm, so this would create a
    // geodesic sphere with a diameter of 20mm
    HEC_Geodesic geo = new HEC_Geodesic().setRadius( 10 ).setLevel( 1 );
    
    // create a mesh from the geometry
    mesh = new HE_Mesh( geo );
    
    // Slice the mesh so it has a flat bottom for 3D printing
    WB_Plane p = new WB_Plane( 0, 6, 0, 0, -1, 0 );
    HEM_Slice slice = new HEM_Slice();
    slice.setPlane( p );
    
    mesh.modify( slice );

    HET_Export.saveToSTL( mesh, sketchPath("mymodel.stl"), 1.0 );
    
    // create the renderer
    render = new WB_Render( this );
}

void draw()
{
    background( 0 );
    lights();

    translate( width/2, height/2 );
    // rotateY( radians( frameCount ) );
    rotateX( radians( frameCount ) );
    
    // Our model is very small, so we use the scale() function to draw it bigger.
    // The scale() function has no effect at all on the size of our mesh
    scale( 10 );
    
    // we need to reset the strokeweight after scaling, otherwise we will end up
    // with really fat strokes
    strokeWeight( 1.0f/10.0f );
    
    // draw the faces of the mesh
    noStroke();
    fill( 255 );
    render.drawFaces( mesh );
    
    // draw the edges of the mesh
    stroke( 0 );
    noFill();
    render.drawEdges( mesh );    
}
