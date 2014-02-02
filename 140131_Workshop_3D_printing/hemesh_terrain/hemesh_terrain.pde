import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.*;
import wblut.hemesh.*;
import wblut.geom.*;

import java.util.Iterator;

HE_Mesh mesh;
WB_Render render;

void setup()
{
    size( 800, 800, OPENGL );
    
    HEC_Box box = new HEC_Box();
    box.setWidthSegments(10).setHeightSegments(1).setDepthSegments(10);
    box.setWidth( 200 ).setHeight( 10 ).setDepth( 200 );
    
    mesh = new HE_Mesh( box );
    
    modifyMesh();
    
    render = new WB_Render( this );
}

void draw()
{
    background( 0 );
    translate( width/2, height/2 );
    rotateY(mouseX*1.0f/width*TWO_PI);
    rotateX(mouseY*1.0f/height*TWO_PI);    
    lights();
    
    fill( 255 );
    noStroke();
    render.drawFaces( mesh );
    
    noFill();
    stroke( 0 );
    render.drawEdges( mesh );
}
