# Workshop "Fabrication Numerique Avec Processing" avec Jan Vantomme - Nantes - 2014.01.31

Code &amp; documentation from the workshop on creating 3D models with HE_Mesh and Processing.

## Different types of 3D printing

You can print your 3D models in different qualities, materials, and sizes. We'll take a look at some of the most widely used techniques for 3D printing.

### Selective Laser Sintering

* https://vimeo.com/14737152
* http://en.wikipedia.org/wiki/Selective_laser_sintering

### Fused Deposition Modeling

* https://vimeo.com/14292165
* http://en.wikipedia.org/wiki/Fused_deposition_modeling
* Technique used by Makerbot http://www.makerbot.com/, Ultimaker http://www.ultimaker.com/

### Stereolitography

* https://vimeo.com/13939214
* http://en.wikipedia.org/wiki/Stereolithography
* Used by the Formlabs Form 1 printer — http://formlabs.com/

## Introduction to HE_Mesh

HE_Mesh is a Processing library for mesh creation and manipulation created by Frederik Vanhoutte. You can download the library right over here: http://hemesh.wblut.com/ The version we'll use during the workshop is HE_Mesh 1.8.2

### Creators

Creators are the building blocks to create 3D geometry with HE_Mesh. There are a lot of basic shapes available, like boxes, spheres, cones, cylinders, … Alternatively, you can also create custom meshes if you calculate the vertices and faces yourself.

#### Tutorial

* http://vormplus.be/blog/article/creating-3d-shapes-with-hemesh

#### Code Examples

* hemesh_cube
* hemesh_geodesics

### Displaying Meshes

To display a mesh on the screen, you need to use the WB_Render class. You'll use this class most of the times to display the faces or edges, but it can also be used to display vertices, vertex normals or face normals.

#### Tutorial

* http://vormplus.be/blog/article/exploring-the-hemesh-wb-render-class

#### Code Examples

* hemesh_render

### Subdividors

Subdividors are used to split every face in your model into more faces, usually to create a smoother model. The CatmullClark subdivider is probably the one you'll use the most.

#### Tutorial

* http://vormplus.be/blog/article/subdividing-a-mesh-with-hemesh

#### Code Examples

* hemesh_subdividor

### Modifiers

Modifiers are used to change the geometry of your mesh. These can be used to create a lattice, or to extrude the faces along their normal.

#### Tutorial

* http://vormplus.be/blog/article/modifying-a-mesh-with-hemesh

#### Code Example

* hemesh_modifier


### Selections

Sometimes it's useful to only select only certain parts of a mesh. These selections can be used with subdividers and modifiers.

#### Code Example

* hemesh_selection

### Slicing a Mesh

If you want to print your model on a printer that uses Fused Deposition Modeling (MakerBot, Ultimaker, RepRap), you need a flat surface at the bottom, because these printers are usually not able to print support structures in a different material. It's also a good practice to avoid overhanging structures, because these printers can't handle them that well.

#### Code Example

* hemesh_slice

### Exporting Meshes

To save your mesh for 3D printing, you'll need to use the HET_Export class and save your model as an STL file.

**Important:** Be careful when you create your mesh. When you export your mesh, 1 pixel = 1 mm. If you create a cube with an edge of 500 pixels (which is a good size to display a mesh on the screen), the exported mesh will be 500mm in size. You might need to scale your mesh down a bit so your object is actually printable. Another option is to create your mesh at the size you want, and use the `scale()` function in Processing to resize it when rendering on screen.

#### Code Examples

* hemesh_export_001
* hemesh_export_002

### Using the HE_Mesh documentation

HE_Mesh is a big library with lots of options. The good thing is that it also comes with examples for most of the creators, modifiers and subdividors. You can find these sketches in the examples folder of the library.

In the reference folder, you'll find the full Java documentation of the library. These are handy if you want to see the methods that are available to use to create geometry.

## Tools for Repairing Meshes

### Meshlab

http://meshlab.sourceforge.net/

### Netfabb

http://www.netfabb.com/

## Software used for 3D printing

### ReplicatorG
http://replicat.org/

