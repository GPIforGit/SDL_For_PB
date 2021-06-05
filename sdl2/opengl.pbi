;
; OpenGL - Wraper
;
; Add in the SDL_Config-DeclareModule the needed version of openGL
; for example:
;
; DeclareModule SDL_Config
;   ;we want OpenGL-Version 3.3
;   #GL_MAJOR_VERSION = 3
;   #GL_MINOR_VERSION = 3
; EndDeclareModule
;
; You must create a GLContext in SDL first
; then call GL::Init() and openGL is initalized.
;
; All macros and functions are in the module GL. so when you want to to translate
; this c statement, remove the gl and gl_ - prefix with GL::
;   glClear(GL_COLOR_BUFFER_BIT)
; write:
;   gl::Clear(GL::#COLOR_BUFFER_BIT)
; instead.
;
; with GL::Quit() you can remove all gl-functions.
;
; NOTE, because of some conflicts with PB, there are some exceptions:
; GL_2D               = GL::#_2D
; GL_3D               = GL::#_3D
; GL_3D_COLOR         = GL::#_3D_COLOR
; GL_3D_COLOR_TEXTURE = GL::#_3D_COLOR_TEXTURE
; GL_4D_COLOR_TEXUTE  = GL::#_4D_COLOR_TEXTURE
; GL_2_BYTES          = GL::#_2_BYTES
; GL_3_BYTES          = GL::#_3_BYTES
; GL_4_BYTES          = GL::#_4_BYTES
; GL_RED              = GL::#RED_
; GL_GREEN            = GL::#GREEN_
; GL_BLUE             = GL::#BLUE_
; GL_READ_WRITE       = GL::#READ_WRITE_
;
;  Copyright (c) 2007 The Khronos Group Inc.
;  
;  Permission is hereby granted, free of charge, to any person obtaining a
;  copy of this software and/or associated documentation files (the
;  "Materials"), to deal in the Materials without restriction, including
;  without limitation the rights to use, copy, modify, merge, publish,
;  distribute, sublicense, and/or sell copies of the Materials, and to
;  permit persons to whom the Materials are furnished to do so, subject to
;  the following conditions:
;  
;  The above copyright notice and this permission notice shall be included
;  in all copies or substantial portions of the Materials.
;  
;  THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;  MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
CompilerIf Not Defined(SDL,#PB_Module)
  CompilerError "[opengl] Missing SDL!"
CompilerEndIf
CompilerIf _SDL_Config::#GL_MAJOR_VERSION = 0
  CompilerError "[opengl] Missing SDL_Config::#GL_Major_Version"
CompilerEndIf
DeclareModule _gl
  #NEEDEDVERSION = sdl::VERSIONNUM(_SDL_Config::#GL_MAJOR_VERSION, _SDL_Config::#GL_MINOR_VERSION ,0)
  Macro GL_VERSION_ATLEAST(X, Y, Z): (_gl::#NEEDEDVERSION >= sdl::VERSIONNUM(X, Y, Z)) :EndMacro
  Structure func
    name.s
    *pointer.integer
    version.l
  EndStructure
  Global NewList functions.func()
;-----------------------
;- _opengl_prot.pbi
;{

  PrototypeC _prot_glAccum( op.l, value.f )
  PrototypeC _prot_glAlphaFunc( func.l, ref.f )
  PrototypeC.a _prot_glAreTexturesResident( n.l, *textures.long, *residences.ascii )
  PrototypeC _prot_glArrayElement( i.l )
  PrototypeC _prot_glBegin( mode.l )
  PrototypeC _prot_glBindTexture( target.l, texture.l )
  PrototypeC _prot_glBitmap( width.l, height.l, xorig.f, yorig.f, xmove.f, ymove.f, *bitmap.ascii )
  PrototypeC _prot_glBlendFunc( sfactor.l, dfactor.l )
  PrototypeC _prot_glCallList( list.l )
  PrototypeC _prot_glCallLists( n.l, type.l, *lists )
  PrototypeC _prot_glClear( mask.l )
  PrototypeC _prot_glClearAccum( red.f, green.f, blue.f, alpha.f )
  PrototypeC _prot_glClearColor( red.f, green.f, blue.f, alpha.f )
  PrototypeC _prot_glClearDepth( depth.d )
  PrototypeC _prot_glClearIndex( c.f )
  PrototypeC _prot_glClearStencil( s.l )
  PrototypeC _prot_glClipPlane( plane.l, *equation.double )
  PrototypeC _prot_glColor3b( red.b, green.b, blue.b )
  PrototypeC _prot_glColor3bv( *v.byte )
  PrototypeC _prot_glColor3d( red.d, green.d, blue.d )
  PrototypeC _prot_glColor3dv( *v.double )
  PrototypeC _prot_glColor3f( red.f, green.f, blue.f )
  PrototypeC _prot_glColor3fv( *v.float )
  PrototypeC _prot_glColor3i( red.l, green.l, blue.l )
  PrototypeC _prot_glColor3iv( *v.long )
  PrototypeC _prot_glColor3s( red.w, green.w, blue.w )
  PrototypeC _prot_glColor3sv( *v.word )
  PrototypeC _prot_glColor3ub( red.a, green.a, blue.a )
  PrototypeC _prot_glColor3ubv( *v.ascii )
  PrototypeC _prot_glColor3ui( red.l, green.l, blue.l )
  PrototypeC _prot_glColor3uiv( *v.long )
  PrototypeC _prot_glColor3us( red.u, green.u, blue.u )
  PrototypeC _prot_glColor3usv( *v.unicode )
  PrototypeC _prot_glColor4b( red.b, green.b, blue.b, alpha.b )
  PrototypeC _prot_glColor4bv( *v.byte )
  PrototypeC _prot_glColor4d( red.d, green.d, blue.d, alpha.d )
  PrototypeC _prot_glColor4dv( *v.double )
  PrototypeC _prot_glColor4f( red.f, green.f, blue.f, alpha.f )
  PrototypeC _prot_glColor4fv( *v.float )
  PrototypeC _prot_glColor4i( red.l, green.l, blue.l, alpha.l )
  PrototypeC _prot_glColor4iv( *v.long )
  PrototypeC _prot_glColor4s( red.w, green.w, blue.w, alpha.w )
  PrototypeC _prot_glColor4sv( *v.word )
  PrototypeC _prot_glColor4ub( red.a, green.a, blue.a, alpha.a )
  PrototypeC _prot_glColor4ubv( *v.ascii )
  PrototypeC _prot_glColor4ui( red.l, green.l, blue.l, alpha.l )
  PrototypeC _prot_glColor4uiv( *v.long )
  PrototypeC _prot_glColor4us( red.u, green.u, blue.u, alpha.u )
  PrototypeC _prot_glColor4usv( *v.unicode )
  PrototypeC _prot_glColorMask( red.a, green.a, blue.a, alpha.a )
  PrototypeC _prot_glColorMaterial( face.l, mode.l )
  PrototypeC _prot_glColorPointer( size.l, type.l, stride.l, *pointer )
  PrototypeC _prot_glCopyPixels( x.l, y.l, width.l, height.l, type.l )
  PrototypeC _prot_glCopyTexImage1D( target.l, level.l, internalFormat.l, x.l, y.l, width.l, border.l )
  PrototypeC _prot_glCopyTexImage2D( target.l, level.l, internalFormat.l, x.l, y.l, width.l, height.l, border.l )
  PrototypeC _prot_glCopyTexSubImage1D( target.l, level.l, xoffset.l, x.l, y.l, width.l )
  PrototypeC _prot_glCopyTexSubImage2D( target.l, level.l, xoffset.l, yoffset.l, x.l, y.l, width.l, height.l )
  PrototypeC _prot_glCullFace( mode.l )
  PrototypeC _prot_glDeleteLists( list.l, range.l )
  PrototypeC _prot_glDeleteTextures( n.l, *textures.long )
  PrototypeC _prot_glDepthFunc( func.l )
  PrototypeC _prot_glDepthMask( flag.a )
  PrototypeC _prot_glDepthRange( zNear.d, zFar.d )
  PrototypeC _prot_glDisable( cap.l )
  PrototypeC _prot_glDisableClientState( array.l )
  PrototypeC _prot_glDrawArrays( mode.l, first.l, count.l )
  PrototypeC _prot_glDrawBuffer( mode.l )
  PrototypeC _prot_glDrawElements( mode.l, count.l, type.l, *indices )
  PrototypeC _prot_glDrawPixels( width.l, height.l, format.l, type.l, *pixels )
  PrototypeC _prot_glEdgeFlag( flag.a )
  PrototypeC _prot_glEdgeFlagPointer( stride.l, *pointer )
  PrototypeC _prot_glEdgeFlagv( *flag.ascii )
  PrototypeC _prot_glEnable( cap.l )
  PrototypeC _prot_glEnableClientState( array.l )
  PrototypeC _prot_glEnd(  )
  PrototypeC _prot_glEndList(  )
  PrototypeC _prot_glEvalCoord1d( u.d )
  PrototypeC _prot_glEvalCoord1dv( *u.double )
  PrototypeC _prot_glEvalCoord1f( u.f )
  PrototypeC _prot_glEvalCoord1fv( *u.float )
  PrototypeC _prot_glEvalCoord2d( u.d, v.d )
  PrototypeC _prot_glEvalCoord2dv( *u.double )
  PrototypeC _prot_glEvalCoord2f( u.f, v.f )
  PrototypeC _prot_glEvalCoord2fv( *u.float )
  PrototypeC _prot_glEvalMesh1( mode.l, i1.l, i2.l )
  PrototypeC _prot_glEvalMesh2( mode.l, i1.l, i2.l, j1.l, j2.l )
  PrototypeC _prot_glEvalPoint1( i.l )
  PrototypeC _prot_glEvalPoint2( i.l, j.l )
  PrototypeC _prot_glFeedbackBuffer( size.l, type.l, *buffer.float )
  PrototypeC _prot_glFinish(  )
  PrototypeC _prot_glFlush(  )
  PrototypeC _prot_glFogf( pname.l, param.f )
  PrototypeC _prot_glFogfv( pname.l, *params.float )
  PrototypeC _prot_glFogi( pname.l, param.l )
  PrototypeC _prot_glFogiv( pname.l, *params.long )
  PrototypeC _prot_glFrontFace( mode.l )
  PrototypeC _prot_glFrustum( left.d, right.d, bottom.d, top.d, zNear.d, zFar.d )
  PrototypeC.l _prot_glGenLists( range.l )
  PrototypeC _prot_glGenTextures( n.l, *textures.long )
  PrototypeC _prot_glGetBooleanv( pname.l, *params.ascii )
  PrototypeC _prot_glGetClipPlane( plane.l, *equation.double )
  PrototypeC _prot_glGetDoublev( pname.l, *params.double )
  PrototypeC.l _prot_glGetError(  )
  PrototypeC _prot_glGetFloatv( pname.l, *params.float )
  PrototypeC _prot_glGetIntegerv( pname.l, *params.long )
  PrototypeC _prot_glGetLightfv( light.l, pname.l, *params.float )
  PrototypeC _prot_glGetLightiv( light.l, pname.l, *params.long )
  PrototypeC _prot_glGetMapdv( target.l, query.l, *v.double )
  PrototypeC _prot_glGetMapfv( target.l, query.l, *v.float )
  PrototypeC _prot_glGetMapiv( target.l, query.l, *v.long )
  PrototypeC _prot_glGetMaterialfv( face.l, pname.l, *params.float )
  PrototypeC _prot_glGetMaterialiv( face.l, pname.l, *params.long )
  PrototypeC _prot_glGetPixelMapfv( map.l, *values.float )
  PrototypeC _prot_glGetPixelMapuiv( map.l, *values.long )
  PrototypeC _prot_glGetPixelMapusv( map.l, *values.unicode )
  PrototypeC _prot_glGetPointerv( pname.l, *pp_params )
  PrototypeC _prot_glGetPolygonStipple( *mask.ascii )
  PrototypeC.i _prot_glGetString( name.l )
  PrototypeC _prot_glGetTexEnvfv( target.l, pname.l, *params.float )
  PrototypeC _prot_glGetTexEnviv( target.l, pname.l, *params.long )
  PrototypeC _prot_glGetTexGendv( coord.l, pname.l, *params.double )
  PrototypeC _prot_glGetTexGenfv( coord.l, pname.l, *params.float )
  PrototypeC _prot_glGetTexGeniv( coord.l, pname.l, *params.long )
  PrototypeC _prot_glGetTexImage( target.l, level.l, format.l, type.l, *pixels )
  PrototypeC _prot_glGetTexLevelParameterfv( target.l, level.l, pname.l, *params.float )
  PrototypeC _prot_glGetTexLevelParameteriv( target.l, level.l, pname.l, *params.long )
  PrototypeC _prot_glGetTexParameterfv( target.l, pname.l, *params.float )
  PrototypeC _prot_glGetTexParameteriv( target.l, pname.l, *params.long )
  PrototypeC _prot_glHint( target.l, mode.l )
  PrototypeC _prot_glIndexMask( mask.l )
  PrototypeC _prot_glIndexPointer( type.l, stride.l, *pointer )
  PrototypeC _prot_glIndexd( c.d )
  PrototypeC _prot_glIndexdv( *c.double )
  PrototypeC _prot_glIndexf( c.f )
  PrototypeC _prot_glIndexfv( *c.float )
  PrototypeC _prot_glIndexi( c.l )
  PrototypeC _prot_glIndexiv( *c.long )
  PrototypeC _prot_glIndexs( c.w )
  PrototypeC _prot_glIndexsv( *c.word )
  PrototypeC _prot_glIndexub( c.a )
  PrototypeC _prot_glIndexubv( *c.ascii )
  PrototypeC _prot_glInitNames(  )
  PrototypeC _prot_glInterleavedArrays( format.l, stride.l, *pointer )
  PrototypeC.a _prot_glIsEnabled( cap.l )
  PrototypeC.a _prot_glIsList( list.l )
  PrototypeC.a _prot_glIsTexture( texture.l )
  PrototypeC _prot_glLightModelf( pname.l, param.f )
  PrototypeC _prot_glLightModelfv( pname.l, *params.float )
  PrototypeC _prot_glLightModeli( pname.l, param.l )
  PrototypeC _prot_glLightModeliv( pname.l, *params.long )
  PrototypeC _prot_glLightf( light.l, pname.l, param.f )
  PrototypeC _prot_glLightfv( light.l, pname.l, *params.float )
  PrototypeC _prot_glLighti( light.l, pname.l, param.l )
  PrototypeC _prot_glLightiv( light.l, pname.l, *params.long )
  PrototypeC _prot_glLineStipple( factor.l, pattern.u )
  PrototypeC _prot_glLineWidth( width.f )
  PrototypeC _prot_glListBase( base.l )
  PrototypeC _prot_glLoadIdentity(  )
  PrototypeC _prot_glLoadMatrixd( *m.double )
  PrototypeC _prot_glLoadMatrixf( *m.float )
  PrototypeC _prot_glLoadName( name.l )
  PrototypeC _prot_glLogicOp( opcode.l )
  PrototypeC _prot_glMap1d( target.l, u1.d, u2.d, stride.l, order.l, *points.double )
  PrototypeC _prot_glMap1f( target.l, u1.f, u2.f, stride.l, order.l, *points.float )
  PrototypeC _prot_glMap2d( target.l, u1.d, u2.d, ustride.l, uorder.l, v1.d, v2.d, vstride.l, vorder.l, *points.double )
  PrototypeC _prot_glMap2f( target.l, u1.f, u2.f, ustride.l, uorder.l, v1.f, v2.f, vstride.l, vorder.l, *points.float )
  PrototypeC _prot_glMapGrid1d( un.l, u1.d, u2.d )
  PrototypeC _prot_glMapGrid1f( un.l, u1.f, u2.f )
  PrototypeC _prot_glMapGrid2d( un.l, u1.d, u2.d, vn.l, v1.d, v2.d )
  PrototypeC _prot_glMapGrid2f( un.l, u1.f, u2.f, vn.l, v1.f, v2.f )
  PrototypeC _prot_glMaterialf( face.l, pname.l, param.f )
  PrototypeC _prot_glMaterialfv( face.l, pname.l, *params.float )
  PrototypeC _prot_glMateriali( face.l, pname.l, param.l )
  PrototypeC _prot_glMaterialiv( face.l, pname.l, *params.long )
  PrototypeC _prot_glMatrixMode( mode.l )
  PrototypeC _prot_glMultMatrixd( *m.double )
  PrototypeC _prot_glMultMatrixf( *m.float )
  PrototypeC _prot_glNewList( list.l, mode.l )
  PrototypeC _prot_glNormal3b( nx.b, ny.b, nz.b )
  PrototypeC _prot_glNormal3bv( *v.byte )
  PrototypeC _prot_glNormal3d( nx.d, ny.d, nz.d )
  PrototypeC _prot_glNormal3dv( *v.double )
  PrototypeC _prot_glNormal3f( nx.f, ny.f, nz.f )
  PrototypeC _prot_glNormal3fv( *v.float )
  PrototypeC _prot_glNormal3i( nx.l, ny.l, nz.l )
  PrototypeC _prot_glNormal3iv( *v.long )
  PrototypeC _prot_glNormal3s( nx.w, ny.w, nz.w )
  PrototypeC _prot_glNormal3sv( *v.word )
  PrototypeC _prot_glNormalPointer( type.l, stride.l, *pointer )
  PrototypeC _prot_glOrtho( left.d, right.d, bottom.d, top.d, zNear.d, zFar.d )
  PrototypeC _prot_glPassThrough( token.f )
  PrototypeC _prot_glPixelMapfv( map.l, mapsize.l, *values.float )
  PrototypeC _prot_glPixelMapuiv( map.l, mapsize.l, *values.long )
  PrototypeC _prot_glPixelMapusv( map.l, mapsize.l, *values.unicode )
  PrototypeC _prot_glPixelStoref( pname.l, param.f )
  PrototypeC _prot_glPixelStorei( pname.l, param.l )
  PrototypeC _prot_glPixelTransferf( pname.l, param.f )
  PrototypeC _prot_glPixelTransferi( pname.l, param.l )
  PrototypeC _prot_glPixelZoom( xfactor.f, yfactor.f )
  PrototypeC _prot_glPointSize( size.f )
  PrototypeC _prot_glPolygonMode( face.l, mode.l )
  PrototypeC _prot_glPolygonOffset( factor.f, units.f )
  PrototypeC _prot_glPolygonStipple( *mask.ascii )
  PrototypeC _prot_glPopAttrib(  )
  PrototypeC _prot_glPopClientAttrib(  )
  PrototypeC _prot_glPopMatrix(  )
  PrototypeC _prot_glPopName(  )
  PrototypeC _prot_glPrioritizeTextures( n.l, *textures.long, *priorities.float )
  PrototypeC _prot_glPushAttrib( mask.l )
  PrototypeC _prot_glPushClientAttrib( mask.l )
  PrototypeC _prot_glPushMatrix(  )
  PrototypeC _prot_glPushName( name.l )
  PrototypeC _prot_glRasterPos2d( x.d, y.d )
  PrototypeC _prot_glRasterPos2dv( *v.double )
  PrototypeC _prot_glRasterPos2f( x.f, y.f )
  PrototypeC _prot_glRasterPos2fv( *v.float )
  PrototypeC _prot_glRasterPos2i( x.l, y.l )
  PrototypeC _prot_glRasterPos2iv( *v.long )
  PrototypeC _prot_glRasterPos2s( x.w, y.w )
  PrototypeC _prot_glRasterPos2sv( *v.word )
  PrototypeC _prot_glRasterPos3d( x.d, y.d, z.d )
  PrototypeC _prot_glRasterPos3dv( *v.double )
  PrototypeC _prot_glRasterPos3f( x.f, y.f, z.f )
  PrototypeC _prot_glRasterPos3fv( *v.float )
  PrototypeC _prot_glRasterPos3i( x.l, y.l, z.l )
  PrototypeC _prot_glRasterPos3iv( *v.long )
  PrototypeC _prot_glRasterPos3s( x.w, y.w, z.w )
  PrototypeC _prot_glRasterPos3sv( *v.word )
  PrototypeC _prot_glRasterPos4d( x.d, y.d, z.d, w.d )
  PrototypeC _prot_glRasterPos4dv( *v.double )
  PrototypeC _prot_glRasterPos4f( x.f, y.f, z.f, w.f )
  PrototypeC _prot_glRasterPos4fv( *v.float )
  PrototypeC _prot_glRasterPos4i( x.l, y.l, z.l, w.l )
  PrototypeC _prot_glRasterPos4iv( *v.long )
  PrototypeC _prot_glRasterPos4s( x.w, y.w, z.w, w.w )
  PrototypeC _prot_glRasterPos4sv( *v.word )
  PrototypeC _prot_glReadBuffer( mode.l )
  PrototypeC _prot_glReadPixels( x.l, y.l, width.l, height.l, format.l, type.l, *pixels )
  PrototypeC _prot_glRectd( x1.d, y1.d, x2.d, y2.d )
  PrototypeC _prot_glRectdv( *v1.double, *v2.double )
  PrototypeC _prot_glRectf( x1.f, y1.f, x2.f, y2.f )
  PrototypeC _prot_glRectfv( *v1.float, *v2.float )
  PrototypeC _prot_glRecti( x1.l, y1.l, x2.l, y2.l )
  PrototypeC _prot_glRectiv( *v1.long, *v2.long )
  PrototypeC _prot_glRects( x1.w, y1.w, x2.w, y2.w )
  PrototypeC _prot_glRectsv( *v1.word, *v2.word )
  PrototypeC.l _prot_glRenderMode( mode.l )
  PrototypeC _prot_glRotated( angle.d, x.d, y.d, z.d )
  PrototypeC _prot_glRotatef( angle.f, x.f, y.f, z.f )
  PrototypeC _prot_glScaled( x.d, y.d, z.d )
  PrototypeC _prot_glScalef( x.f, y.f, z.f )
  PrototypeC _prot_glScissor( x.l, y.l, width.l, height.l )
  PrototypeC _prot_glSelectBuffer( size.l, *buffer.long )
  PrototypeC _prot_glShadeModel( mode.l )
  PrototypeC _prot_glStencilFunc( func.l, ref.l, mask.l )
  PrototypeC _prot_glStencilMask( mask.l )
  PrototypeC _prot_glStencilOp( fail.l, zfail.l, zpass.l )
  PrototypeC _prot_glTexCoord1d( s.d )
  PrototypeC _prot_glTexCoord1dv( *v.double )
  PrototypeC _prot_glTexCoord1f( s.f )
  PrototypeC _prot_glTexCoord1fv( *v.float )
  PrototypeC _prot_glTexCoord1i( s.l )
  PrototypeC _prot_glTexCoord1iv( *v.long )
  PrototypeC _prot_glTexCoord1s( s.w )
  PrototypeC _prot_glTexCoord1sv( *v.word )
  PrototypeC _prot_glTexCoord2d( s.d, t.d )
  PrototypeC _prot_glTexCoord2dv( *v.double )
  PrototypeC _prot_glTexCoord2f( s.f, t.f )
  PrototypeC _prot_glTexCoord2fv( *v.float )
  PrototypeC _prot_glTexCoord2i( s.l, t.l )
  PrototypeC _prot_glTexCoord2iv( *v.long )
  PrototypeC _prot_glTexCoord2s( s.w, t.w )
  PrototypeC _prot_glTexCoord2sv( *v.word )
  PrototypeC _prot_glTexCoord3d( s.d, t.d, r.d )
  PrototypeC _prot_glTexCoord3dv( *v.double )
  PrototypeC _prot_glTexCoord3f( s.f, t.f, r.f )
  PrototypeC _prot_glTexCoord3fv( *v.float )
  PrototypeC _prot_glTexCoord3i( s.l, t.l, r.l )
  PrototypeC _prot_glTexCoord3iv( *v.long )
  PrototypeC _prot_glTexCoord3s( s.w, t.w, r.w )
  PrototypeC _prot_glTexCoord3sv( *v.word )
  PrototypeC _prot_glTexCoord4d( s.d, t.d, r.d, q.d )
  PrototypeC _prot_glTexCoord4dv( *v.double )
  PrototypeC _prot_glTexCoord4f( s.f, t.f, r.f, q.f )
  PrototypeC _prot_glTexCoord4fv( *v.float )
  PrototypeC _prot_glTexCoord4i( s.l, t.l, r.l, q.l )
  PrototypeC _prot_glTexCoord4iv( *v.long )
  PrototypeC _prot_glTexCoord4s( s.w, t.w, r.w, q.w )
  PrototypeC _prot_glTexCoord4sv( *v.word )
  PrototypeC _prot_glTexCoordPointer( size.l, type.l, stride.l, *pointer )
  PrototypeC _prot_glTexEnvf( target.l, pname.l, param.f )
  PrototypeC _prot_glTexEnvfv( target.l, pname.l, *params.float )
  PrototypeC _prot_glTexEnvi( target.l, pname.l, param.l )
  PrototypeC _prot_glTexEnviv( target.l, pname.l, *params.long )
  PrototypeC _prot_glTexGend( coord.l, pname.l, param.d )
  PrototypeC _prot_glTexGendv( coord.l, pname.l, *params.double )
  PrototypeC _prot_glTexGenf( coord.l, pname.l, param.f )
  PrototypeC _prot_glTexGenfv( coord.l, pname.l, *params.float )
  PrototypeC _prot_glTexGeni( coord.l, pname.l, param.l )
  PrototypeC _prot_glTexGeniv( coord.l, pname.l, *params.long )
  PrototypeC _prot_glTexImage1D( target.l, level.l, internalformat.l, width.l, border.l, format.l, type.l, *pixels )
  PrototypeC _prot_glTexImage2D( target.l, level.l, internalformat.l, width.l, height.l, border.l, format.l, type.l, *pixels )
  PrototypeC _prot_glTexParameterf( target.l, pname.l, param.f )
  PrototypeC _prot_glTexParameterfv( target.l, pname.l, *params.float )
  PrototypeC _prot_glTexParameteri( target.l, pname.l, param.l )
  PrototypeC _prot_glTexParameteriv( target.l, pname.l, *params.long )
  PrototypeC _prot_glTexSubImage1D( target.l, level.l, xoffset.l, width.l, format.l, type.l, *pixels )
  PrototypeC _prot_glTexSubImage2D( target.l, level.l, xoffset.l, yoffset.l, width.l, height.l, format.l, type.l, *pixels )
  PrototypeC _prot_glTranslated( x.d, y.d, z.d )
  PrototypeC _prot_glTranslatef( x.f, y.f, z.f )
  PrototypeC _prot_glVertex2d( x.d, y.d )
  PrototypeC _prot_glVertex2dv( *v.double )
  PrototypeC _prot_glVertex2f( x.f, y.f )
  PrototypeC _prot_glVertex2fv( *v.float )
  PrototypeC _prot_glVertex2i( x.l, y.l )
  PrototypeC _prot_glVertex2iv( *v.long )
  PrototypeC _prot_glVertex2s( x.w, y.w )
  PrototypeC _prot_glVertex2sv( *v.word )
  PrototypeC _prot_glVertex3d( x.d, y.d, z.d )
  PrototypeC _prot_glVertex3dv( *v.double )
  PrototypeC _prot_glVertex3f( x.f, y.f, z.f )
  PrototypeC _prot_glVertex3fv( *v.float )
  PrototypeC _prot_glVertex3i( x.l, y.l, z.l )
  PrototypeC _prot_glVertex3iv( *v.long )
  PrototypeC _prot_glVertex3s( x.w, y.w, z.w )
  PrototypeC _prot_glVertex3sv( *v.word )
  PrototypeC _prot_glVertex4d( x.d, y.d, z.d, w.d )
  PrototypeC _prot_glVertex4dv( *v.double )
  PrototypeC _prot_glVertex4f( x.f, y.f, z.f, w.f )
  PrototypeC _prot_glVertex4fv( *v.float )
  PrototypeC _prot_glVertex4i( x.l, y.l, z.l, w.l )
  PrototypeC _prot_glVertex4iv( *v.long )
  PrototypeC _prot_glVertex4s( x.w, y.w, z.w, w.w )
  PrototypeC _prot_glVertex4sv( *v.word )
  PrototypeC _prot_glVertexPointer( size.l, type.l, stride.l, *pointer )
  PrototypeC _prot_glViewport( x.l, y.l, width.l, height.l )
  PrototypeC PFNGLCOPYTEXSUBIMAGE3DPROC( target.l, level.l, xoffset.l, yoffset.l, zoffset.l, x.l, y.l, width.l, height.l )
  PrototypeC PFNGLDRAWRANGEELEMENTSPROC( mode.l, start.l, _end.l, count.l, type.l, *indices )
  PrototypeC PFNGLTEXIMAGE3DPROC( target.l, level.l, internalFormat.l, width.l, height.l, depth.l, border.l, format.l, type.l, *pixels )
  PrototypeC PFNGLTEXSUBIMAGE3DPROC( target.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, format.l, type.l, *pixels )
  PrototypeC PFNGLACTIVETEXTUREPROC( texture.l )
  PrototypeC PFNGLCLIENTACTIVETEXTUREPROC( texture.l )
  PrototypeC PFNGLCOMPRESSEDTEXIMAGE1DPROC( target.l, level.l, internalformat.l, width.l, border.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXIMAGE2DPROC( target.l, level.l, internalformat.l, width.l, height.l, border.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXIMAGE3DPROC( target.l, level.l, internalformat.l, width.l, height.l, depth.l, border.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC( target.l, level.l, xoffset.l, width.l, format.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC( target.l, level.l, xoffset.l, yoffset.l, width.l, height.l, format.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC( target.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, format.l, imageSize.l, *data )
  PrototypeC PFNGLGETCOMPRESSEDTEXIMAGEPROC( target.l, lod.l, *img )
  PrototypeC PFNGLLOADTRANSPOSEMATRIXDPROC( *array_16_m )
  PrototypeC PFNGLLOADTRANSPOSEMATRIXFPROC( *array_16_m )
  PrototypeC PFNGLMULTTRANSPOSEMATRIXDPROC( *array_16_m )
  PrototypeC PFNGLMULTTRANSPOSEMATRIXFPROC( *array_16_m )
  PrototypeC PFNGLMULTITEXCOORD1DPROC( target.l, s.d )
  PrototypeC PFNGLMULTITEXCOORD1DVPROC( target.l, *v.double )
  PrototypeC PFNGLMULTITEXCOORD1FPROC( target.l, s.f )
  PrototypeC PFNGLMULTITEXCOORD1FVPROC( target.l, *v.float )
  PrototypeC PFNGLMULTITEXCOORD1IPROC( target.l, s.l )
  PrototypeC PFNGLMULTITEXCOORD1IVPROC( target.l, *v.long )
  PrototypeC PFNGLMULTITEXCOORD1SPROC( target.l, s.w )
  PrototypeC PFNGLMULTITEXCOORD1SVPROC( target.l, *v.word )
  PrototypeC PFNGLMULTITEXCOORD2DPROC( target.l, s.d, t.d )
  PrototypeC PFNGLMULTITEXCOORD2DVPROC( target.l, *v.double )
  PrototypeC PFNGLMULTITEXCOORD2FPROC( target.l, s.f, t.f )
  PrototypeC PFNGLMULTITEXCOORD2FVPROC( target.l, *v.float )
  PrototypeC PFNGLMULTITEXCOORD2IPROC( target.l, s.l, t.l )
  PrototypeC PFNGLMULTITEXCOORD2IVPROC( target.l, *v.long )
  PrototypeC PFNGLMULTITEXCOORD2SPROC( target.l, s.w, t.w )
  PrototypeC PFNGLMULTITEXCOORD2SVPROC( target.l, *v.word )
  PrototypeC PFNGLMULTITEXCOORD3DPROC( target.l, s.d, t.d, r.d )
  PrototypeC PFNGLMULTITEXCOORD3DVPROC( target.l, *v.double )
  PrototypeC PFNGLMULTITEXCOORD3FPROC( target.l, s.f, t.f, r.f )
  PrototypeC PFNGLMULTITEXCOORD3FVPROC( target.l, *v.float )
  PrototypeC PFNGLMULTITEXCOORD3IPROC( target.l, s.l, t.l, r.l )
  PrototypeC PFNGLMULTITEXCOORD3IVPROC( target.l, *v.long )
  PrototypeC PFNGLMULTITEXCOORD3SPROC( target.l, s.w, t.w, r.w )
  PrototypeC PFNGLMULTITEXCOORD3SVPROC( target.l, *v.word )
  PrototypeC PFNGLMULTITEXCOORD4DPROC( target.l, s.d, t.d, r.d, q.d )
  PrototypeC PFNGLMULTITEXCOORD4DVPROC( target.l, *v.double )
  PrototypeC PFNGLMULTITEXCOORD4FPROC( target.l, s.f, t.f, r.f, q.f )
  PrototypeC PFNGLMULTITEXCOORD4FVPROC( target.l, *v.float )
  PrototypeC PFNGLMULTITEXCOORD4IPROC( target.l, s.l, t.l, r.l, q.l )
  PrototypeC PFNGLMULTITEXCOORD4IVPROC( target.l, *v.long )
  PrototypeC PFNGLMULTITEXCOORD4SPROC( target.l, s.w, t.w, r.w, q.w )
  PrototypeC PFNGLMULTITEXCOORD4SVPROC( target.l, *v.word )
  PrototypeC PFNGLSAMPLECOVERAGEPROC( value.f, invert.a )
  PrototypeC PFNGLBLENDCOLORPROC( red.f, green.f, blue.f, alpha.f )
  PrototypeC PFNGLBLENDEQUATIONPROC( mode.l )
  PrototypeC PFNGLBLENDFUNCSEPARATEPROC( sfactorRGB.l, dfactorRGB.l, sfactorAlpha.l, dfactorAlpha.l )
  PrototypeC PFNGLFOGCOORDPOINTERPROC( type.l, stride.l, *pointer )
  PrototypeC PFNGLFOGCOORDDPROC( coord.d )
  PrototypeC PFNGLFOGCOORDDVPROC( *coord.double )
  PrototypeC PFNGLFOGCOORDFPROC( coord.f )
  PrototypeC PFNGLFOGCOORDFVPROC( *coord.float )
  PrototypeC PFNGLMULTIDRAWARRAYSPROC( mode.l, *first.long, *count.long, drawcount.l )
  PrototypeC PFNGLMULTIDRAWELEMENTSPROC( mode.l, *count.long, type.l, *pp_indices, drawcount.l )
  PrototypeC PFNGLPOINTPARAMETERFPROC( pname.l, param.f )
  PrototypeC PFNGLPOINTPARAMETERFVPROC( pname.l, *params.float )
  PrototypeC PFNGLPOINTPARAMETERIPROC( pname.l, param.l )
  PrototypeC PFNGLPOINTPARAMETERIVPROC( pname.l, *params.long )
  PrototypeC PFNGLSECONDARYCOLOR3BPROC( red.b, green.b, blue.b )
  PrototypeC PFNGLSECONDARYCOLOR3BVPROC( *v.byte )
  PrototypeC PFNGLSECONDARYCOLOR3DPROC( red.d, green.d, blue.d )
  PrototypeC PFNGLSECONDARYCOLOR3DVPROC( *v.double )
  PrototypeC PFNGLSECONDARYCOLOR3FPROC( red.f, green.f, blue.f )
  PrototypeC PFNGLSECONDARYCOLOR3FVPROC( *v.float )
  PrototypeC PFNGLSECONDARYCOLOR3IPROC( red.l, green.l, blue.l )
  PrototypeC PFNGLSECONDARYCOLOR3IVPROC( *v.long )
  PrototypeC PFNGLSECONDARYCOLOR3SPROC( red.w, green.w, blue.w )
  PrototypeC PFNGLSECONDARYCOLOR3SVPROC( *v.word )
  PrototypeC PFNGLSECONDARYCOLOR3UBPROC( red.a, green.a, blue.a )
  PrototypeC PFNGLSECONDARYCOLOR3UBVPROC( *v.ascii )
  PrototypeC PFNGLSECONDARYCOLOR3UIPROC( red.l, green.l, blue.l )
  PrototypeC PFNGLSECONDARYCOLOR3UIVPROC( *v.long )
  PrototypeC PFNGLSECONDARYCOLOR3USPROC( red.u, green.u, blue.u )
  PrototypeC PFNGLSECONDARYCOLOR3USVPROC( *v.unicode )
  PrototypeC PFNGLSECONDARYCOLORPOINTERPROC( size.l, type.l, stride.l, *pointer )
  PrototypeC PFNGLWINDOWPOS2DPROC( x.d, y.d )
  PrototypeC PFNGLWINDOWPOS2DVPROC( *p.double )
  PrototypeC PFNGLWINDOWPOS2FPROC( x.f, y.f )
  PrototypeC PFNGLWINDOWPOS2FVPROC( *p.float )
  PrototypeC PFNGLWINDOWPOS2IPROC( x.l, y.l )
  PrototypeC PFNGLWINDOWPOS2IVPROC( *p.long )
  PrototypeC PFNGLWINDOWPOS2SPROC( x.w, y.w )
  PrototypeC PFNGLWINDOWPOS2SVPROC( *p.word )
  PrototypeC PFNGLWINDOWPOS3DPROC( x.d, y.d, z.d )
  PrototypeC PFNGLWINDOWPOS3DVPROC( *p.double )
  PrototypeC PFNGLWINDOWPOS3FPROC( x.f, y.f, z.f )
  PrototypeC PFNGLWINDOWPOS3FVPROC( *p.float )
  PrototypeC PFNGLWINDOWPOS3IPROC( x.l, y.l, z.l )
  PrototypeC PFNGLWINDOWPOS3IVPROC( *p.long )
  PrototypeC PFNGLWINDOWPOS3SPROC( x.w, y.w, z.w )
  PrototypeC PFNGLWINDOWPOS3SVPROC( *p.word )
  PrototypeC PFNGLBEGINQUERYPROC( target.l, id.l )
  PrototypeC PFNGLBINDBUFFERPROC( target.l, buffer.l )
  PrototypeC PFNGLBUFFERDATAPROC( target.l, size.i, *data, usage.l )
  PrototypeC PFNGLBUFFERSUBDATAPROC( target.l, offset.i, size.i, *data )
  PrototypeC PFNGLDELETEBUFFERSPROC( n.l, *buffers.long )
  PrototypeC PFNGLDELETEQUERIESPROC( n.l, *ids.long )
  PrototypeC PFNGLENDQUERYPROC( target.l )
  PrototypeC PFNGLGENBUFFERSPROC( n.l, *buffers.long )
  PrototypeC PFNGLGENQUERIESPROC( n.l, *ids.long )
  PrototypeC PFNGLGETBUFFERPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETBUFFERPOINTERVPROC( target.l, pname.l, *pp_params )
  PrototypeC PFNGLGETBUFFERSUBDATAPROC( target.l, offset.i, size.i, *data )
  PrototypeC PFNGLGETQUERYOBJECTIVPROC( id.l, pname.l, *params.long )
  PrototypeC PFNGLGETQUERYOBJECTUIVPROC( id.l, pname.l, *params.long )
  PrototypeC PFNGLGETQUERYIVPROC( target.l, pname.l, *params.long )
  PrototypeC.a PFNGLISBUFFERPROC( buffer.l )
  PrototypeC.a PFNGLISQUERYPROC( id.l )
  PrototypeC.i PFNGLMAPBUFFERPROC( target.l, access.l )
  PrototypeC.a PFNGLUNMAPBUFFERPROC( target.l )
  PrototypeC PFNGLATTACHSHADERPROC( program.l, shader.l )
  PrototypeC PFNGLBINDATTRIBLOCATIONPROC( program.l, index.l, name.p-ascii )
  PrototypeC PFNGLBLENDEQUATIONSEPARATEPROC( modeRGB.l, modeAlpha.l )
  PrototypeC PFNGLCOMPILESHADERPROC( shader.l )
  PrototypeC.l PFNGLCREATEPROGRAMPROC(  )
  PrototypeC.l PFNGLCREATESHADERPROC( type.l )
  PrototypeC PFNGLDELETEPROGRAMPROC( program.l )
  PrototypeC PFNGLDELETESHADERPROC( shader.l )
  PrototypeC PFNGLDETACHSHADERPROC( program.l, shader.l )
  PrototypeC PFNGLDISABLEVERTEXATTRIBARRAYPROC( index.l )
  PrototypeC PFNGLDRAWBUFFERSPROC( n.l, *bufs.long )
  PrototypeC PFNGLENABLEVERTEXATTRIBARRAYPROC( index.l )
  PrototypeC PFNGLGETACTIVEATTRIBPROC( program.l, index.l, maxLength.l, *length.long, *size.long, *type.long, *name )
  PrototypeC PFNGLGETACTIVEUNIFORMPROC( program.l, index.l, maxLength.l, *length.long, *size.long, *type.long, *name )
  PrototypeC PFNGLGETATTACHEDSHADERSPROC( program.l, maxCount.l, *count.long, *shaders.long )
  PrototypeC.l PFNGLGETATTRIBLOCATIONPROC( program.l, name.p-ascii )
  PrototypeC PFNGLGETPROGRAMINFOLOGPROC( program.l, bufSize.l, *length.long, *infoLog )
  PrototypeC PFNGLGETPROGRAMIVPROC( program.l, pname.l, *param.long )
  PrototypeC PFNGLGETSHADERINFOLOGPROC( shader.l, bufSize.l, *length.long, *infoLog )
  PrototypeC PFNGLGETSHADERSOURCEPROC( obj.l, maxLength.l, *length.long, *source )
  PrototypeC PFNGLGETSHADERIVPROC( shader.l, pname.l, *param.long )
  PrototypeC.l PFNGLGETUNIFORMLOCATIONPROC( program.l, name.p-ascii )
  PrototypeC PFNGLGETUNIFORMFVPROC( program.l, location.l, *params.float )
  PrototypeC PFNGLGETUNIFORMIVPROC( program.l, location.l, *params.long )
  PrototypeC PFNGLGETVERTEXATTRIBPOINTERVPROC( index.l, pname.l, *pp_pointer )
  PrototypeC PFNGLGETVERTEXATTRIBDVPROC( index.l, pname.l, *params.double )
  PrototypeC PFNGLGETVERTEXATTRIBFVPROC( index.l, pname.l, *params.float )
  PrototypeC PFNGLGETVERTEXATTRIBIVPROC( index.l, pname.l, *params.long )
  PrototypeC.a PFNGLISPROGRAMPROC( program.l )
  PrototypeC.a PFNGLISSHADERPROC( shader.l )
  PrototypeC PFNGLLINKPROGRAMPROC( program.l )
  PrototypeC PFNGLSHADERSOURCEPROC( shader.l, count.l, *pp_string, *length.long )
  PrototypeC PFNGLSTENCILFUNCSEPARATEPROC( frontfunc.l, backfunc.l, ref.l, mask.l )
  PrototypeC PFNGLSTENCILMASKSEPARATEPROC( face.l, mask.l )
  PrototypeC PFNGLSTENCILOPSEPARATEPROC( face.l, sfail.l, dpfail.l, dppass.l )
  PrototypeC PFNGLUNIFORM1FPROC( location.l, v0.f )
  PrototypeC PFNGLUNIFORM1FVPROC( location.l, count.l, *value.float )
  PrototypeC PFNGLUNIFORM1IPROC( location.l, v0.l )
  PrototypeC PFNGLUNIFORM1IVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORM2FPROC( location.l, v0.f, v1.f )
  PrototypeC PFNGLUNIFORM2FVPROC( location.l, count.l, *value.float )
  PrototypeC PFNGLUNIFORM2IPROC( location.l, v0.l, v1.l )
  PrototypeC PFNGLUNIFORM2IVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORM3FPROC( location.l, v0.f, v1.f, v2.f )
  PrototypeC PFNGLUNIFORM3FVPROC( location.l, count.l, *value.float )
  PrototypeC PFNGLUNIFORM3IPROC( location.l, v0.l, v1.l, v2.l )
  PrototypeC PFNGLUNIFORM3IVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORM4FPROC( location.l, v0.f, v1.f, v2.f, v3.f )
  PrototypeC PFNGLUNIFORM4FVPROC( location.l, count.l, *value.float )
  PrototypeC PFNGLUNIFORM4IPROC( location.l, v0.l, v1.l, v2.l, v3.l )
  PrototypeC PFNGLUNIFORM4IVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORMMATRIX2FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX3FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX4FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUSEPROGRAMPROC( program.l )
  PrototypeC PFNGLVALIDATEPROGRAMPROC( program.l )
  PrototypeC PFNGLVERTEXATTRIB1DPROC( index.l, x.d )
  PrototypeC PFNGLVERTEXATTRIB1DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIB1FPROC( index.l, x.f )
  PrototypeC PFNGLVERTEXATTRIB1FVPROC( index.l, *v.float )
  PrototypeC PFNGLVERTEXATTRIB1SPROC( index.l, x.w )
  PrototypeC PFNGLVERTEXATTRIB1SVPROC( index.l, *v.word )
  PrototypeC PFNGLVERTEXATTRIB2DPROC( index.l, x.d, y.d )
  PrototypeC PFNGLVERTEXATTRIB2DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIB2FPROC( index.l, x.f, y.f )
  PrototypeC PFNGLVERTEXATTRIB2FVPROC( index.l, *v.float )
  PrototypeC PFNGLVERTEXATTRIB2SPROC( index.l, x.w, y.w )
  PrototypeC PFNGLVERTEXATTRIB2SVPROC( index.l, *v.word )
  PrototypeC PFNGLVERTEXATTRIB3DPROC( index.l, x.d, y.d, z.d )
  PrototypeC PFNGLVERTEXATTRIB3DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIB3FPROC( index.l, x.f, y.f, z.f )
  PrototypeC PFNGLVERTEXATTRIB3FVPROC( index.l, *v.float )
  PrototypeC PFNGLVERTEXATTRIB3SPROC( index.l, x.w, y.w, z.w )
  PrototypeC PFNGLVERTEXATTRIB3SVPROC( index.l, *v.word )
  PrototypeC PFNGLVERTEXATTRIB4NBVPROC( index.l, *v.byte )
  PrototypeC PFNGLVERTEXATTRIB4NIVPROC( index.l, *v.long )
  PrototypeC PFNGLVERTEXATTRIB4NSVPROC( index.l, *v.word )
  PrototypeC PFNGLVERTEXATTRIB4NUBPROC( index.l, x.a, y.a, z.a, w.a )
  PrototypeC PFNGLVERTEXATTRIB4NUBVPROC( index.l, *v.ascii )
  PrototypeC PFNGLVERTEXATTRIB4NUIVPROC( index.l, *v.long )
  PrototypeC PFNGLVERTEXATTRIB4NUSVPROC( index.l, *v.unicode )
  PrototypeC PFNGLVERTEXATTRIB4BVPROC( index.l, *v.byte )
  PrototypeC PFNGLVERTEXATTRIB4DPROC( index.l, x.d, y.d, z.d, w.d )
  PrototypeC PFNGLVERTEXATTRIB4DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIB4FPROC( index.l, x.f, y.f, z.f, w.f )
  PrototypeC PFNGLVERTEXATTRIB4FVPROC( index.l, *v.float )
  PrototypeC PFNGLVERTEXATTRIB4IVPROC( index.l, *v.long )
  PrototypeC PFNGLVERTEXATTRIB4SPROC( index.l, x.w, y.w, z.w, w.w )
  PrototypeC PFNGLVERTEXATTRIB4SVPROC( index.l, *v.word )
  PrototypeC PFNGLVERTEXATTRIB4UBVPROC( index.l, *v.ascii )
  PrototypeC PFNGLVERTEXATTRIB4UIVPROC( index.l, *v.long )
  PrototypeC PFNGLVERTEXATTRIB4USVPROC( index.l, *v.unicode )
  PrototypeC PFNGLVERTEXATTRIBPOINTERPROC( index.l, size.l, type.l, normalized.a, stride.l, *pointer )
  PrototypeC PFNGLUNIFORMMATRIX2X3FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX2X4FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX3X2FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX3X4FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX4X2FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUNIFORMMATRIX4X3FVPROC( location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLBEGINCONDITIONALRENDERPROC( id.l, mode.l )
  PrototypeC PFNGLBEGINTRANSFORMFEEDBACKPROC( primitiveMode.l )
  PrototypeC PFNGLBINDFRAGDATALOCATIONPROC( program.l, colorNumber.l, name.p-ascii )
  PrototypeC PFNGLCLAMPCOLORPROC( target.l, clamp.l )
  PrototypeC PFNGLCLEARBUFFERFIPROC( buffer.l, drawBuffer.l, depth.f, stencil.l )
  PrototypeC PFNGLCLEARBUFFERFVPROC( buffer.l, drawBuffer.l, *value.float )
  PrototypeC PFNGLCLEARBUFFERIVPROC( buffer.l, drawBuffer.l, *value.long )
  PrototypeC PFNGLCLEARBUFFERUIVPROC( buffer.l, drawBuffer.l, *value.long )
  PrototypeC PFNGLCOLORMASKIPROC( buf.l, red.a, green.a, blue.a, alpha.a )
  PrototypeC PFNGLDISABLEIPROC( cap.l, index.l )
  PrototypeC PFNGLENABLEIPROC( cap.l, index.l )
  PrototypeC PFNGLENDCONDITIONALRENDERPROC(  )
  PrototypeC PFNGLENDTRANSFORMFEEDBACKPROC(  )
  PrototypeC PFNGLGETBOOLEANI_VPROC( pname.l, index.l, *data.ascii )
  PrototypeC.l PFNGLGETFRAGDATALOCATIONPROC( program.l, name.p-ascii )
  PrototypeC.i PFNGLGETSTRINGIPROC( name.l, index.l )
  PrototypeC PFNGLGETTEXPARAMETERIIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETTEXPARAMETERIUIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETTRANSFORMFEEDBACKVARYINGPROC( program.l, index.l, bufSize.l, *v4.long, *v5.long, *v6.long, *v7 )
  PrototypeC PFNGLGETUNIFORMUIVPROC( program.l, location.l, *params.long )
  PrototypeC PFNGLGETVERTEXATTRIBIIVPROC( index.l, pname.l, *params.long )
  PrototypeC PFNGLGETVERTEXATTRIBIUIVPROC( index.l, pname.l, *params.long )
  PrototypeC.a PFNGLISENABLEDIPROC( cap.l, index.l )
  PrototypeC PFNGLTEXPARAMETERIIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLTEXPARAMETERIUIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLTRANSFORMFEEDBACKVARYINGSPROC( program.l, count.l, *pp_varyings, bufferMode.l )
  PrototypeC PFNGLUNIFORM1UIPROC( location.l, v0.l )
  PrototypeC PFNGLUNIFORM1UIVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORM2UIPROC( location.l, v0.l, v1.l )
  PrototypeC PFNGLUNIFORM2UIVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORM3UIPROC( location.l, v0.l, v1.l, v2.l )
  PrototypeC PFNGLUNIFORM3UIVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLUNIFORM4UIPROC( location.l, v0.l, v1.l, v2.l, v3.l )
  PrototypeC PFNGLUNIFORM4UIVPROC( location.l, count.l, *value.long )
  PrototypeC PFNGLVERTEXATTRIBI1IPROC( index.l, v0.l )
  PrototypeC PFNGLVERTEXATTRIBI1IVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI1UIPROC( index.l, v0.l )
  PrototypeC PFNGLVERTEXATTRIBI1UIVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI2IPROC( index.l, v0.l, v1.l )
  PrototypeC PFNGLVERTEXATTRIBI2IVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI2UIPROC( index.l, v0.l, v1.l )
  PrototypeC PFNGLVERTEXATTRIBI2UIVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI3IPROC( index.l, v0.l, v1.l, v2.l )
  PrototypeC PFNGLVERTEXATTRIBI3IVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI3UIPROC( index.l, v0.l, v1.l, v2.l )
  PrototypeC PFNGLVERTEXATTRIBI3UIVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI4BVPROC( index.l, *v0.byte )
  PrototypeC PFNGLVERTEXATTRIBI4IPROC( index.l, v0.l, v1.l, v2.l, v3.l )
  PrototypeC PFNGLVERTEXATTRIBI4IVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI4SVPROC( index.l, *v0.word )
  PrototypeC PFNGLVERTEXATTRIBI4UBVPROC( index.l, *v0.ascii )
  PrototypeC PFNGLVERTEXATTRIBI4UIPROC( index.l, v0.l, v1.l, v2.l, v3.l )
  PrototypeC PFNGLVERTEXATTRIBI4UIVPROC( index.l, *v0.long )
  PrototypeC PFNGLVERTEXATTRIBI4USVPROC( index.l, *v0.unicode )
  PrototypeC PFNGLVERTEXATTRIBIPOINTERPROC( index.l, size.l, type.l, stride.l, v5.i )
  PrototypeC PFNGLDRAWARRAYSINSTANCEDPROC( mode.l, first.l, count.l, primcount.l )
  PrototypeC PFNGLDRAWELEMENTSINSTANCEDPROC( mode.l, count.l, type.l, *indices, primcount.l )
  PrototypeC PFNGLPRIMITIVERESTARTINDEXPROC( buffer.l )
  PrototypeC PFNGLTEXBUFFERPROC( target.l, internalFormat.l, buffer.l )
  PrototypeC PFNGLFRAMEBUFFERTEXTUREPROC( target.l, attachment.l, texture.l, level.l )
  PrototypeC PFNGLGETBUFFERPARAMETERI64VPROC( target.l, value.l, *v3.quad )
  PrototypeC PFNGLGETINTEGER64I_VPROC( pname.l, index.l, *v3.quad )
  PrototypeC PFNGLVERTEXATTRIBDIVISORPROC( index.l, divisor.l )
  PrototypeC PFNGLBLENDEQUATIONSEPARATEIPROC( buf.l, modeRGB.l, modeAlpha.l )
  PrototypeC PFNGLBLENDEQUATIONIPROC( buf.l, mode.l )
  PrototypeC PFNGLBLENDFUNCSEPARATEIPROC( buf.l, srcRGB.l, dstRGB.l, srcAlpha.l, dstAlpha.l )
  PrototypeC PFNGLBLENDFUNCIPROC( buf.l, src.l, dst.l )
  PrototypeC PFNGLMINSAMPLESHADINGPROC( value.f )
  PrototypeC.l PFNGLGETGRAPHICSRESETSTATUSPROC(  )
  PrototypeC PFNGLGETNCOMPRESSEDTEXIMAGEPROC( target.l, lod.l, bufSize.l, *pixels )
  PrototypeC PFNGLGETNTEXIMAGEPROC( tex.l, level.l, format.l, type.l, bufSize.l, *pixels )
  PrototypeC PFNGLGETNUNIFORMDVPROC( program.l, location.l, bufSize.l, *params.double )
  PrototypeC PFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC( mode.l, *indirect, drawcount.i, maxdrawcount.l, stride.l )
  PrototypeC PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC( mode.l, type.l, *indirect, drawcount.i, maxdrawcount.l, stride.l )
  PrototypeC PFNGLSPECIALIZESHADERPROC( shader.l, pEntryPoint.p-ascii, numSpecializationConstants.l, *pConstantIndex.long, *pConstantValue.long )
  PrototypeC PFNGLCLEARDEPTHFPROC( d.f )
  PrototypeC PFNGLDEPTHRANGEFPROC( n.f, f.f )
  PrototypeC PFNGLGETSHADERPRECISIONFORMATPROC( shadertype.l, precisiontype.l, *range.long, *precision.long )
  PrototypeC PFNGLRELEASESHADERCOMPILERPROC(  )
  PrototypeC PFNGLSHADERBINARYPROC( count.l, *shaders.long, binaryformat.l, v4.i, length.l )
  PrototypeC PFNGLMEMORYBARRIERBYREGIONPROC( barriers.l )
  PrototypeC PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC( mode.l, first.l, count.l, primcount.l, baseinstance.l )
  PrototypeC PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC( mode.l, count.l, type.l, *indices, primcount.l, baseinstance.l )
  PrototypeC PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC( mode.l, count.l, type.l, *indices, primcount.l, basevertex.l, baseinstance.l )
  PrototypeC PFNGLBINDFRAGDATALOCATIONINDEXEDPROC( program.l, colorNumber.l, index.l, v4.p-ascii )
  PrototypeC.l PFNGLGETFRAGDATAINDEXPROC( program.l, v2.p-ascii )
  PrototypeC PFNGLBUFFERSTORAGEPROC( target.l, size.i, *data, flags.l )
  PrototypeC PFNGLCLEARBUFFERDATAPROC( target.l, internalformat.l, format.l, type.l, *data )
  PrototypeC PFNGLCLEARBUFFERSUBDATAPROC( target.l, internalformat.l, offset.i, size.i, format.l, type.l, *data )
  PrototypeC PFNGLCLEARTEXIMAGEPROC( texture.l, level.l, format.l, type.l, *data )
  PrototypeC PFNGLCLEARTEXSUBIMAGEPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, format.l, type.l, *data )
  PrototypeC PFNGLCLIPCONTROLPROC( origin.l, depth.l )
  PrototypeC PFNGLDISPATCHCOMPUTEPROC( num_groups_x.l, num_groups_y.l, num_groups_z.l )
  PrototypeC PFNGLDISPATCHCOMPUTEINDIRECTPROC( indirect.i )
  PrototypeC PFNGLCOPYBUFFERSUBDATAPROC( readtarget.l, writetarget.l, readoffset.i, writeoffset.i, size.i )
  PrototypeC PFNGLCOPYIMAGESUBDATAPROC( srcName.l, srcTarget.l, srcLevel.l, srcX.l, srcY.l, srcZ.l, dstName.l, dstTarget.l, dstLevel.l, dstX.l, dstY.l, dstZ.l, srcWidth.l, srcHeight.l, srcDepth.l )
  PrototypeC PFNGLBINDTEXTUREUNITPROC( unit.l, texture.l )
  PrototypeC PFNGLBLITNAMEDFRAMEBUFFERPROC( readFramebuffer.l, drawFramebuffer.l, srcX0.l, srcY0.l, srcX1.l, srcY1.l, dstX0.l, dstY0.l, dstX1.l, dstY1.l, mask.l, filter.l )
  PrototypeC.l PFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC( framebuffer.l, target.l )
  PrototypeC PFNGLCLEARNAMEDBUFFERDATAPROC( buffer.l, internalformat.l, format.l, type.l, *data )
  PrototypeC PFNGLCLEARNAMEDBUFFERSUBDATAPROC( buffer.l, internalformat.l, offset.i, size.i, format.l, type.l, *data )
  PrototypeC PFNGLCLEARNAMEDFRAMEBUFFERFIPROC( framebuffer.l, buffer.l, drawbuffer.l, depth.f, stencil.l )
  PrototypeC PFNGLCLEARNAMEDFRAMEBUFFERFVPROC( framebuffer.l, buffer.l, drawbuffer.l, *value.float )
  PrototypeC PFNGLCLEARNAMEDFRAMEBUFFERIVPROC( framebuffer.l, buffer.l, drawbuffer.l, *value.long )
  PrototypeC PFNGLCLEARNAMEDFRAMEBUFFERUIVPROC( framebuffer.l, buffer.l, drawbuffer.l, *value.long )
  PrototypeC PFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC( texture.l, level.l, xoffset.l, width.l, format.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC( texture.l, level.l, xoffset.l, yoffset.l, width.l, height.l, format.l, imageSize.l, *data )
  PrototypeC PFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, format.l, imageSize.l, *data )
  PrototypeC PFNGLCOPYNAMEDBUFFERSUBDATAPROC( readBuffer.l, writeBuffer.l, readOffset.i, writeOffset.i, size.i )
  PrototypeC PFNGLCOPYTEXTURESUBIMAGE1DPROC( texture.l, level.l, xoffset.l, x.l, y.l, width.l )
  PrototypeC PFNGLCOPYTEXTURESUBIMAGE2DPROC( texture.l, level.l, xoffset.l, yoffset.l, x.l, y.l, width.l, height.l )
  PrototypeC PFNGLCOPYTEXTURESUBIMAGE3DPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, x.l, y.l, width.l, height.l )
  PrototypeC PFNGLCREATEBUFFERSPROC( n.l, *buffers.long )
  PrototypeC PFNGLCREATEFRAMEBUFFERSPROC( n.l, *framebuffers.long )
  PrototypeC PFNGLCREATEPROGRAMPIPELINESPROC( n.l, *pipelines.long )
  PrototypeC PFNGLCREATEQUERIESPROC( target.l, n.l, *ids.long )
  PrototypeC PFNGLCREATERENDERBUFFERSPROC( n.l, *renderbuffers.long )
  PrototypeC PFNGLCREATESAMPLERSPROC( n.l, *samplers.long )
  PrototypeC PFNGLCREATETEXTURESPROC( target.l, n.l, *textures.long )
  PrototypeC PFNGLCREATETRANSFORMFEEDBACKSPROC( n.l, *ids.long )
  PrototypeC PFNGLCREATEVERTEXARRAYSPROC( n.l, *arrays.long )
  PrototypeC PFNGLDISABLEVERTEXARRAYATTRIBPROC( vaobj.l, index.l )
  PrototypeC PFNGLENABLEVERTEXARRAYATTRIBPROC( vaobj.l, index.l )
  PrototypeC PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC( buffer.l, offset.i, length.i )
  PrototypeC PFNGLGENERATETEXTUREMIPMAPPROC( texture.l )
  PrototypeC PFNGLGETCOMPRESSEDTEXTUREIMAGEPROC( texture.l, level.l, bufSize.l, *pixels )
  PrototypeC PFNGLGETNAMEDBUFFERPARAMETERI64VPROC( buffer.l, pname.l, *params.quad )
  PrototypeC PFNGLGETNAMEDBUFFERPARAMETERIVPROC( buffer.l, pname.l, *params.long )
  PrototypeC PFNGLGETNAMEDBUFFERPOINTERVPROC( buffer.l, pname.l, *pp_params )
  PrototypeC PFNGLGETNAMEDBUFFERSUBDATAPROC( buffer.l, offset.i, size.i, *data )
  PrototypeC PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC( framebuffer.l, attachment.l, pname.l, *params.long )
  PrototypeC PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC( framebuffer.l, pname.l, *param.long )
  PrototypeC PFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC( renderbuffer.l, pname.l, *params.long )
  PrototypeC PFNGLGETQUERYBUFFEROBJECTI64VPROC( id.l, buffer.l, pname.l, offset.i )
  PrototypeC PFNGLGETQUERYBUFFEROBJECTIVPROC( id.l, buffer.l, pname.l, offset.i )
  PrototypeC PFNGLGETQUERYBUFFEROBJECTUI64VPROC( id.l, buffer.l, pname.l, offset.i )
  PrototypeC PFNGLGETQUERYBUFFEROBJECTUIVPROC( id.l, buffer.l, pname.l, offset.i )
  PrototypeC PFNGLGETTEXTUREIMAGEPROC( texture.l, level.l, format.l, type.l, bufSize.l, *pixels )
  PrototypeC PFNGLGETTEXTURELEVELPARAMETERFVPROC( texture.l, level.l, pname.l, *params.float )
  PrototypeC PFNGLGETTEXTURELEVELPARAMETERIVPROC( texture.l, level.l, pname.l, *params.long )
  PrototypeC PFNGLGETTEXTUREPARAMETERIIVPROC( texture.l, pname.l, *params.long )
  PrototypeC PFNGLGETTEXTUREPARAMETERIUIVPROC( texture.l, pname.l, *params.long )
  PrototypeC PFNGLGETTEXTUREPARAMETERFVPROC( texture.l, pname.l, *params.float )
  PrototypeC PFNGLGETTEXTUREPARAMETERIVPROC( texture.l, pname.l, *params.long )
  PrototypeC PFNGLGETTRANSFORMFEEDBACKI64_VPROC( xfb.l, pname.l, index.l, *param.quad )
  PrototypeC PFNGLGETTRANSFORMFEEDBACKI_VPROC( xfb.l, pname.l, index.l, *param.long )
  PrototypeC PFNGLGETTRANSFORMFEEDBACKIVPROC( xfb.l, pname.l, *param.long )
  PrototypeC PFNGLGETVERTEXARRAYINDEXED64IVPROC( vaobj.l, index.l, pname.l, *param.quad )
  PrototypeC PFNGLGETVERTEXARRAYINDEXEDIVPROC( vaobj.l, index.l, pname.l, *param.long )
  PrototypeC PFNGLGETVERTEXARRAYIVPROC( vaobj.l, pname.l, *param.long )
  PrototypeC PFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC( framebuffer.l, numAttachments.l, *attachments.long )
  PrototypeC PFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC( framebuffer.l, numAttachments.l, *attachments.long, x.l, y.l, width.l, height.l )
  PrototypeC.i PFNGLMAPNAMEDBUFFERPROC( buffer.l, access.l )
  PrototypeC.i PFNGLMAPNAMEDBUFFERRANGEPROC( buffer.l, offset.i, length.i, access.l )
  PrototypeC PFNGLNAMEDBUFFERDATAPROC( buffer.l, size.i, *data, usage.l )
  PrototypeC PFNGLNAMEDBUFFERSTORAGEPROC( buffer.l, size.i, *data, flags.l )
  PrototypeC PFNGLNAMEDBUFFERSUBDATAPROC( buffer.l, offset.i, size.i, *data )
  PrototypeC PFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC( framebuffer.l, mode.l )
  PrototypeC PFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC( framebuffer.l, n.l, *bufs.long )
  PrototypeC PFNGLNAMEDFRAMEBUFFERPARAMETERIPROC( framebuffer.l, pname.l, param.l )
  PrototypeC PFNGLNAMEDFRAMEBUFFERREADBUFFERPROC( framebuffer.l, mode.l )
  PrototypeC PFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC( framebuffer.l, attachment.l, renderbuffertarget.l, renderbuffer.l )
  PrototypeC PFNGLNAMEDFRAMEBUFFERTEXTUREPROC( framebuffer.l, attachment.l, texture.l, level.l )
  PrototypeC PFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC( framebuffer.l, attachment.l, texture.l, level.l, layer.l )
  PrototypeC PFNGLNAMEDRENDERBUFFERSTORAGEPROC( renderbuffer.l, internalformat.l, width.l, height.l )
  PrototypeC PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC( renderbuffer.l, samples.l, internalformat.l, width.l, height.l )
  PrototypeC PFNGLTEXTUREBUFFERPROC( texture.l, internalformat.l, buffer.l )
  PrototypeC PFNGLTEXTUREBUFFERRANGEPROC( texture.l, internalformat.l, buffer.l, offset.i, size.i )
  PrototypeC PFNGLTEXTUREPARAMETERIIVPROC( texture.l, pname.l, *params.long )
  PrototypeC PFNGLTEXTUREPARAMETERIUIVPROC( texture.l, pname.l, *params.long )
  PrototypeC PFNGLTEXTUREPARAMETERFPROC( texture.l, pname.l, param.f )
  PrototypeC PFNGLTEXTUREPARAMETERFVPROC( texture.l, pname.l, *param.float )
  PrototypeC PFNGLTEXTUREPARAMETERIPROC( texture.l, pname.l, param.l )
  PrototypeC PFNGLTEXTUREPARAMETERIVPROC( texture.l, pname.l, *param.long )
  PrototypeC PFNGLTEXTURESTORAGE1DPROC( texture.l, levels.l, internalformat.l, width.l )
  PrototypeC PFNGLTEXTURESTORAGE2DPROC( texture.l, levels.l, internalformat.l, width.l, height.l )
  PrototypeC PFNGLTEXTURESTORAGE2DMULTISAMPLEPROC( texture.l, samples.l, internalformat.l, width.l, height.l, fixedsamplelocations.a )
  PrototypeC PFNGLTEXTURESTORAGE3DPROC( texture.l, levels.l, internalformat.l, width.l, height.l, depth.l )
  PrototypeC PFNGLTEXTURESTORAGE3DMULTISAMPLEPROC( texture.l, samples.l, internalformat.l, width.l, height.l, depth.l, fixedsamplelocations.a )
  PrototypeC PFNGLTEXTURESUBIMAGE1DPROC( texture.l, level.l, xoffset.l, width.l, format.l, type.l, *pixels )
  PrototypeC PFNGLTEXTURESUBIMAGE2DPROC( texture.l, level.l, xoffset.l, yoffset.l, width.l, height.l, format.l, type.l, *pixels )
  PrototypeC PFNGLTEXTURESUBIMAGE3DPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, format.l, type.l, *pixels )
  PrototypeC PFNGLTRANSFORMFEEDBACKBUFFERBASEPROC( xfb.l, index.l, buffer.l )
  PrototypeC PFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC( xfb.l, index.l, buffer.l, offset.i, size.i )
  PrototypeC.a PFNGLUNMAPNAMEDBUFFERPROC( buffer.l )
  PrototypeC PFNGLVERTEXARRAYATTRIBBINDINGPROC( vaobj.l, attribindex.l, bindingindex.l )
  PrototypeC PFNGLVERTEXARRAYATTRIBFORMATPROC( vaobj.l, attribindex.l, size.l, type.l, normalized.a, relativeoffset.l )
  PrototypeC PFNGLVERTEXARRAYATTRIBIFORMATPROC( vaobj.l, attribindex.l, size.l, type.l, relativeoffset.l )
  PrototypeC PFNGLVERTEXARRAYATTRIBLFORMATPROC( vaobj.l, attribindex.l, size.l, type.l, relativeoffset.l )
  PrototypeC PFNGLVERTEXARRAYBINDINGDIVISORPROC( vaobj.l, bindingindex.l, divisor.l )
  PrototypeC PFNGLVERTEXARRAYELEMENTBUFFERPROC( vaobj.l, buffer.l )
  PrototypeC PFNGLVERTEXARRAYVERTEXBUFFERPROC( vaobj.l, bindingindex.l, buffer.l, offset.i, stride.l )
  PrototypeC PFNGLVERTEXARRAYVERTEXBUFFERSPROC( vaobj.l, first.l, count.l, *buffers.long, *offsets.integer, *strides.long )
  PrototypeC PFNGLDRAWELEMENTSBASEVERTEXPROC( mode.l, count.l, type.l, *indices, basevertex.l )
  PrototypeC PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC( mode.l, count.l, type.l, *indices, primcount.l, basevertex.l )
  PrototypeC PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC( mode.l, start.l, _end.l, count.l, type.l, *indices, basevertex.l )
  PrototypeC PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC( mode.l, *count.long, type.l, v4.i, primcount.l, *basevertex.long )
  PrototypeC PFNGLDRAWARRAYSINDIRECTPROC( mode.l, *indirect )
  PrototypeC PFNGLDRAWELEMENTSINDIRECTPROC( mode.l, type.l, *indirect )
  PrototypeC PFNGLFRAMEBUFFERPARAMETERIPROC( target.l, pname.l, param.l )
  PrototypeC PFNGLGETFRAMEBUFFERPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLBINDFRAMEBUFFERPROC( target.l, framebuffer.l )
  PrototypeC PFNGLBINDRENDERBUFFERPROC( target.l, renderbuffer.l )
  PrototypeC PFNGLBLITFRAMEBUFFERPROC( srcX0.l, srcY0.l, srcX1.l, srcY1.l, dstX0.l, dstY0.l, dstX1.l, dstY1.l, mask.l, filter.l )
  PrototypeC.l PFNGLCHECKFRAMEBUFFERSTATUSPROC( target.l )
  PrototypeC PFNGLDELETEFRAMEBUFFERSPROC( n.l, *framebuffers.long )
  PrototypeC PFNGLDELETERENDERBUFFERSPROC( n.l, *renderbuffers.long )
  PrototypeC PFNGLFRAMEBUFFERRENDERBUFFERPROC( target.l, attachment.l, renderbuffertarget.l, renderbuffer.l )
  PrototypeC PFNGLFRAMEBUFFERTEXTURE1DPROC( target.l, attachment.l, textarget.l, texture.l, level.l )
  PrototypeC PFNGLFRAMEBUFFERTEXTURE2DPROC( target.l, attachment.l, textarget.l, texture.l, level.l )
  PrototypeC PFNGLFRAMEBUFFERTEXTURE3DPROC( target.l, attachment.l, textarget.l, texture.l, level.l, layer.l )
  PrototypeC PFNGLFRAMEBUFFERTEXTURELAYERPROC( target.l, attachment.l, texture.l, level.l, layer.l )
  PrototypeC PFNGLGENFRAMEBUFFERSPROC( n.l, *framebuffers.long )
  PrototypeC PFNGLGENRENDERBUFFERSPROC( n.l, *renderbuffers.long )
  PrototypeC PFNGLGENERATEMIPMAPPROC( target.l )
  PrototypeC PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC( target.l, attachment.l, pname.l, *params.long )
  PrototypeC PFNGLGETRENDERBUFFERPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC.a PFNGLISFRAMEBUFFERPROC( framebuffer.l )
  PrototypeC.a PFNGLISRENDERBUFFERPROC( renderbuffer.l )
  PrototypeC PFNGLRENDERBUFFERSTORAGEPROC( target.l, internalformat.l, width.l, height.l )
  PrototypeC PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC( target.l, samples.l, internalformat.l, width.l, height.l )
  PrototypeC PFNGLGETPROGRAMBINARYPROC( program.l, bufSize.l, *length.long, *binaryFormat.long, v5.i )
  PrototypeC PFNGLPROGRAMBINARYPROC( program.l, binaryFormat.l, *binary, length.l )
  PrototypeC PFNGLPROGRAMPARAMETERIPROC( program.l, pname.l, value.l )
  PrototypeC PFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, bufSize.l, *pixels )
  PrototypeC PFNGLGETTEXTURESUBIMAGEPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l, format.l, type.l, bufSize.l, *pixels )
  PrototypeC PFNGLGETUNIFORMDVPROC( program.l, location.l, *params.double )
  PrototypeC PFNGLUNIFORM1DPROC( location.l, x.d )
  PrototypeC PFNGLUNIFORM1DVPROC( location.l, count.l, *value.double )
  PrototypeC PFNGLUNIFORM2DPROC( location.l, x.d, y.d )
  PrototypeC PFNGLUNIFORM2DVPROC( location.l, count.l, *value.double )
  PrototypeC PFNGLUNIFORM3DPROC( location.l, x.d, y.d, z.d )
  PrototypeC PFNGLUNIFORM3DVPROC( location.l, count.l, *value.double )
  PrototypeC PFNGLUNIFORM4DPROC( location.l, x.d, y.d, z.d, w.d )
  PrototypeC PFNGLUNIFORM4DVPROC( location.l, count.l, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX2DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX2X3DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX2X4DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX3DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX3X2DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX3X4DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX4DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX4X2DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLUNIFORMMATRIX4X3DVPROC( location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLCOLORSUBTABLEPROC( target.l, start.l, count.l, format.l, type.l, *data )
  PrototypeC PFNGLCOLORTABLEPROC( target.l, internalformat.l, width.l, format.l, type.l, *table )
  PrototypeC PFNGLCOLORTABLEPARAMETERFVPROC( target.l, pname.l, *params.float )
  PrototypeC PFNGLCOLORTABLEPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLCONVOLUTIONFILTER1DPROC( target.l, internalformat.l, width.l, format.l, type.l, *image )
  PrototypeC PFNGLCONVOLUTIONFILTER2DPROC( target.l, internalformat.l, width.l, height.l, format.l, type.l, *image )
  PrototypeC PFNGLCONVOLUTIONPARAMETERFPROC( target.l, pname.l, params.f )
  PrototypeC PFNGLCONVOLUTIONPARAMETERFVPROC( target.l, pname.l, *params.float )
  PrototypeC PFNGLCONVOLUTIONPARAMETERIPROC( target.l, pname.l, params.l )
  PrototypeC PFNGLCONVOLUTIONPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLCOPYCOLORSUBTABLEPROC( target.l, start.l, x.l, y.l, width.l )
  PrototypeC PFNGLCOPYCOLORTABLEPROC( target.l, internalformat.l, x.l, y.l, width.l )
  PrototypeC PFNGLCOPYCONVOLUTIONFILTER1DPROC( target.l, internalformat.l, x.l, y.l, width.l )
  PrototypeC PFNGLCOPYCONVOLUTIONFILTER2DPROC( target.l, internalformat.l, x.l, y.l, width.l, height.l )
  PrototypeC PFNGLGETCOLORTABLEPROC( target.l, format.l, type.l, *table )
  PrototypeC PFNGLGETCOLORTABLEPARAMETERFVPROC( target.l, pname.l, *params.float )
  PrototypeC PFNGLGETCOLORTABLEPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETCONVOLUTIONFILTERPROC( target.l, format.l, type.l, *image )
  PrototypeC PFNGLGETCONVOLUTIONPARAMETERFVPROC( target.l, pname.l, *params.float )
  PrototypeC PFNGLGETCONVOLUTIONPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETHISTOGRAMPROC( target.l, reset.a, format.l, type.l, *values )
  PrototypeC PFNGLGETHISTOGRAMPARAMETERFVPROC( target.l, pname.l, *params.float )
  PrototypeC PFNGLGETHISTOGRAMPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETMINMAXPROC( target.l, reset.a, format.l, types.l, *values )
  PrototypeC PFNGLGETMINMAXPARAMETERFVPROC( target.l, pname.l, *params.float )
  PrototypeC PFNGLGETMINMAXPARAMETERIVPROC( target.l, pname.l, *params.long )
  PrototypeC PFNGLGETSEPARABLEFILTERPROC( target.l, format.l, type.l, *row, *column, *span )
  PrototypeC PFNGLHISTOGRAMPROC( target.l, width.l, internalformat.l, sink.a )
  PrototypeC PFNGLMINMAXPROC( target.l, internalformat.l, sink.a )
  PrototypeC PFNGLRESETHISTOGRAMPROC( target.l )
  PrototypeC PFNGLRESETMINMAXPROC( target.l )
  PrototypeC PFNGLSEPARABLEFILTER2DPROC( target.l, internalformat.l, width.l, height.l, format.l, type.l, *row, *column )
  PrototypeC PFNGLGETINTERNALFORMATIVPROC( target.l, internalformat.l, pname.l, bufSize.l, *params.long )
  PrototypeC PFNGLGETINTERNALFORMATI64VPROC( target.l, internalformat.l, pname.l, bufSize.l, *params.quad )
  PrototypeC PFNGLINVALIDATEBUFFERDATAPROC( buffer.l )
  PrototypeC PFNGLINVALIDATEBUFFERSUBDATAPROC( buffer.l, offset.i, length.i )
  PrototypeC PFNGLINVALIDATEFRAMEBUFFERPROC( target.l, numAttachments.l, *attachments.long )
  PrototypeC PFNGLINVALIDATESUBFRAMEBUFFERPROC( target.l, numAttachments.l, *attachments.long, x.l, y.l, width.l, height.l )
  PrototypeC PFNGLINVALIDATETEXIMAGEPROC( texture.l, level.l )
  PrototypeC PFNGLINVALIDATETEXSUBIMAGEPROC( texture.l, level.l, xoffset.l, yoffset.l, zoffset.l, width.l, height.l, depth.l )
  PrototypeC PFNGLFLUSHMAPPEDBUFFERRANGEPROC( target.l, offset.i, length.i )
  PrototypeC.i PFNGLMAPBUFFERRANGEPROC( target.l, offset.i, length.i, access.l )
  PrototypeC PFNGLBINDBUFFERSBASEPROC( target.l, first.l, count.l, *buffers.long )
  PrototypeC PFNGLBINDBUFFERSRANGEPROC( target.l, first.l, count.l, *buffers.long, *offsets.integer, *sizes.integer )
  PrototypeC PFNGLBINDIMAGETEXTURESPROC( first.l, count.l, *textures.long )
  PrototypeC PFNGLBINDSAMPLERSPROC( first.l, count.l, *samplers.long )
  PrototypeC PFNGLBINDTEXTURESPROC( first.l, count.l, *textures.long )
  PrototypeC PFNGLBINDVERTEXBUFFERSPROC( first.l, count.l, *buffers.long, *offsets.integer, *strides.long )
  PrototypeC PFNGLMULTIDRAWARRAYSINDIRECTPROC( mode.l, *indirect, primcount.l, stride.l )
  PrototypeC PFNGLMULTIDRAWELEMENTSINDIRECTPROC( mode.l, type.l, *indirect, primcount.l, stride.l )
  PrototypeC PFNGLPOLYGONOFFSETCLAMPPROC( factor.f, units.f, clamp.f )
  PrototypeC PFNGLGETPROGRAMINTERFACEIVPROC( program.l, programInterface.l, pname.l, *params.long )
  PrototypeC.l PFNGLGETPROGRAMRESOURCEINDEXPROC( program.l, programInterface.l, name.p-ascii )
  PrototypeC.l PFNGLGETPROGRAMRESOURCELOCATIONPROC( program.l, programInterface.l, name.p-ascii )
  PrototypeC.l PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC( program.l, programInterface.l, name.p-ascii )
  PrototypeC PFNGLGETPROGRAMRESOURCENAMEPROC( program.l, programInterface.l, index.l, bufSize.l, *length.long, *name )
  PrototypeC PFNGLGETPROGRAMRESOURCEIVPROC( program.l, programInterface.l, index.l, propCount.l, *props.long, bufSize.l, *length.long, *params.long )
  PrototypeC PFNGLPROVOKINGVERTEXPROC( mode.l )
  PrototypeC PFNGLBINDSAMPLERPROC( unit.l, sampler.l )
  PrototypeC PFNGLDELETESAMPLERSPROC( count.l, *v2.long )
  PrototypeC PFNGLGENSAMPLERSPROC( count.l, *samplers.long )
  PrototypeC PFNGLGETSAMPLERPARAMETERIIVPROC( sampler.l, pname.l, *params.long )
  PrototypeC PFNGLGETSAMPLERPARAMETERIUIVPROC( sampler.l, pname.l, *params.long )
  PrototypeC PFNGLGETSAMPLERPARAMETERFVPROC( sampler.l, pname.l, *params.float )
  PrototypeC PFNGLGETSAMPLERPARAMETERIVPROC( sampler.l, pname.l, *params.long )
  PrototypeC.a PFNGLISSAMPLERPROC( sampler.l )
  PrototypeC PFNGLSAMPLERPARAMETERIIVPROC( sampler.l, pname.l, *params.long )
  PrototypeC PFNGLSAMPLERPARAMETERIUIVPROC( sampler.l, pname.l, *params.long )
  PrototypeC PFNGLSAMPLERPARAMETERFPROC( sampler.l, pname.l, param.f )
  PrototypeC PFNGLSAMPLERPARAMETERFVPROC( sampler.l, pname.l, *params.float )
  PrototypeC PFNGLSAMPLERPARAMETERIPROC( sampler.l, pname.l, param.l )
  PrototypeC PFNGLSAMPLERPARAMETERIVPROC( sampler.l, pname.l, *params.long )
  PrototypeC PFNGLACTIVESHADERPROGRAMPROC( pipeline.l, program.l )
  PrototypeC PFNGLBINDPROGRAMPIPELINEPROC( pipeline.l )
  PrototypeC.l PFNGLCREATESHADERPROGRAMVPROC( type.l, count.l, v3.p-ascii )
  PrototypeC PFNGLDELETEPROGRAMPIPELINESPROC( n.l, *pipelines.long )
  PrototypeC PFNGLGENPROGRAMPIPELINESPROC( n.l, *pipelines.long )
  PrototypeC PFNGLGETPROGRAMPIPELINEINFOLOGPROC( pipeline.l, bufSize.l, *length.long, *infoLog )
  PrototypeC PFNGLGETPROGRAMPIPELINEIVPROC( pipeline.l, pname.l, *params.long )
  PrototypeC.a PFNGLISPROGRAMPIPELINEPROC( pipeline.l )
  PrototypeC PFNGLPROGRAMUNIFORM1DPROC( program.l, location.l, x.d )
  PrototypeC PFNGLPROGRAMUNIFORM1DVPROC( program.l, location.l, count.l, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORM1FPROC( program.l, location.l, x.f )
  PrototypeC PFNGLPROGRAMUNIFORM1FVPROC( program.l, location.l, count.l, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORM1IPROC( program.l, location.l, x.l )
  PrototypeC PFNGLPROGRAMUNIFORM1IVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM1UIPROC( program.l, location.l, x.l )
  PrototypeC PFNGLPROGRAMUNIFORM1UIVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM2DPROC( program.l, location.l, x.d, y.d )
  PrototypeC PFNGLPROGRAMUNIFORM2DVPROC( program.l, location.l, count.l, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORM2FPROC( program.l, location.l, x.f, y.f )
  PrototypeC PFNGLPROGRAMUNIFORM2FVPROC( program.l, location.l, count.l, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORM2IPROC( program.l, location.l, x.l, y.l )
  PrototypeC PFNGLPROGRAMUNIFORM2IVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM2UIPROC( program.l, location.l, x.l, y.l )
  PrototypeC PFNGLPROGRAMUNIFORM2UIVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM3DPROC( program.l, location.l, x.d, y.d, z.d )
  PrototypeC PFNGLPROGRAMUNIFORM3DVPROC( program.l, location.l, count.l, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORM3FPROC( program.l, location.l, x.f, y.f, z.f )
  PrototypeC PFNGLPROGRAMUNIFORM3FVPROC( program.l, location.l, count.l, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORM3IPROC( program.l, location.l, x.l, y.l, z.l )
  PrototypeC PFNGLPROGRAMUNIFORM3IVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM3UIPROC( program.l, location.l, x.l, y.l, z.l )
  PrototypeC PFNGLPROGRAMUNIFORM3UIVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM4DPROC( program.l, location.l, x.d, y.d, z.d, w.d )
  PrototypeC PFNGLPROGRAMUNIFORM4DVPROC( program.l, location.l, count.l, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORM4FPROC( program.l, location.l, x.f, y.f, z.f, w.f )
  PrototypeC PFNGLPROGRAMUNIFORM4FVPROC( program.l, location.l, count.l, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORM4IPROC( program.l, location.l, x.l, y.l, z.l, w.l )
  PrototypeC PFNGLPROGRAMUNIFORM4IVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORM4UIPROC( program.l, location.l, x.l, y.l, z.l, w.l )
  PrototypeC PFNGLPROGRAMUNIFORM4UIVPROC( program.l, location.l, count.l, *value.long )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX2DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX2FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX3DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX3FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX4DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX4FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC( program.l, location.l, count.l, transpose.a, *value.double )
  PrototypeC PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC( program.l, location.l, count.l, transpose.a, *value.float )
  PrototypeC PFNGLUSEPROGRAMSTAGESPROC( pipeline.l, stages.l, program.l )
  PrototypeC PFNGLVALIDATEPROGRAMPIPELINEPROC( pipeline.l )
  PrototypeC PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC( program.l, bufferIndex.l, pname.l, *params.long )
  PrototypeC PFNGLBINDIMAGETEXTUREPROC( unit.l, texture.l, level.l, layered.a, layer.l, access.l, format.l )
  PrototypeC PFNGLMEMORYBARRIERPROC( barriers.l )
  PrototypeC PFNGLSHADERSTORAGEBLOCKBINDINGPROC( program.l, storageBlockIndex.l, storageBlockBinding.l )
  PrototypeC PFNGLGETACTIVESUBROUTINENAMEPROC( program.l, shadertype.l, index.l, bufsize.l, *length.long, *name )
  PrototypeC PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC( program.l, shadertype.l, index.l, bufsize.l, *length.long, *name )
  PrototypeC PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC( program.l, shadertype.l, index.l, pname.l, *values.long )
  PrototypeC PFNGLGETPROGRAMSTAGEIVPROC( program.l, shadertype.l, pname.l, *values.long )
  PrototypeC.l PFNGLGETSUBROUTINEINDEXPROC( program.l, shadertype.l, name.p-ascii )
  PrototypeC.l PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC( program.l, shadertype.l, name.p-ascii )
  PrototypeC PFNGLGETUNIFORMSUBROUTINEUIVPROC( shadertype.l, location.l, *params.long )
  PrototypeC PFNGLUNIFORMSUBROUTINESUIVPROC( shadertype.l, count.l, *indices.long )
  PrototypeC.l PFNGLCLIENTWAITSYNCPROC( GLsync.i, flags.l, timeout.q )
  PrototypeC PFNGLDELETESYNCPROC( GLsync.i )
  PrototypeC.i PFNGLFENCESYNCPROC( condition.l, flags.l )
  PrototypeC PFNGLGETINTEGER64VPROC( pname.l, *params.quad )
  PrototypeC PFNGLGETSYNCIVPROC( GLsync.i, pname.l, bufSize.l, *length.long, *values.long )
  PrototypeC.a PFNGLISSYNCPROC( GLsync.i )
  PrototypeC PFNGLWAITSYNCPROC( GLsync.i, flags.l, timeout.q )
  PrototypeC PFNGLPATCHPARAMETERFVPROC( pname.l, *values.float )
  PrototypeC PFNGLPATCHPARAMETERIPROC( pname.l, value.l )
  PrototypeC PFNGLTEXTUREBARRIERPROC(  )
  PrototypeC PFNGLTEXBUFFERRANGEPROC( target.l, internalformat.l, buffer.l, offset.i, size.i )
  PrototypeC PFNGLGETMULTISAMPLEFVPROC( pname.l, index.l, *val.float )
  PrototypeC PFNGLSAMPLEMASKIPROC( index.l, mask.l )
  PrototypeC PFNGLTEXIMAGE2DMULTISAMPLEPROC( target.l, samples.l, internalformat.l, width.l, height.l, fixedsamplelocations.a )
  PrototypeC PFNGLTEXIMAGE3DMULTISAMPLEPROC( target.l, samples.l, internalformat.l, width.l, height.l, depth.l, fixedsamplelocations.a )
  PrototypeC PFNGLTEXSTORAGE1DPROC( target.l, levels.l, internalformat.l, width.l )
  PrototypeC PFNGLTEXSTORAGE2DPROC( target.l, levels.l, internalformat.l, width.l, height.l )
  PrototypeC PFNGLTEXSTORAGE3DPROC( target.l, levels.l, internalformat.l, width.l, height.l, depth.l )
  PrototypeC PFNGLTEXSTORAGE2DMULTISAMPLEPROC( target.l, samples.l, internalformat.l, width.l, height.l, fixedsamplelocations.a )
  PrototypeC PFNGLTEXSTORAGE3DMULTISAMPLEPROC( target.l, samples.l, internalformat.l, width.l, height.l, depth.l, fixedsamplelocations.a )
  PrototypeC PFNGLTEXTUREVIEWPROC( texture.l, target.l, origtexture.l, internalformat.l, minlevel.l, numlevels.l, minlayer.l, numlayers.l )
  PrototypeC PFNGLGETQUERYOBJECTI64VPROC( id.l, pname.l, *params.quad )
  PrototypeC PFNGLGETQUERYOBJECTUI64VPROC( id.l, pname.l, *params.quad )
  PrototypeC PFNGLQUERYCOUNTERPROC( id.l, target.l )
  PrototypeC PFNGLBINDTRANSFORMFEEDBACKPROC( target.l, id.l )
  PrototypeC PFNGLDELETETRANSFORMFEEDBACKSPROC( n.l, *ids.long )
  PrototypeC PFNGLDRAWTRANSFORMFEEDBACKPROC( mode.l, id.l )
  PrototypeC PFNGLGENTRANSFORMFEEDBACKSPROC( n.l, *ids.long )
  PrototypeC.a PFNGLISTRANSFORMFEEDBACKPROC( id.l )
  PrototypeC PFNGLPAUSETRANSFORMFEEDBACKPROC(  )
  PrototypeC PFNGLRESUMETRANSFORMFEEDBACKPROC(  )
  PrototypeC PFNGLBEGINQUERYINDEXEDPROC( target.l, index.l, id.l )
  PrototypeC PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC( mode.l, id.l, stream.l )
  PrototypeC PFNGLENDQUERYINDEXEDPROC( target.l, index.l )
  PrototypeC PFNGLGETQUERYINDEXEDIVPROC( target.l, index.l, pname.l, *params.long )
  PrototypeC PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC( mode.l, id.l, primcount.l )
  PrototypeC PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC( mode.l, id.l, stream.l, primcount.l )
  PrototypeC PFNGLBINDBUFFERBASEPROC( target.l, index.l, buffer.l )
  PrototypeC PFNGLBINDBUFFERRANGEPROC( target.l, index.l, buffer.l, offset.i, size.i )
  PrototypeC PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC( program.l, uniformBlockIndex.l, bufSize.l, *length.long, *uniformBlockName )
  PrototypeC PFNGLGETACTIVEUNIFORMBLOCKIVPROC( program.l, uniformBlockIndex.l, pname.l, *params.long )
  PrototypeC PFNGLGETACTIVEUNIFORMNAMEPROC( program.l, uniformIndex.l, bufSize.l, *length.long, *uniformName )
  PrototypeC PFNGLGETACTIVEUNIFORMSIVPROC( program.l, uniformCount.l, *uniformIndices.long, pname.l, *params.long )
  PrototypeC PFNGLGETINTEGERI_VPROC( target.l, index.l, *data.long )
  PrototypeC.l PFNGLGETUNIFORMBLOCKINDEXPROC( program.l, uniformBlockName.p-ascii )
  PrototypeC PFNGLGETUNIFORMINDICESPROC( program.l, uniformCount.l, const.p-ascii, *uniformIndices.long )
  PrototypeC PFNGLUNIFORMBLOCKBINDINGPROC( program.l, uniformBlockIndex.l, uniformBlockBinding.l )
  PrototypeC PFNGLBINDVERTEXARRAYPROC( array.l )
  PrototypeC PFNGLDELETEVERTEXARRAYSPROC( n.l, *arrays.long )
  PrototypeC PFNGLGENVERTEXARRAYSPROC( n.l, *arrays.long )
  PrototypeC.a PFNGLISVERTEXARRAYPROC( array.l )
  PrototypeC PFNGLGETVERTEXATTRIBLDVPROC( index.l, pname.l, *params.double )
  PrototypeC PFNGLVERTEXATTRIBL1DPROC( index.l, x.d )
  PrototypeC PFNGLVERTEXATTRIBL1DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIBL2DPROC( index.l, x.d, y.d )
  PrototypeC PFNGLVERTEXATTRIBL2DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIBL3DPROC( index.l, x.d, y.d, z.d )
  PrototypeC PFNGLVERTEXATTRIBL3DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIBL4DPROC( index.l, x.d, y.d, z.d, w.d )
  PrototypeC PFNGLVERTEXATTRIBL4DVPROC( index.l, *v.double )
  PrototypeC PFNGLVERTEXATTRIBLPOINTERPROC( index.l, size.l, type.l, stride.l, *pointer )
  PrototypeC PFNGLBINDVERTEXBUFFERPROC( bindingindex.l, buffer.l, offset.i, stride.l )
  PrototypeC PFNGLVERTEXATTRIBBINDINGPROC( attribindex.l, bindingindex.l )
  PrototypeC PFNGLVERTEXATTRIBFORMATPROC( attribindex.l, size.l, type.l, normalized.a, relativeoffset.l )
  PrototypeC PFNGLVERTEXATTRIBIFORMATPROC( attribindex.l, size.l, type.l, relativeoffset.l )
  PrototypeC PFNGLVERTEXATTRIBLFORMATPROC( attribindex.l, size.l, type.l, relativeoffset.l )
  PrototypeC PFNGLVERTEXBINDINGDIVISORPROC( bindingindex.l, divisor.l )
  PrototypeC PFNGLCOLORP3UIPROC( type.l, color.l )
  PrototypeC PFNGLCOLORP3UIVPROC( type.l, *color.long )
  PrototypeC PFNGLCOLORP4UIPROC( type.l, color.l )
  PrototypeC PFNGLCOLORP4UIVPROC( type.l, *color.long )
  PrototypeC PFNGLMULTITEXCOORDP1UIPROC( texture.l, type.l, coords.l )
  PrototypeC PFNGLMULTITEXCOORDP1UIVPROC( texture.l, type.l, *coords.long )
  PrototypeC PFNGLMULTITEXCOORDP2UIPROC( texture.l, type.l, coords.l )
  PrototypeC PFNGLMULTITEXCOORDP2UIVPROC( texture.l, type.l, *coords.long )
  PrototypeC PFNGLMULTITEXCOORDP3UIPROC( texture.l, type.l, coords.l )
  PrototypeC PFNGLMULTITEXCOORDP3UIVPROC( texture.l, type.l, *coords.long )
  PrototypeC PFNGLMULTITEXCOORDP4UIPROC( texture.l, type.l, coords.l )
  PrototypeC PFNGLMULTITEXCOORDP4UIVPROC( texture.l, type.l, *coords.long )
  PrototypeC PFNGLNORMALP3UIPROC( type.l, coords.l )
  PrototypeC PFNGLNORMALP3UIVPROC( type.l, *coords.long )
  PrototypeC PFNGLSECONDARYCOLORP3UIPROC( type.l, color.l )
  PrototypeC PFNGLSECONDARYCOLORP3UIVPROC( type.l, *color.long )
  PrototypeC PFNGLTEXCOORDP1UIPROC( type.l, coords.l )
  PrototypeC PFNGLTEXCOORDP1UIVPROC( type.l, *coords.long )
  PrototypeC PFNGLTEXCOORDP2UIPROC( type.l, coords.l )
  PrototypeC PFNGLTEXCOORDP2UIVPROC( type.l, *coords.long )
  PrototypeC PFNGLTEXCOORDP3UIPROC( type.l, coords.l )
  PrototypeC PFNGLTEXCOORDP3UIVPROC( type.l, *coords.long )
  PrototypeC PFNGLTEXCOORDP4UIPROC( type.l, coords.l )
  PrototypeC PFNGLTEXCOORDP4UIVPROC( type.l, *coords.long )
  PrototypeC PFNGLVERTEXATTRIBP1UIPROC( index.l, type.l, normalized.a, value.l )
  PrototypeC PFNGLVERTEXATTRIBP1UIVPROC( index.l, type.l, normalized.a, *value.long )
  PrototypeC PFNGLVERTEXATTRIBP2UIPROC( index.l, type.l, normalized.a, value.l )
  PrototypeC PFNGLVERTEXATTRIBP2UIVPROC( index.l, type.l, normalized.a, *value.long )
  PrototypeC PFNGLVERTEXATTRIBP3UIPROC( index.l, type.l, normalized.a, value.l )
  PrototypeC PFNGLVERTEXATTRIBP3UIVPROC( index.l, type.l, normalized.a, *value.long )
  PrototypeC PFNGLVERTEXATTRIBP4UIPROC( index.l, type.l, normalized.a, value.l )
  PrototypeC PFNGLVERTEXATTRIBP4UIVPROC( index.l, type.l, normalized.a, *value.long )
  PrototypeC PFNGLVERTEXP2UIPROC( type.l, value.l )
  PrototypeC PFNGLVERTEXP2UIVPROC( type.l, *value.long )
  PrototypeC PFNGLVERTEXP3UIPROC( type.l, value.l )
  PrototypeC PFNGLVERTEXP3UIVPROC( type.l, *value.long )
  PrototypeC PFNGLVERTEXP4UIPROC( type.l, value.l )
  PrototypeC PFNGLVERTEXP4UIVPROC( type.l, *value.long )
  PrototypeC PFNGLDEPTHRANGEARRAYVPROC( first.l, count.l, *v3.double )
  PrototypeC PFNGLDEPTHRANGEINDEXEDPROC( index.l, n.d, f.d )
  PrototypeC PFNGLGETDOUBLEI_VPROC( target.l, index.l, *data.double )
  PrototypeC PFNGLGETFLOATI_VPROC( target.l, index.l, *data.float )
  PrototypeC PFNGLSCISSORARRAYVPROC( first.l, count.l, *v3.long )
  PrototypeC PFNGLSCISSORINDEXEDPROC( index.l, left.l, bottom.l, width.l, height.l )
  PrototypeC PFNGLSCISSORINDEXEDVPROC( index.l, *v2.long )
  PrototypeC PFNGLVIEWPORTARRAYVPROC( first.l, count.l, *v3.float )
  PrototypeC PFNGLVIEWPORTINDEXEDFPROC( index.l, x.f, y.f, w.f, h.f )
  PrototypeC PFNGLVIEWPORTINDEXEDFVPROC( index.l, *v2.float )
  PrototypeC.i PFNGLCREATEARRAYSETEXTPROC(  )
  PrototypeC PFNGLDEBUGMESSAGECALLBACKPROC( callback.i, *userParam )
  PrototypeC PFNGLDEBUGMESSAGECONTROLPROC( source.l, type.l, severity.l, count.l, *ids.long, enabled.a )
  PrototypeC PFNGLDEBUGMESSAGEINSERTPROC( source.l, type.l, id.l, severity.l, length.l, buf.p-ascii )
  PrototypeC.l PFNGLGETDEBUGMESSAGELOGPROC( count.l, bufSize.l, *sources.long, *types.long, *ids.long, *severities.long, *lengths.long, *messageLog )
  PrototypeC PFNGLGETOBJECTLABELPROC( identifier.l, name.l, bufSize.l, *length.long, *label )
  PrototypeC PFNGLGETOBJECTPTRLABELPROC( *ptr, bufSize.l, *length.long, *label )
  PrototypeC PFNGLOBJECTLABELPROC( identifier.l, name.l, length.l, label.p-ascii )
  PrototypeC PFNGLOBJECTPTRLABELPROC( *ptr, length.l, label.p-ascii )
  PrototypeC PFNGLPOPDEBUGGROUPPROC(  )
  PrototypeC PFNGLPUSHDEBUGGROUPPROC( source.l, id.l, length.l, v4.p-ascii )
  PrototypeC PFNGLGETNUNIFORMFVPROC( program.l, location.l, bufSize.l, *params.float )
  PrototypeC PFNGLGETNUNIFORMIVPROC( program.l, location.l, bufSize.l, *params.long )
  PrototypeC PFNGLGETNUNIFORMUIVPROC( program.l, location.l, bufSize.l, *params.long )
  PrototypeC PFNGLREADNPIXELSPROC( x.l, y.l, width.l, height.l, format.l, type.l, bufSize.l, *data )
  PrototypeC.l PFNGLBUFFERREGIONENABLEDPROC(  )
  PrototypeC PFNGLDELETEBUFFERREGIONPROC( region.l )
  PrototypeC PFNGLDRAWBUFFERREGIONPROC( region.l, x.l, y.l, width.l, height.l, xDest.l, yDest.l )
  PrototypeC.l PFNGLNEWBUFFERREGIONPROC( region.l )
  PrototypeC PFNGLREADBUFFERREGIONPROC( region.l, x.l, y.l, width.l, height.l )
  PrototypeC PFNGLALPHAFUNCXPROC( func.l, ref.i )
  PrototypeC PFNGLCLEARCOLORXPROC( red.i, green.i, blue.i, alpha.i )
  PrototypeC PFNGLCLEARDEPTHXPROC( depth.i )
  PrototypeC PFNGLCOLOR4XPROC( red.i, green.i, blue.i, alpha.i )
  PrototypeC PFNGLDEPTHRANGEXPROC( zNear.i, zFar.i )
  PrototypeC PFNGLFOGXPROC( pname.l, param.i )
  PrototypeC PFNGLFOGXVPROC( pname.l, *params.integer )
  PrototypeC PFNGLFRUSTUMFPROC( left.f, right.f, bottom.f, top.f, zNear.f, zFar.f )
  PrototypeC PFNGLFRUSTUMXPROC( left.i, right.i, bottom.i, top.i, zNear.i, zFar.i )
  PrototypeC PFNGLLIGHTMODELXPROC( pname.l, param.i )
  PrototypeC PFNGLLIGHTMODELXVPROC( pname.l, *params.integer )
  PrototypeC PFNGLLIGHTXPROC( light.l, pname.l, param.i )
  PrototypeC PFNGLLIGHTXVPROC( light.l, pname.l, *params.integer )
  PrototypeC PFNGLLINEWIDTHXPROC( width.i )
  PrototypeC PFNGLLOADMATRIXXPROC( *m.integer )
  PrototypeC PFNGLMATERIALXPROC( face.l, pname.l, param.i )
  PrototypeC PFNGLMATERIALXVPROC( face.l, pname.l, *params.integer )
  PrototypeC PFNGLMULTMATRIXXPROC( *m.integer )
  PrototypeC PFNGLMULTITEXCOORD4XPROC( target.l, s.i, t.i, r.i, q.i )
  PrototypeC PFNGLNORMAL3XPROC( nx.i, ny.i, nz.i )
  PrototypeC PFNGLORTHOFPROC( left.f, right.f, bottom.f, top.f, zNear.f, zFar.f )
  PrototypeC PFNGLORTHOXPROC( left.i, right.i, bottom.i, top.i, zNear.i, zFar.i )
  PrototypeC PFNGLPOINTSIZEXPROC( size.i )
  PrototypeC PFNGLPOLYGONOFFSETXPROC( factor.i, units.i )
  PrototypeC PFNGLROTATEXPROC( angle.i, x.i, y.i, z.i )
  PrototypeC PFNGLSAMPLECOVERAGEXPROC( value.i, invert.a )
  PrototypeC PFNGLSCALEXPROC( x.i, y.i, z.i )
  PrototypeC PFNGLTEXENVXPROC( target.l, pname.l, param.i )
  PrototypeC PFNGLTEXENVXVPROC( target.l, pname.l, *params.integer )
  PrototypeC PFNGLTEXPARAMETERXPROC( target.l, pname.l, param.i )
  PrototypeC PFNGLTRANSLATEXPROC( x.i, y.i, z.i )
  PrototypeC PFNGLCLIPPLANEFPROC( plane.l, *equation.float )
  PrototypeC PFNGLCLIPPLANEXPROC( plane.l, *equation.integer )
  PrototypeC PFNGLGETCLIPPLANEFPROC( pname.l, *array_4_eqn )
  PrototypeC PFNGLGETCLIPPLANEXPROC( pname.l, *array_4_eqn )
  PrototypeC PFNGLGETFIXEDVPROC( pname.l, *params.integer )
  PrototypeC PFNGLGETLIGHTXVPROC( light.l, pname.l, *params.integer )
  PrototypeC PFNGLGETMATERIALXVPROC( face.l, pname.l, *params.integer )
  PrototypeC PFNGLGETTEXENVXVPROC( env.l, pname.l, *params.integer )
  PrototypeC PFNGLGETTEXPARAMETERXVPROC( target.l, pname.l, *params.integer )
  PrototypeC PFNGLPOINTPARAMETERXPROC( pname.l, param.i )
  PrototypeC PFNGLPOINTPARAMETERXVPROC( pname.l, *params.integer )
  PrototypeC PFNGLTEXPARAMETERXVPROC( target.l, pname.l, *params.integer )
  PrototypeC PFNGLADDRESSSPACEPROC( space.l, mask.l )
  PrototypeC.l PFNGLDATAPIPEPROC( space.l )
  PrototypeC PFNGLGETMPEGQUANTTABLEUBVPROC( target.l, *values.ascii )
  PrototypeC PFNGLMPEGQUANTTABLEUBVPROC( target.l, *values.ascii )
;}
EndDeclareModule
XIncludeFile "_module__gl.pbi"
DeclareModule gl
  EnableExplicit
  Declare.l Init()
  Declare Quit()
  Macro byte:b:EndMacro 
  Macro ubyte:a:EndMacro: Macro UNSIGNED_BYTE:a:EndMacro
  Macro short:w:EndMacro 
  Macro ushort:u:EndMacro : Macro UNSIGNED_SHORT:u:EndMacro
  Macro int:l: EndMacro
  Macro uint:l:EndMacro : Macro UNSIGNED_INT:l:EndMacro
  Macro fixed:l:EndMacro 
  Macro int64:q:EndMacro
  Macro uint64:q:EndMacro
  Macro sizei:l:EndMacro
  Macro enum:l:EndMacro
  Macro intptr:i:EndMacro
  Macro sizeiptr:i:EndMacro
  Macro sync:i:EndMacro
  Macro bitfield:l:EndMacro
  ;GLhalf GL_HALF_FLOAT
  Macro float:f:EndMacro
  Macro clampf:f:EndMacro
  Macro double:d:EndMacro 
  Macro clampd:d:EndMacro
;-----------------------
;- _opengl.pbi
;{

CompilerIf _gl::GL_VERSION_ATLEAST(1,1,0)
  #ZERO = 0
  #FALSE = 0
  #LOGIC_OP = $0BF1
  #NONE = 0
  #TEXTURE_COMPONENTS = $1003
  #NO_ERROR = 0
  #POINTS = $0000
  #CURRENT_BIT = $00000001
  #TRUE = 1
  #ONE = 1
  #CLIENT_PIXEL_STORE_BIT = $00000001
  #LINES = $0001
  #LINE_LOOP = $0002
  #POINT_BIT = $00000002
  #CLIENT_VERTEX_ARRAY_BIT = $00000002
  #LINE_STRIP = $0003
  #LINE_BIT = $00000004
  #TRIANGLES = $0004
  #TRIANGLE_STRIP = $0005
  #TRIANGLE_FAN = $0006
  #QUADS = $0007
  #QUAD_STRIP = $0008
  #POLYGON_BIT = $00000008
  #POLYGON = $0009
  #POLYGON_STIPPLE_BIT = $00000010
  #PIXEL_MODE_BIT = $00000020
  #LIGHTING_BIT = $00000040
  #FOG_BIT = $00000080
  #DEPTH_BUFFER_BIT = $00000100
  #ACCUM = $0100
  #LOAD = $0101
  #RETURN = $0102
  #MULT = $0103
  #ADD = $0104
  #NEVER = $0200
  #ACCUM_BUFFER_BIT = $00000200
  #LESS = $0201
  #EQUAL = $0202
  #LEQUAL = $0203
  #GREATER = $0204
  #NOTEQUAL = $0205
  #GEQUAL = $0206
  #ALWAYS = $0207
  #SRC_COLOR = $0300
  #ONE_MINUS_SRC_COLOR = $0301
  #SRC_ALPHA = $0302
  #ONE_MINUS_SRC_ALPHA = $0303
  #DST_ALPHA = $0304
  #ONE_MINUS_DST_ALPHA = $0305
  #DST_COLOR = $0306
  #ONE_MINUS_DST_COLOR = $0307
  #SRC_ALPHA_SATURATE = $0308
  #STENCIL_BUFFER_BIT = $00000400
  #FRONT_LEFT = $0400
  #FRONT_RIGHT = $0401
  #BACK_LEFT = $0402
  #BACK_RIGHT = $0403
  #FRONT = $0404
  #BACK = $0405
  #LEFT = $0406
  #RIGHT = $0407
  #FRONT_AND_BACK = $0408
  #AUX0 = $0409
  #AUX1 = $040A
  #AUX2 = $040B
  #AUX3 = $040C
  #INVALID_ENUM = $0500
  #INVALID_VALUE = $0501
  #INVALID_OPERATION = $0502
  #STACK_OVERFLOW = $0503
  #STACK_UNDERFLOW = $0504
  #OUT_OF_MEMORY = $0505
  #_2D = $0600
  #_3D = $0601
  #_3D_COLOR = $0602
  #_3D_COLOR_TEXTURE = $0603
  #_4D_COLOR_TEXTURE = $0604
  #PASS_THROUGH_TOKEN = $0700
  #POINT_TOKEN = $0701
  #LINE_TOKEN = $0702
  #POLYGON_TOKEN = $0703
  #BITMAP_TOKEN = $0704
  #DRAW_PIXEL_TOKEN = $0705
  #COPY_PIXEL_TOKEN = $0706
  #LINE_RESET_TOKEN = $0707
  #EXP = $0800
  #VIEWPORT_BIT = $00000800
  #EXP2 = $0801
  #CW = $0900
  #CCW = $0901
  #COEFF = $0A00
  #ORDER = $0A01
  #DOMAIN = $0A02
  #CURRENT_COLOR = $0B00
  #CURRENT_INDEX = $0B01
  #CURRENT_NORMAL = $0B02
  #CURRENT_TEXTURE_COORDS = $0B03
  #CURRENT_RASTER_COLOR = $0B04
  #CURRENT_RASTER_INDEX = $0B05
  #CURRENT_RASTER_TEXTURE_COORDS = $0B06
  #CURRENT_RASTER_POSITION = $0B07
  #CURRENT_RASTER_POSITION_VALID = $0B08
  #CURRENT_RASTER_DISTANCE = $0B09
  #POINT_SMOOTH = $0B10
  #POINT_SIZE = $0B11
  #POINT_SIZE_RANGE = $0B12
  #POINT_SIZE_GRANULARITY = $0B13
  #LINE_SMOOTH = $0B20
  #LINE_WIDTH = $0B21
  #LINE_WIDTH_RANGE = $0B22
  #LINE_WIDTH_GRANULARITY = $0B23
  #LINE_STIPPLE = $0B24
  #LINE_STIPPLE_PATTERN = $0B25
  #LINE_STIPPLE_REPEAT = $0B26
  #LIST_MODE = $0B30
  #MAX_LIST_NESTING = $0B31
  #LIST_BASE = $0B32
  #LIST_INDEX = $0B33
  #POLYGON_MODE = $0B40
  #POLYGON_SMOOTH = $0B41
  #POLYGON_STIPPLE = $0B42
  #EDGE_FLAG = $0B43
  #CULL_FACE = $0B44
  #CULL_FACE_MODE = $0B45
  #FRONT_FACE = $0B46
  #LIGHTING = $0B50
  #LIGHT_MODEL_LOCAL_VIEWER = $0B51
  #LIGHT_MODEL_TWO_SIDE = $0B52
  #LIGHT_MODEL_AMBIENT = $0B53
  #SHADE_MODEL = $0B54
  #COLOR_MATERIAL_FACE = $0B55
  #COLOR_MATERIAL_PARAMETER = $0B56
  #COLOR_MATERIAL = $0B57
  #FOG = $0B60
  #FOG_INDEX = $0B61
  #FOG_DENSITY = $0B62
  #FOG_START = $0B63
  #FOG_END = $0B64
  #FOG_MODE = $0B65
  #FOG_COLOR = $0B66
  #DEPTH_RANGE = $0B70
  #DEPTH_TEST = $0B71
  #DEPTH_WRITEMASK = $0B72
  #DEPTH_CLEAR_VALUE = $0B73
  #DEPTH_FUNC = $0B74
  #ACCUM_CLEAR_VALUE = $0B80
  #STENCIL_TEST = $0B90
  #STENCIL_CLEAR_VALUE = $0B91
  #STENCIL_FUNC = $0B92
  #STENCIL_VALUE_MASK = $0B93
  #STENCIL_FAIL = $0B94
  #STENCIL_PASS_DEPTH_FAIL = $0B95
  #STENCIL_PASS_DEPTH_PASS = $0B96
  #STENCIL_REF = $0B97
  #STENCIL_WRITEMASK = $0B98
  #MATRIX_MODE = $0BA0
  #NORMALIZE = $0BA1
  #VIEWPORT = $0BA2
  #MODELVIEW_STACK_DEPTH = $0BA3
  #PROJECTION_STACK_DEPTH = $0BA4
  #TEXTURE_STACK_DEPTH = $0BA5
  #MODELVIEW_MATRIX = $0BA6
  #PROJECTION_MATRIX = $0BA7
  #TEXTURE_MATRIX = $0BA8
  #ATTRIB_STACK_DEPTH = $0BB0
  #CLIENT_ATTRIB_STACK_DEPTH = $0BB1
  #ALPHA_TEST = $0BC0
  #ALPHA_TEST_FUNC = $0BC1
  #ALPHA_TEST_REF = $0BC2
  #DITHER = $0BD0
  #BLEND_DST = $0BE0
  #BLEND_SRC = $0BE1
  #BLEND = $0BE2
  #LOGIC_OP_MODE = $0BF0
  #INDEX_LOGIC_OP = $0BF1
  #COLOR_LOGIC_OP = $0BF2
  #AUX_BUFFERS = $0C00
  #DRAW_BUFFER = $0C01
  #READ_BUFFER = $0C02
  #SCISSOR_BOX = $0C10
  #SCISSOR_TEST = $0C11
  #INDEX_CLEAR_VALUE = $0C20
  #INDEX_WRITEMASK = $0C21
  #COLOR_CLEAR_VALUE = $0C22
  #COLOR_WRITEMASK = $0C23
  #INDEX_MODE = $0C30
  #RGBA_MODE = $0C31
  #DOUBLEBUFFER = $0C32
  #STEREO = $0C33
  #RENDER_MODE = $0C40
  #PERSPECTIVE_CORRECTION_HINT = $0C50
  #POINT_SMOOTH_HINT = $0C51
  #LINE_SMOOTH_HINT = $0C52
  #POLYGON_SMOOTH_HINT = $0C53
  #FOG_HINT = $0C54
  #TEXTURE_GEN_S = $0C60
  #TEXTURE_GEN_T = $0C61
  #TEXTURE_GEN_R = $0C62
  #TEXTURE_GEN_Q = $0C63
  #PIXEL_MAP_I_TO_I = $0C70
  #PIXEL_MAP_S_TO_S = $0C71
  #PIXEL_MAP_I_TO_R = $0C72
  #PIXEL_MAP_I_TO_G = $0C73
  #PIXEL_MAP_I_TO_B = $0C74
  #PIXEL_MAP_I_TO_A = $0C75
  #PIXEL_MAP_R_TO_R = $0C76
  #PIXEL_MAP_G_TO_G = $0C77
  #PIXEL_MAP_B_TO_B = $0C78
  #PIXEL_MAP_A_TO_A = $0C79
  #PIXEL_MAP_I_TO_I_SIZE = $0CB0
  #PIXEL_MAP_S_TO_S_SIZE = $0CB1
  #PIXEL_MAP_I_TO_R_SIZE = $0CB2
  #PIXEL_MAP_I_TO_G_SIZE = $0CB3
  #PIXEL_MAP_I_TO_B_SIZE = $0CB4
  #PIXEL_MAP_I_TO_A_SIZE = $0CB5
  #PIXEL_MAP_R_TO_R_SIZE = $0CB6
  #PIXEL_MAP_G_TO_G_SIZE = $0CB7
  #PIXEL_MAP_B_TO_B_SIZE = $0CB8
  #PIXEL_MAP_A_TO_A_SIZE = $0CB9
  #UNPACK_SWAP_BYTES = $0CF0
  #UNPACK_LSB_FIRST = $0CF1
  #UNPACK_ROW_LENGTH = $0CF2
  #UNPACK_SKIP_ROWS = $0CF3
  #UNPACK_SKIP_PIXELS = $0CF4
  #UNPACK_ALIGNMENT = $0CF5
  #PACK_SWAP_BYTES = $0D00
  #PACK_LSB_FIRST = $0D01
  #PACK_ROW_LENGTH = $0D02
  #PACK_SKIP_ROWS = $0D03
  #PACK_SKIP_PIXELS = $0D04
  #PACK_ALIGNMENT = $0D05
  #MAP_COLOR = $0D10
  #MAP_STENCIL = $0D11
  #INDEX_SHIFT = $0D12
  #INDEX_OFFSET = $0D13
  #RED_SCALE = $0D14
  #RED_BIAS = $0D15
  #ZOOM_X = $0D16
  #ZOOM_Y = $0D17
  #GREEN_SCALE = $0D18
  #GREEN_BIAS = $0D19
  #BLUE_SCALE = $0D1A
  #BLUE_BIAS = $0D1B
  #ALPHA_SCALE = $0D1C
  #ALPHA_BIAS = $0D1D
  #DEPTH_SCALE = $0D1E
  #DEPTH_BIAS = $0D1F
  #MAX_EVAL_ORDER = $0D30
  #MAX_LIGHTS = $0D31
  #MAX_CLIP_PLANES = $0D32
  #MAX_TEXTURE_SIZE = $0D33
  #MAX_PIXEL_MAP_TABLE = $0D34
  #MAX_ATTRIB_STACK_DEPTH = $0D35
  #MAX_MODELVIEW_STACK_DEPTH = $0D36
  #MAX_NAME_STACK_DEPTH = $0D37
  #MAX_PROJECTION_STACK_DEPTH = $0D38
  #MAX_TEXTURE_STACK_DEPTH = $0D39
  #MAX_VIEWPORT_DIMS = $0D3A
  #MAX_CLIENT_ATTRIB_STACK_DEPTH = $0D3B
  #SUBPIXEL_BITS = $0D50
  #INDEX_BITS = $0D51
  #RED_BITS = $0D52
  #GREEN_BITS = $0D53
  #BLUE_BITS = $0D54
  #ALPHA_BITS = $0D55
  #DEPTH_BITS = $0D56
  #STENCIL_BITS = $0D57
  #ACCUM_RED_BITS = $0D58
  #ACCUM_GREEN_BITS = $0D59
  #ACCUM_BLUE_BITS = $0D5A
  #ACCUM_ALPHA_BITS = $0D5B
  #NAME_STACK_DEPTH = $0D70
  #AUTO_NORMAL = $0D80
  #MAP1_COLOR_4 = $0D90
  #MAP1_INDEX = $0D91
  #MAP1_NORMAL = $0D92
  #MAP1_TEXTURE_COORD_1 = $0D93
  #MAP1_TEXTURE_COORD_2 = $0D94
  #MAP1_TEXTURE_COORD_3 = $0D95
  #MAP1_TEXTURE_COORD_4 = $0D96
  #MAP1_VERTEX_3 = $0D97
  #MAP1_VERTEX_4 = $0D98
  #MAP2_COLOR_4 = $0DB0
  #MAP2_INDEX = $0DB1
  #MAP2_NORMAL = $0DB2
  #MAP2_TEXTURE_COORD_1 = $0DB3
  #MAP2_TEXTURE_COORD_2 = $0DB4
  #MAP2_TEXTURE_COORD_3 = $0DB5
  #MAP2_TEXTURE_COORD_4 = $0DB6
  #MAP2_VERTEX_3 = $0DB7
  #MAP2_VERTEX_4 = $0DB8
  #MAP1_GRID_DOMAIN = $0DD0
  #MAP1_GRID_SEGMENTS = $0DD1
  #MAP2_GRID_DOMAIN = $0DD2
  #MAP2_GRID_SEGMENTS = $0DD3
  #TEXTURE_1D = $0DE0
  #TEXTURE_2D = $0DE1
  #FEEDBACK_BUFFER_POINTER = $0DF0
  #FEEDBACK_BUFFER_SIZE = $0DF1
  #FEEDBACK_BUFFER_TYPE = $0DF2
  #SELECTION_BUFFER_POINTER = $0DF3
  #SELECTION_BUFFER_SIZE = $0DF4
  #TEXTURE_WIDTH = $1000
  #TRANSFORM_BIT = $00001000
  #TEXTURE_HEIGHT = $1001
  #TEXTURE_INTERNAL_FORMAT = $1003
  #TEXTURE_BORDER_COLOR = $1004
  #TEXTURE_BORDER = $1005
  #DONT_CARE = $1100
  #FASTEST = $1101
  #NICEST = $1102
  #AMBIENT = $1200
  #DIFFUSE = $1201
  #SPECULAR = $1202
  #POSITION = $1203
  #SPOT_DIRECTION = $1204
  #SPOT_EXPONENT = $1205
  #SPOT_CUTOFF = $1206
  #CONSTANT_ATTENUATION = $1207
  #LINEAR_ATTENUATION = $1208
  #QUADRATIC_ATTENUATION = $1209
  #COMPILE = $1300
  #COMPILE_AND_EXECUTE = $1301
  #BYTE = $1400
  #UNSIGNED_BYTE = $1401
  #SHORT = $1402
  #UNSIGNED_SHORT = $1403
  #INT = $1404
  #UNSIGNED_INT = $1405
  #FLOAT = $1406
  #_2_BYTES = $1407
  #_3_BYTES = $1408
  #_4_BYTES = $1409
  #DOUBLE = $140A
  #CLEAR = $1500
  #AND = $1501
  #AND_REVERSE = $1502
  #COPY = $1503
  #AND_INVERTED = $1504
  #NOOP = $1505
  #XOR = $1506
  #OR = $1507
  #NOR = $1508
  #EQUIV = $1509
  #INVERT = $150A
  #OR_REVERSE = $150B
  #COPY_INVERTED = $150C
  #OR_INVERTED = $150D
  #NAND = $150E
  #SET = $150F
  #EMISSION = $1600
  #SHININESS = $1601
  #AMBIENT_AND_DIFFUSE = $1602
  #COLOR_INDEXES = $1603
  #MODELVIEW = $1700
  #PROJECTION = $1701
  #TEXTURE = $1702
  #COLOR = $1800
  #DEPTH = $1801
  #STENCIL = $1802
  #COLOR_INDEX = $1900
  #STENCIL_INDEX = $1901
  #DEPTH_COMPONENT = $1902
  #RED_ = $1903
  #GREEN_ = $1904
  #BLUE_ = $1905
  #ALPHA = $1906
  #RGB = $1907
  #RGBA = $1908
  #LUMINANCE = $1909
  #LUMINANCE_ALPHA = $190A
  #BITMAP = $1A00
  #POINT = $1B00
  #LINE = $1B01
  #FILL = $1B02
  #RENDER = $1C00
  #FEEDBACK = $1C01
  #SELECT = $1C02
  #FLAT = $1D00
  #SMOOTH = $1D01
  #KEEP = $1E00
  #REPLACE = $1E01
  #INCR = $1E02
  #DECR = $1E03
  #VENDOR = $1F00
  #RENDERER = $1F01
  #VERSION = $1F02
  #EXTENSIONS = $1F03
  #S = $2000
  #ENABLE_BIT = $00002000
  #T = $2001
  #R = $2002
  #Q = $2003
  #MODULATE = $2100
  #DECAL = $2101
  #TEXTURE_ENV_MODE = $2200
  #TEXTURE_ENV_COLOR = $2201
  #EYE_LINEAR = $2400
  #OBJECT_LINEAR = $2401
  #SPHERE_MAP = $2402
  #TEXTURE_GEN_MODE = $2500
  #OBJECT_PLANE = $2501
  #EYE_PLANE = $2502
  #NEAREST = $2600
  #LINEAR = $2601
  #NEAREST_MIPMAP_NEAREST = $2700
  #LINEAR_MIPMAP_NEAREST = $2701
  #NEAREST_MIPMAP_LINEAR = $2702
  #LINEAR_MIPMAP_LINEAR = $2703
  #TEXTURE_MAG_FILTER = $2800
  #TEXTURE_MIN_FILTER = $2801
  #TEXTURE_WRAP_S = $2802
  #TEXTURE_WRAP_T = $2803
  #CLAMP = $2900
  #REPEAT = $2901
  #POLYGON_OFFSET_UNITS = $2A00
  #POLYGON_OFFSET_POINT = $2A01
  #POLYGON_OFFSET_LINE = $2A02
  #R3_G3_B2 = $2A10
  #V2F = $2A20
  #V3F = $2A21
  #C4UB_V2F = $2A22
  #C4UB_V3F = $2A23
  #C3F_V3F = $2A24
  #N3F_V3F = $2A25
  #C4F_N3F_V3F = $2A26
  #T2F_V3F = $2A27
  #T4F_V4F = $2A28
  #T2F_C4UB_V3F = $2A29
  #T2F_C3F_V3F = $2A2A
  #T2F_N3F_V3F = $2A2B
  #T2F_C4F_N3F_V3F = $2A2C
  #T4F_C4F_N3F_V4F = $2A2D
  #CLIP_PLANE0 = $3000
  #CLIP_PLANE1 = $3001
  #CLIP_PLANE2 = $3002
  #CLIP_PLANE3 = $3003
  #CLIP_PLANE4 = $3004
  #CLIP_PLANE5 = $3005
  #LIGHT0 = $4000
  #COLOR_BUFFER_BIT = $00004000
  #LIGHT1 = $4001
  #LIGHT2 = $4002
  #LIGHT3 = $4003
  #LIGHT4 = $4004
  #LIGHT5 = $4005
  #LIGHT6 = $4006
  #LIGHT7 = $4007
  #HINT_BIT = $00008000
  #POLYGON_OFFSET_FILL = $8037
  #POLYGON_OFFSET_FACTOR = $8038
  #ALPHA4 = $803B
  #ALPHA8 = $803C
  #ALPHA12 = $803D
  #ALPHA16 = $803E
  #LUMINANCE4 = $803F
  #LUMINANCE8 = $8040
  #LUMINANCE12 = $8041
  #LUMINANCE16 = $8042
  #LUMINANCE4_ALPHA4 = $8043
  #LUMINANCE6_ALPHA2 = $8044
  #LUMINANCE8_ALPHA8 = $8045
  #LUMINANCE12_ALPHA4 = $8046
  #LUMINANCE12_ALPHA12 = $8047
  #LUMINANCE16_ALPHA16 = $8048
  #INTENSITY = $8049
  #INTENSITY4 = $804A
  #INTENSITY8 = $804B
  #INTENSITY12 = $804C
  #INTENSITY16 = $804D
  #RGB4 = $804F
  #RGB5 = $8050
  #RGB8 = $8051
  #RGB10 = $8052
  #RGB12 = $8053
  #RGB16 = $8054
  #RGBA2 = $8055
  #RGBA4 = $8056
  #RGB5_A1 = $8057
  #RGBA8 = $8058
  #RGB10_A2 = $8059
  #RGBA12 = $805A
  #RGBA16 = $805B
  #TEXTURE_RED_SIZE = $805C
  #TEXTURE_GREEN_SIZE = $805D
  #TEXTURE_BLUE_SIZE = $805E
  #TEXTURE_ALPHA_SIZE = $805F
  #TEXTURE_LUMINANCE_SIZE = $8060
  #TEXTURE_INTENSITY_SIZE = $8061
  #PROXY_TEXTURE_1D = $8063
  #PROXY_TEXTURE_2D = $8064
  #TEXTURE_PRIORITY = $8066
  #TEXTURE_RESIDENT = $8067
  #TEXTURE_BINDING_1D = $8068
  #TEXTURE_BINDING_2D = $8069
  #VERTEX_ARRAY = $8074
  #NORMAL_ARRAY = $8075
  #COLOR_ARRAY = $8076
  #INDEX_ARRAY = $8077
  #TEXTURE_COORD_ARRAY = $8078
  #EDGE_FLAG_ARRAY = $8079
  #VERTEX_ARRAY_SIZE = $807A
  #VERTEX_ARRAY_TYPE = $807B
  #VERTEX_ARRAY_STRIDE = $807C
  #NORMAL_ARRAY_TYPE = $807E
  #NORMAL_ARRAY_STRIDE = $807F
  #COLOR_ARRAY_SIZE = $8081
  #COLOR_ARRAY_TYPE = $8082
  #COLOR_ARRAY_STRIDE = $8083
  #INDEX_ARRAY_TYPE = $8085
  #INDEX_ARRAY_STRIDE = $8086
  #TEXTURE_COORD_ARRAY_SIZE = $8088
  #TEXTURE_COORD_ARRAY_TYPE = $8089
  #TEXTURE_COORD_ARRAY_STRIDE = $808A
  #EDGE_FLAG_ARRAY_STRIDE = $808C
  #VERTEX_ARRAY_POINTER = $808E
  #NORMAL_ARRAY_POINTER = $808F
  #COLOR_ARRAY_POINTER = $8090
  #INDEX_ARRAY_POINTER = $8091
  #TEXTURE_COORD_ARRAY_POINTER = $8092
  #EDGE_FLAG_ARRAY_POINTER = $8093
  #EVAL_BIT = $00010000
  #LIST_BIT = $00020000
  #TEXTURE_BIT = $00040000
  #SCISSOR_BIT = $00080000
  #ALL_ATTRIB_BITS = $000fffff
  #CLIENT_ALL_ATTRIB_BITS = $ffffffff
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,2,0)
  #SMOOTH_POINT_SIZE_RANGE = $0B12
  #SMOOTH_POINT_SIZE_GRANULARITY = $0B13
  #SMOOTH_LINE_WIDTH_RANGE = $0B22
  #SMOOTH_LINE_WIDTH_GRANULARITY = $0B23
  #UNSIGNED_BYTE_3_3_2 = $8032
  #UNSIGNED_SHORT_4_4_4_4 = $8033
  #UNSIGNED_SHORT_5_5_5_1 = $8034
  #UNSIGNED_INT_8_8_8_8 = $8035
  #UNSIGNED_INT_10_10_10_2 = $8036
  #RESCALE_NORMAL = $803A
  #TEXTURE_BINDING_3D = $806A
  #PACK_SKIP_IMAGES = $806B
  #PACK_IMAGE_HEIGHT = $806C
  #UNPACK_SKIP_IMAGES = $806D
  #UNPACK_IMAGE_HEIGHT = $806E
  #TEXTURE_3D = $806F
  #PROXY_TEXTURE_3D = $8070
  #TEXTURE_DEPTH = $8071
  #TEXTURE_WRAP_R = $8072
  #MAX_3D_TEXTURE_SIZE = $8073
  #BGR = $80E0
  #BGRA = $80E1
  #MAX_ELEMENTS_VERTICES = $80E8
  #MAX_ELEMENTS_INDICES = $80E9
  #CLAMP_TO_EDGE = $812F
  #TEXTURE_MIN_LOD = $813A
  #TEXTURE_MAX_LOD = $813B
  #TEXTURE_BASE_LEVEL = $813C
  #TEXTURE_MAX_LEVEL = $813D
  #LIGHT_MODEL_COLOR_CONTROL = $81F8
  #SINGLE_COLOR = $81F9
  #SEPARATE_SPECULAR_COLOR = $81FA
  #UNSIGNED_BYTE_2_3_3_REV = $8362
  #UNSIGNED_SHORT_5_6_5 = $8363
  #UNSIGNED_SHORT_5_6_5_REV = $8364
  #UNSIGNED_SHORT_4_4_4_4_REV = $8365
  #UNSIGNED_SHORT_1_5_5_5_REV = $8366
  #UNSIGNED_INT_8_8_8_8_REV = $8367
  #ALIASED_POINT_SIZE_RANGE = $846D
  #ALIASED_LINE_WIDTH_RANGE = $846E
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,2,1)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,3,0)
  #MULTISAMPLE = $809D
  #SAMPLE_ALPHA_TO_COVERAGE = $809E
  #SAMPLE_ALPHA_TO_ONE = $809F
  #SAMPLE_COVERAGE = $80A0
  #SAMPLE_BUFFERS = $80A8
  #SAMPLES = $80A9
  #SAMPLE_COVERAGE_VALUE = $80AA
  #SAMPLE_COVERAGE_INVERT = $80AB
  #CLAMP_TO_BORDER = $812D
  #TEXTURE0 = $84C0
  #TEXTURE1 = $84C1
  #TEXTURE2 = $84C2
  #TEXTURE3 = $84C3
  #TEXTURE4 = $84C4
  #TEXTURE5 = $84C5
  #TEXTURE6 = $84C6
  #TEXTURE7 = $84C7
  #TEXTURE8 = $84C8
  #TEXTURE9 = $84C9
  #TEXTURE10 = $84CA
  #TEXTURE11 = $84CB
  #TEXTURE12 = $84CC
  #TEXTURE13 = $84CD
  #TEXTURE14 = $84CE
  #TEXTURE15 = $84CF
  #TEXTURE16 = $84D0
  #TEXTURE17 = $84D1
  #TEXTURE18 = $84D2
  #TEXTURE19 = $84D3
  #TEXTURE20 = $84D4
  #TEXTURE21 = $84D5
  #TEXTURE22 = $84D6
  #TEXTURE23 = $84D7
  #TEXTURE24 = $84D8
  #TEXTURE25 = $84D9
  #TEXTURE26 = $84DA
  #TEXTURE27 = $84DB
  #TEXTURE28 = $84DC
  #TEXTURE29 = $84DD
  #TEXTURE30 = $84DE
  #TEXTURE31 = $84DF
  #ACTIVE_TEXTURE = $84E0
  #CLIENT_ACTIVE_TEXTURE = $84E1
  #MAX_TEXTURE_UNITS = $84E2
  #TRANSPOSE_MODELVIEW_MATRIX = $84E3
  #TRANSPOSE_PROJECTION_MATRIX = $84E4
  #TRANSPOSE_TEXTURE_MATRIX = $84E5
  #TRANSPOSE_COLOR_MATRIX = $84E6
  #SUBTRACT = $84E7
  #COMPRESSED_ALPHA = $84E9
  #COMPRESSED_LUMINANCE = $84EA
  #COMPRESSED_LUMINANCE_ALPHA = $84EB
  #COMPRESSED_INTENSITY = $84EC
  #COMPRESSED_RGB = $84ED
  #COMPRESSED_RGBA = $84EE
  #TEXTURE_COMPRESSION_HINT = $84EF
  #NORMAL_MAP = $8511
  #REFLECTION_MAP = $8512
  #TEXTURE_CUBE_MAP = $8513
  #TEXTURE_BINDING_CUBE_MAP = $8514
  #TEXTURE_CUBE_MAP_POSITIVE_X = $8515
  #TEXTURE_CUBE_MAP_NEGATIVE_X = $8516
  #TEXTURE_CUBE_MAP_POSITIVE_Y = $8517
  #TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518
  #TEXTURE_CUBE_MAP_POSITIVE_Z = $8519
  #TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A
  #PROXY_TEXTURE_CUBE_MAP = $851B
  #MAX_CUBE_MAP_TEXTURE_SIZE = $851C
  #COMBINE = $8570
  #COMBINE_RGB = $8571
  #COMBINE_ALPHA = $8572
  #RGB_SCALE = $8573
  #ADD_SIGNED = $8574
  #INTERPOLATE = $8575
  #CONSTANT = $8576
  #PRIMARY_COLOR = $8577
  #PREVIOUS = $8578
  #SOURCE0_RGB = $8580
  #SOURCE1_RGB = $8581
  #SOURCE2_RGB = $8582
  #SOURCE0_ALPHA = $8588
  #SOURCE1_ALPHA = $8589
  #SOURCE2_ALPHA = $858A
  #OPERAND0_RGB = $8590
  #OPERAND1_RGB = $8591
  #OPERAND2_RGB = $8592
  #OPERAND0_ALPHA = $8598
  #OPERAND1_ALPHA = $8599
  #OPERAND2_ALPHA = $859A
  #TEXTURE_COMPRESSED_IMAGE_SIZE = $86A0
  #TEXTURE_COMPRESSED = $86A1
  #NUM_COMPRESSED_TEXTURE_FORMATS = $86A2
  #COMPRESSED_TEXTURE_FORMATS = $86A3
  #DOT3_RGB = $86AE
  #DOT3_RGBA = $86AF
  #MULTISAMPLE_BIT = $20000000
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,4,0)
  #BLEND_DST_RGB = $80C8
  #BLEND_SRC_RGB = $80C9
  #BLEND_DST_ALPHA = $80CA
  #BLEND_SRC_ALPHA = $80CB
  #POINT_SIZE_MIN = $8126
  #POINT_SIZE_MAX = $8127
  #POINT_FADE_THRESHOLD_SIZE = $8128
  #POINT_DISTANCE_ATTENUATION = $8129
  #GENERATE_MIPMAP = $8191
  #GENERATE_MIPMAP_HINT = $8192
  #DEPTH_COMPONENT16 = $81A5
  #DEPTH_COMPONENT24 = $81A6
  #DEPTH_COMPONENT32 = $81A7
  #MIRRORED_REPEAT = $8370
  #FOG_COORDINATE_SOURCE = $8450
  #FOG_COORDINATE = $8451
  #FRAGMENT_DEPTH = $8452
  #CURRENT_FOG_COORDINATE = $8453
  #FOG_COORDINATE_ARRAY_TYPE = $8454
  #FOG_COORDINATE_ARRAY_STRIDE = $8455
  #FOG_COORDINATE_ARRAY_POINTER = $8456
  #FOG_COORDINATE_ARRAY = $8457
  #COLOR_SUM = $8458
  #CURRENT_SECONDARY_COLOR = $8459
  #SECONDARY_COLOR_ARRAY_SIZE = $845A
  #SECONDARY_COLOR_ARRAY_TYPE = $845B
  #SECONDARY_COLOR_ARRAY_STRIDE = $845C
  #SECONDARY_COLOR_ARRAY_POINTER = $845D
  #SECONDARY_COLOR_ARRAY = $845E
  #MAX_TEXTURE_LOD_BIAS = $84FD
  #TEXTURE_FILTER_CONTROL = $8500
  #TEXTURE_LOD_BIAS = $8501
  #INCR_WRAP = $8507
  #DECR_WRAP = $8508
  #TEXTURE_DEPTH_SIZE = $884A
  #DEPTH_TEXTURE_MODE = $884B
  #TEXTURE_COMPARE_MODE = $884C
  #TEXTURE_COMPARE_FUNC = $884D
  #COMPARE_R_TO_TEXTURE = $884E
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,5,0)
  #CURRENT_FOG_COORD = $8453
  #FOG_COORD = $8451
  #FOG_COORD_ARRAY = $8457
  #FOG_COORD_ARRAY_BUFFER_BINDING = $889D
  #FOG_COORD_ARRAY_POINTER = $8456
  #FOG_COORD_ARRAY_STRIDE = $8455
  #FOG_COORD_ARRAY_TYPE = $8454
  #FOG_COORD_SRC = $8450
  #SRC0_ALPHA = $8588
  #SRC0_RGB = $8580
  #SRC1_ALPHA = $8589
  #SRC1_RGB = $8581
  #SRC2_ALPHA = $858A
  #SRC2_RGB = $8582
  #BUFFER_SIZE = $8764
  #BUFFER_USAGE = $8765
  #QUERY_COUNTER_BITS = $8864
  #CURRENT_QUERY = $8865
  #QUERY_RESULT = $8866
  #QUERY_RESULT_AVAILABLE = $8867
  #ARRAY_BUFFER = $8892
  #ELEMENT_ARRAY_BUFFER = $8893
  #ARRAY_BUFFER_BINDING = $8894
  #ELEMENT_ARRAY_BUFFER_BINDING = $8895
  #VERTEX_ARRAY_BUFFER_BINDING = $8896
  #NORMAL_ARRAY_BUFFER_BINDING = $8897
  #COLOR_ARRAY_BUFFER_BINDING = $8898
  #INDEX_ARRAY_BUFFER_BINDING = $8899
  #TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A
  #EDGE_FLAG_ARRAY_BUFFER_BINDING = $889B
  #SECONDARY_COLOR_ARRAY_BUFFER_BINDING = $889C
  #FOG_COORDINATE_ARRAY_BUFFER_BINDING = $889D
  #WEIGHT_ARRAY_BUFFER_BINDING = $889E
  #VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = $889F
  #READ_ONLY = $88B8
  #WRITE_ONLY = $88B9
  #READ_WRITE_ = $88BA
  #BUFFER_ACCESS = $88BB
  #BUFFER_MAPPED = $88BC
  #BUFFER_MAP_POINTER = $88BD
  #STREAM_DRAW = $88E0
  #STREAM_READ = $88E1
  #STREAM_COPY = $88E2
  #STATIC_DRAW = $88E4
  #STATIC_READ = $88E5
  #STATIC_COPY = $88E6
  #DYNAMIC_DRAW = $88E8
  #DYNAMIC_READ = $88E9
  #DYNAMIC_COPY = $88EA
  #SAMPLES_PASSED = $8914
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(2,0,0)
  #BLEND_EQUATION_RGB = $8009
  #VERTEX_ATTRIB_ARRAY_ENABLED = $8622
  #VERTEX_ATTRIB_ARRAY_SIZE = $8623
  #VERTEX_ATTRIB_ARRAY_STRIDE = $8624
  #VERTEX_ATTRIB_ARRAY_TYPE = $8625
  #CURRENT_VERTEX_ATTRIB = $8626
  #VERTEX_PROGRAM_POINT_SIZE = $8642
  #VERTEX_PROGRAM_TWO_SIDE = $8643
  #VERTEX_ATTRIB_ARRAY_POINTER = $8645
  #STENCIL_BACK_FUNC = $8800
  #STENCIL_BACK_FAIL = $8801
  #STENCIL_BACK_PASS_DEPTH_FAIL = $8802
  #STENCIL_BACK_PASS_DEPTH_PASS = $8803
  #MAX_DRAW_BUFFERS = $8824
  #DRAW_BUFFER0 = $8825
  #DRAW_BUFFER1 = $8826
  #DRAW_BUFFER2 = $8827
  #DRAW_BUFFER3 = $8828
  #DRAW_BUFFER4 = $8829
  #DRAW_BUFFER5 = $882A
  #DRAW_BUFFER6 = $882B
  #DRAW_BUFFER7 = $882C
  #DRAW_BUFFER8 = $882D
  #DRAW_BUFFER9 = $882E
  #DRAW_BUFFER10 = $882F
  #DRAW_BUFFER11 = $8830
  #DRAW_BUFFER12 = $8831
  #DRAW_BUFFER13 = $8832
  #DRAW_BUFFER14 = $8833
  #DRAW_BUFFER15 = $8834
  #BLEND_EQUATION_ALPHA = $883D
  #POINT_SPRITE = $8861
  #COORD_REPLACE = $8862
  #MAX_VERTEX_ATTRIBS = $8869
  #VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A
  #MAX_TEXTURE_COORDS = $8871
  #MAX_TEXTURE_IMAGE_UNITS = $8872
  #FRAGMENT_SHADER = $8B30
  #VERTEX_SHADER = $8B31
  #MAX_FRAGMENT_UNIFORM_COMPONENTS = $8B49
  #MAX_VERTEX_UNIFORM_COMPONENTS = $8B4A
  #MAX_VARYING_FLOATS = $8B4B
  #MAX_VERTEX_TEXTURE_IMAGE_UNITS = $8B4C
  #MAX_COMBINED_TEXTURE_IMAGE_UNITS = $8B4D
  #SHADER_TYPE = $8B4F
  #FLOAT_VEC2 = $8B50
  #FLOAT_VEC3 = $8B51
  #FLOAT_VEC4 = $8B52
  #INT_VEC2 = $8B53
  #INT_VEC3 = $8B54
  #INT_VEC4 = $8B55
  #BOOL = $8B56
  #BOOL_VEC2 = $8B57
  #BOOL_VEC3 = $8B58
  #BOOL_VEC4 = $8B59
  #FLOAT_MAT2 = $8B5A
  #FLOAT_MAT3 = $8B5B
  #FLOAT_MAT4 = $8B5C
  #SAMPLER_1D = $8B5D
  #SAMPLER_2D = $8B5E
  #SAMPLER_3D = $8B5F
  #SAMPLER_CUBE = $8B60
  #SAMPLER_1D_SHADOW = $8B61
  #SAMPLER_2D_SHADOW = $8B62
  #DELETE_STATUS = $8B80
  #COMPILE_STATUS = $8B81
  #LINK_STATUS = $8B82
  #VALIDATE_STATUS = $8B83
  #INFO_LOG_LENGTH = $8B84
  #ATTACHED_SHADERS = $8B85
  #ACTIVE_UNIFORMS = $8B86
  #ACTIVE_UNIFORM_MAX_LENGTH = $8B87
  #SHADER_SOURCE_LENGTH = $8B88
  #ACTIVE_ATTRIBUTES = $8B89
  #ACTIVE_ATTRIBUTE_MAX_LENGTH = $8B8A
  #FRAGMENT_SHADER_DERIVATIVE_HINT = $8B8B
  #SHADING_LANGUAGE_VERSION = $8B8C
  #CURRENT_PROGRAM = $8B8D
  #POINT_SPRITE_COORD_ORIGIN = $8CA0
  #LOWER_LEFT = $8CA1
  #UPPER_LEFT = $8CA2
  #STENCIL_BACK_REF = $8CA3
  #STENCIL_BACK_VALUE_MASK = $8CA4
  #STENCIL_BACK_WRITEMASK = $8CA5
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(2,1,0)
  #CURRENT_RASTER_SECONDARY_COLOR = $845F
  #PIXEL_PACK_BUFFER = $88EB
  #PIXEL_UNPACK_BUFFER = $88EC
  #PIXEL_PACK_BUFFER_BINDING = $88ED
  #PIXEL_UNPACK_BUFFER_BINDING = $88EF
  #FLOAT_MAT2x3 = $8B65
  #FLOAT_MAT2x4 = $8B66
  #FLOAT_MAT3x2 = $8B67
  #FLOAT_MAT3x4 = $8B68
  #FLOAT_MAT4x2 = $8B69
  #FLOAT_MAT4x3 = $8B6A
  #SRGB = $8C40
  #SRGB8 = $8C41
  #SRGB_ALPHA = $8C42
  #SRGB8_ALPHA8 = $8C43
  #SLUMINANCE_ALPHA = $8C44
  #SLUMINANCE8_ALPHA8 = $8C45
  #SLUMINANCE = $8C46
  #SLUMINANCE8 = $8C47
  #COMPRESSED_SRGB = $8C48
  #COMPRESSED_SRGB_ALPHA = $8C49
  #COMPRESSED_SLUMINANCE = $8C4A
  #COMPRESSED_SLUMINANCE_ALPHA = $8C4B
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,0,0)
  #CLIP_DISTANCE0 = $3000
  #CLIP_DISTANCE1 = $3001
  #CLIP_DISTANCE2 = $3002
  #CLIP_DISTANCE3 = $3003
  #CLIP_DISTANCE4 = $3004
  #CLIP_DISTANCE5 = $3005
  #COMPARE_REF_TO_TEXTURE = $884E
  #MAX_CLIP_DISTANCES = $0D32
  #MAX_VARYING_COMPONENTS = $8B4B
  #CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = $0001
  #MAJOR_VERSION = $821B
  #MINOR_VERSION = $821C
  #NUM_EXTENSIONS = $821D
  #CONTEXT_FLAGS = $821E
  #DEPTH_BUFFER = $8223
  #STENCIL_BUFFER = $8224
  #RGBA32F = $8814
  #RGB32F = $8815
  #RGBA16F = $881A
  #RGB16F = $881B
  #VERTEX_ATTRIB_ARRAY_INTEGER = $88FD
  #MAX_ARRAY_TEXTURE_LAYERS = $88FF
  #MIN_PROGRAM_TEXEL_OFFSET = $8904
  #MAX_PROGRAM_TEXEL_OFFSET = $8905
  #CLAMP_VERTEX_COLOR = $891A
  #CLAMP_FRAGMENT_COLOR = $891B
  #CLAMP_READ_COLOR = $891C
  #FIXED_ONLY = $891D
  #TEXTURE_RED_TYPE = $8C10
  #TEXTURE_GREEN_TYPE = $8C11
  #TEXTURE_BLUE_TYPE = $8C12
  #TEXTURE_ALPHA_TYPE = $8C13
  #TEXTURE_LUMINANCE_TYPE = $8C14
  #TEXTURE_INTENSITY_TYPE = $8C15
  #TEXTURE_DEPTH_TYPE = $8C16
  #TEXTURE_1D_ARRAY = $8C18
  #PROXY_TEXTURE_1D_ARRAY = $8C19
  #TEXTURE_2D_ARRAY = $8C1A
  #PROXY_TEXTURE_2D_ARRAY = $8C1B
  #TEXTURE_BINDING_1D_ARRAY = $8C1C
  #TEXTURE_BINDING_2D_ARRAY = $8C1D
  #R11F_G11F_B10F = $8C3A
  #UNSIGNED_INT_10F_11F_11F_REV = $8C3B
  #RGB9_E5 = $8C3D
  #UNSIGNED_INT_5_9_9_9_REV = $8C3E
  #TEXTURE_SHARED_SIZE = $8C3F
  #TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = $8C76
  #TRANSFORM_FEEDBACK_BUFFER_MODE = $8C7F
  #MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = $8C80
  #TRANSFORM_FEEDBACK_VARYINGS = $8C83
  #TRANSFORM_FEEDBACK_BUFFER_START = $8C84
  #TRANSFORM_FEEDBACK_BUFFER_SIZE = $8C85
  #PRIMITIVES_GENERATED = $8C87
  #TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = $8C88
  #RASTERIZER_DISCARD = $8C89
  #MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = $8C8A
  #MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = $8C8B
  #INTERLEAVED_ATTRIBS = $8C8C
  #SEPARATE_ATTRIBS = $8C8D
  #TRANSFORM_FEEDBACK_BUFFER = $8C8E
  #TRANSFORM_FEEDBACK_BUFFER_BINDING = $8C8F
  #RGBA32UI = $8D70
  #RGB32UI = $8D71
  #RGBA16UI = $8D76
  #RGB16UI = $8D77
  #RGBA8UI = $8D7C
  #RGB8UI = $8D7D
  #RGBA32I = $8D82
  #RGB32I = $8D83
  #RGBA16I = $8D88
  #RGB16I = $8D89
  #RGBA8I = $8D8E
  #RGB8I = $8D8F
  #RED_INTEGER = $8D94
  #GREEN_INTEGER = $8D95
  #BLUE_INTEGER = $8D96
  #ALPHA_INTEGER = $8D97
  #RGB_INTEGER = $8D98
  #RGBA_INTEGER = $8D99
  #BGR_INTEGER = $8D9A
  #BGRA_INTEGER = $8D9B
  #SAMPLER_1D_ARRAY = $8DC0
  #SAMPLER_2D_ARRAY = $8DC1
  #SAMPLER_1D_ARRAY_SHADOW = $8DC3
  #SAMPLER_2D_ARRAY_SHADOW = $8DC4
  #SAMPLER_CUBE_SHADOW = $8DC5
  #UNSIGNED_INT_VEC2 = $8DC6
  #UNSIGNED_INT_VEC3 = $8DC7
  #UNSIGNED_INT_VEC4 = $8DC8
  #INT_SAMPLER_1D = $8DC9
  #INT_SAMPLER_2D = $8DCA
  #INT_SAMPLER_3D = $8DCB
  #INT_SAMPLER_CUBE = $8DCC
  #INT_SAMPLER_1D_ARRAY = $8DCE
  #INT_SAMPLER_2D_ARRAY = $8DCF
  #UNSIGNED_INT_SAMPLER_1D = $8DD1
  #UNSIGNED_INT_SAMPLER_2D = $8DD2
  #UNSIGNED_INT_SAMPLER_3D = $8DD3
  #UNSIGNED_INT_SAMPLER_CUBE = $8DD4
  #UNSIGNED_INT_SAMPLER_1D_ARRAY = $8DD6
  #UNSIGNED_INT_SAMPLER_2D_ARRAY = $8DD7
  #QUERY_WAIT = $8E13
  #QUERY_NO_WAIT = $8E14
  #QUERY_BY_REGION_WAIT = $8E15
  #QUERY_BY_REGION_NO_WAIT = $8E16
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,1,0)
  #MAX_RECTANGLE_TEXTURE_SIZE = $84F8
  #SAMPLER_2D_RECT = $8B63
  #SAMPLER_2D_RECT_SHADOW = $8B64
  #TEXTURE_BUFFER = $8C2A
  #MAX_TEXTURE_BUFFER_SIZE = $8C2B
  #TEXTURE_BINDING_BUFFER = $8C2C
  #TEXTURE_BUFFER_DATA_STORE_BINDING = $8C2D
  #TEXTURE_BUFFER_FORMAT = $8C2E
  #SAMPLER_BUFFER = $8DC2
  #INT_SAMPLER_2D_RECT = $8DCD
  #INT_SAMPLER_BUFFER = $8DD0
  #UNSIGNED_INT_SAMPLER_2D_RECT = $8DD5
  #UNSIGNED_INT_SAMPLER_BUFFER = $8DD8
  #RED_SNORM = $8F90
  #RG_SNORM = $8F91
  #RGB_SNORM = $8F92
  #RGBA_SNORM = $8F93
  #R8_SNORM = $8F94
  #RG8_SNORM = $8F95
  #RGB8_SNORM = $8F96
  #RGBA8_SNORM = $8F97
  #R16_SNORM = $8F98
  #RG16_SNORM = $8F99
  #RGB16_SNORM = $8F9A
  #RGBA16_SNORM = $8F9B
  #SIGNED_NORMALIZED = $8F9C
  #PRIMITIVE_RESTART = $8F9D
  #PRIMITIVE_RESTART_INDEX = $8F9E
  #BUFFER_ACCESS_FLAGS = $911F
  #BUFFER_MAP_LENGTH = $9120
  #BUFFER_MAP_OFFSET = $9121
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,2,0)
  #CONTEXT_CORE_PROFILE_BIT = $00000001
  #CONTEXT_COMPATIBILITY_PROFILE_BIT = $00000002
  #LINES_ADJACENCY = $000A
  #LINE_STRIP_ADJACENCY = $000B
  #TRIANGLES_ADJACENCY = $000C
  #TRIANGLE_STRIP_ADJACENCY = $000D
  #PROGRAM_POINT_SIZE = $8642
  #GEOMETRY_VERTICES_OUT = $8916
  #GEOMETRY_INPUT_TYPE = $8917
  #GEOMETRY_OUTPUT_TYPE = $8918
  #MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = $8C29
  #FRAMEBUFFER_ATTACHMENT_LAYERED = $8DA7
  #FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = $8DA8
  #GEOMETRY_SHADER = $8DD9
  #MAX_GEOMETRY_UNIFORM_COMPONENTS = $8DDF
  #MAX_GEOMETRY_OUTPUT_VERTICES = $8DE0
  #MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = $8DE1
  #MAX_VERTEX_OUTPUT_COMPONENTS = $9122
  #MAX_GEOMETRY_INPUT_COMPONENTS = $9123
  #MAX_GEOMETRY_OUTPUT_COMPONENTS = $9124
  #MAX_FRAGMENT_INPUT_COMPONENTS = $9125
  #CONTEXT_PROFILE_MASK = $9126
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,3,0)
  #VERTEX_ATTRIB_ARRAY_DIVISOR = $88FE
  #RGB10_A2UI = $906F
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,0,0)
  #SAMPLE_SHADING = $8C36
  #MIN_SAMPLE_SHADING_VALUE = $8C37
  #MIN_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5E
  #MAX_PROGRAM_TEXTURE_GATHER_OFFSET = $8E5F
  #MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS = $8F9F
  #TEXTURE_CUBE_MAP_ARRAY = $9009
  #TEXTURE_BINDING_CUBE_MAP_ARRAY = $900A
  #PROXY_TEXTURE_CUBE_MAP_ARRAY = $900B
  #SAMPLER_CUBE_MAP_ARRAY = $900C
  #SAMPLER_CUBE_MAP_ARRAY_SHADOW = $900D
  #INT_SAMPLER_CUBE_MAP_ARRAY = $900E
  #UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = $900F
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,1,0)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,2,0)
  #TRANSFORM_FEEDBACK_PAUSED = $8E23
  #TRANSFORM_FEEDBACK_ACTIVE = $8E24
  #COMPRESSED_RGBA_BPTC_UNORM = $8E8C
  #COMPRESSED_SRGB_ALPHA_BPTC_UNORM = $8E8D
  #COMPRESSED_RGB_BPTC_SIGNED_FLOAT = $8E8E
  #COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = $8E8F
  #COPY_READ_BUFFER_BINDING = $8F36
  #COPY_WRITE_BUFFER_BINDING = $8F37
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,3,0)
  #NUM_SHADING_LANGUAGE_VERSIONS = $82E9
  #VERTEX_ATTRIB_ARRAY_LONG = $874E
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,4,0)
  #PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = $8221
  #MAX_VERTEX_ATTRIB_STRIDE = $82E5
  #TEXTURE_BUFFER_BINDING = $8C2A
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,5,0)
  #CONTEXT_FLAG_ROBUST_ACCESS_BIT = $00000004
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,6,0)
  #CONTEXT_FLAG_NO_ERROR_BIT = $00000008
  #PARAMETER_BUFFER = $80EE
  #PARAMETER_BUFFER_BINDING = $80EF
  #TRANSFORM_FEEDBACK_OVERFLOW = $82EC
  #TRANSFORM_FEEDBACK_STREAM_OVERFLOW = $82ED
  #VERTICES_SUBMITTED = $82EE
  #PRIMITIVES_SUBMITTED = $82EF
  #VERTEX_SHADER_INVOCATIONS = $82F0
  #TESS_CONTROL_SHADER_PATCHES = $82F1
  #TESS_EVALUATION_SHADER_INVOCATIONS = $82F2
  #GEOMETRY_SHADER_PRIMITIVES_EMITTED = $82F3
  #FRAGMENT_SHADER_INVOCATIONS = $82F4
  #COMPUTE_SHADER_INVOCATIONS = $82F5
  #CLIPPING_INPUT_PRIMITIVES = $82F6
  #CLIPPING_OUTPUT_PRIMITIVES = $82F7
  #TEXTURE_MAX_ANISOTROPY = $84FE
  #MAX_TEXTURE_MAX_ANISOTROPY = $84FF
  #POLYGON_OFFSET_CLAMP = $8E1B
  #SHADER_BINARY_FORMAT_SPIR_V = $9551
  #SPIR_V_BINARY = $9552
  #SPIR_V_EXTENSIONS = $9553
  #NUM_SPIR_V_EXTENSIONS = $9554
CompilerEndif
  #RG8UI = $8238
  #RG16UI = $823A
  #TEXTURE_CUBE_MAP_SEAMLESS = $884F
  #MAX_SPARSE_ARRAY_TEXTURE_LAYERS = $919A
  #FIXED = $140C
  #IMPLEMENTATION_COLOR_READ_TYPE = $8B9A
  #IMPLEMENTATION_COLOR_READ_FORMAT = $8B9B
  #RGB565 = $8D62
  #LOW_FLOAT = $8DF0
  #MEDIUM_FLOAT = $8DF1
  #HIGH_FLOAT = $8DF2
  #LOW_INT = $8DF3
  #MEDIUM_INT = $8DF4
  #HIGH_INT = $8DF5
  #SHADER_BINARY_FORMATS = $8DF8
  #NUM_SHADER_BINARY_FORMATS = $8DF9
  #SHADER_COMPILER = $8DFA
  #MAX_VERTEX_UNIFORM_VECTORS = $8DFB
  #MAX_VARYING_VECTORS = $8DFC
  #MAX_FRAGMENT_UNIFORM_VECTORS = $8DFD
  #TEXTURE_IMMUTABLE_LEVELS = $82DF
  #PRIMITIVE_RESTART_FIXED_INDEX = $8D69
  #ANY_SAMPLES_PASSED_CONSERVATIVE = $8D6A
  #MAX_ELEMENT_INDEX = $8D6B
  #COMPRESSED_R11_EAC = $9270
  #COMPRESSED_SIGNED_R11_EAC = $9271
  #COMPRESSED_RG11_EAC = $9272
  #COMPRESSED_SIGNED_RG11_EAC = $9273
  #COMPRESSED_RGB8_ETC2 = $9274
  #COMPRESSED_SRGB8_ETC2 = $9275
  #COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9276
  #COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = $9277
  #COMPRESSED_RGBA8_ETC2_EAC = $9278
  #COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = $9279
  #SRC1_COLOR = $88F9
  #ONE_MINUS_SRC1_COLOR = $88FA
  #ONE_MINUS_SRC1_ALPHA = $88FB
  #MAX_DUAL_SOURCE_DRAW_BUFFERS = $88FC
  #MAP_READ_BIT = $0001
  #MAP_WRITE_BIT = $0002
  #MAP_PERSISTENT_BIT = $00000040
  #MAP_COHERENT_BIT = $00000080
  #DYNAMIC_STORAGE_BIT = $0100
  #CLIENT_STORAGE_BIT = $0200
  #CLIENT_MAPPED_BUFFER_BARRIER_BIT = $00004000
  #BUFFER_IMMUTABLE_STORAGE = $821F
  #BUFFER_STORAGE_FLAGS = $8220
  #CLEAR_TEXTURE = $9365
  #CLIP_ORIGIN = $935C
  #CLIP_DEPTH_MODE = $935D
  #NEGATIVE_ONE_TO_ONE = $935E
  #ZERO_TO_ONE = $935F
  #UNPACK_COMPRESSED_BLOCK_WIDTH = $9127
  #UNPACK_COMPRESSED_BLOCK_HEIGHT = $9128
  #UNPACK_COMPRESSED_BLOCK_DEPTH = $9129
  #UNPACK_COMPRESSED_BLOCK_SIZE = $912A
  #PACK_COMPRESSED_BLOCK_WIDTH = $912B
  #PACK_COMPRESSED_BLOCK_HEIGHT = $912C
  #PACK_COMPRESSED_BLOCK_DEPTH = $912D
  #PACK_COMPRESSED_BLOCK_SIZE = $912E
  #COMPUTE_SHADER_BIT = $00000020
  #MAX_COMPUTE_SHARED_MEMORY_SIZE = $8262
  #MAX_COMPUTE_UNIFORM_COMPONENTS = $8263
  #MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = $8264
  #MAX_COMPUTE_ATOMIC_COUNTERS = $8265
  #MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = $8266
  #COMPUTE_WORK_GROUP_SIZE = $8267
  #MAX_COMPUTE_WORK_GROUP_INVOCATIONS = $90EB
  #UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = $90EC
  #ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = $90ED
  #DISPATCH_INDIRECT_BUFFER = $90EE
  #DISPATCH_INDIRECT_BUFFER_BINDING = $90EF
  #COMPUTE_SHADER = $91B9
  #MAX_COMPUTE_UNIFORM_BLOCKS = $91BB
  #MAX_COMPUTE_TEXTURE_IMAGE_UNITS = $91BC
  #MAX_COMPUTE_IMAGE_UNIFORMS = $91BD
  #MAX_COMPUTE_WORK_GROUP_COUNT = $91BE
  #MAX_COMPUTE_WORK_GROUP_SIZE = $91BF
  #QUERY_WAIT_INVERTED = $8E17
  #QUERY_NO_WAIT_INVERTED = $8E18
  #QUERY_BY_REGION_WAIT_INVERTED = $8E19
  #QUERY_BY_REGION_NO_WAIT_INVERTED = $8E1A
  #COPY_READ_BUFFER = $8F36
  #COPY_WRITE_BUFFER = $8F37
  #MAX_CULL_DISTANCES = $82F9
  #MAX_COMBINED_CLIP_AND_CULL_DISTANCES = $82FA
  #DEPTH_COMPONENT32F = $8CAC
  #DEPTH32F_STENCIL8 = $8CAD
  #FLOAT_32_UNSIGNED_INT_24_8_REV = $8DAD
  #DEPTH_CLAMP = $864F
  #TEXTURE_TARGET = $1006
  #QUERY_TARGET = $82EA
  #DRAW_INDIRECT_BUFFER = $8F3F
  #DRAW_INDIRECT_BUFFER_BINDING = $8F43
  #LOCATION_COMPONENT = $934A
  #TRANSFORM_FEEDBACK_BUFFER_INDEX = $934B
  #TRANSFORM_FEEDBACK_BUFFER_STRIDE = $934C
  #MAX_UNIFORM_LOCATIONS = $826E
  #FRAMEBUFFER_DEFAULT_WIDTH = $9310
  #FRAMEBUFFER_DEFAULT_HEIGHT = $9311
  #FRAMEBUFFER_DEFAULT_LAYERS = $9312
  #FRAMEBUFFER_DEFAULT_SAMPLES = $9313
  #FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = $9314
  #MAX_FRAMEBUFFER_WIDTH = $9315
  #MAX_FRAMEBUFFER_HEIGHT = $9316
  #MAX_FRAMEBUFFER_LAYERS = $9317
  #MAX_FRAMEBUFFER_SAMPLES = $9318
  #INVALID_FRAMEBUFFER_OPERATION = $0506
  #FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = $8210
  #FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = $8211
  #FRAMEBUFFER_ATTACHMENT_RED_SIZE = $8212
  #FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = $8213
  #FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = $8214
  #FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = $8215
  #FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = $8216
  #FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = $8217
  #FRAMEBUFFER_DEFAULT = $8218
  #FRAMEBUFFER_UNDEFINED = $8219
  #DEPTH_STENCIL_ATTACHMENT = $821A
  #INDEX = $8222
  #MAX_RENDERBUFFER_SIZE = $84E8
  #DEPTH_STENCIL = $84F9
  #UNSIGNED_INT_24_8 = $84FA
  #DEPTH24_STENCIL8 = $88F0
  #TEXTURE_STENCIL_SIZE = $88F1
  #UNSIGNED_NORMALIZED = $8C17
  #DRAW_FRAMEBUFFER_BINDING = $8CA6
  #FRAMEBUFFER_BINDING = $8CA6
  #RENDERBUFFER_BINDING = $8CA7
  #READ_FRAMEBUFFER = $8CA8
  #DRAW_FRAMEBUFFER = $8CA9
  #READ_FRAMEBUFFER_BINDING = $8CAA
  #RENDERBUFFER_SAMPLES = $8CAB
  #FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = $8CD0
  #FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = $8CD1
  #FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = $8CD2
  #FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = $8CD3
  #FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = $8CD4
  #FRAMEBUFFER_COMPLETE = $8CD5
  #FRAMEBUFFER_INCOMPLETE_ATTACHMENT = $8CD6
  #FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = $8CD7
  #FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = $8CDB
  #FRAMEBUFFER_INCOMPLETE_READ_BUFFER = $8CDC
  #FRAMEBUFFER_UNSUPPORTED = $8CDD
  #MAX_COLOR_ATTACHMENTS = $8CDF
  #COLOR_ATTACHMENT0 = $8CE0
  #COLOR_ATTACHMENT1 = $8CE1
  #COLOR_ATTACHMENT2 = $8CE2
  #COLOR_ATTACHMENT3 = $8CE3
  #COLOR_ATTACHMENT4 = $8CE4
  #COLOR_ATTACHMENT5 = $8CE5
  #COLOR_ATTACHMENT6 = $8CE6
  #COLOR_ATTACHMENT7 = $8CE7
  #COLOR_ATTACHMENT8 = $8CE8
  #COLOR_ATTACHMENT9 = $8CE9
  #COLOR_ATTACHMENT10 = $8CEA
  #COLOR_ATTACHMENT11 = $8CEB
  #COLOR_ATTACHMENT12 = $8CEC
  #COLOR_ATTACHMENT13 = $8CED
  #COLOR_ATTACHMENT14 = $8CEE
  #COLOR_ATTACHMENT15 = $8CEF
  #DEPTH_ATTACHMENT = $8D00
  #STENCIL_ATTACHMENT = $8D20
  #FRAMEBUFFER = $8D40
  #RENDERBUFFER = $8D41
  #RENDERBUFFER_WIDTH = $8D42
  #RENDERBUFFER_HEIGHT = $8D43
  #RENDERBUFFER_INTERNAL_FORMAT = $8D44
  #STENCIL_INDEX1 = $8D46
  #STENCIL_INDEX4 = $8D47
  #STENCIL_INDEX8 = $8D48
  #STENCIL_INDEX16 = $8D49
  #RENDERBUFFER_RED_SIZE = $8D50
  #RENDERBUFFER_GREEN_SIZE = $8D51
  #RENDERBUFFER_BLUE_SIZE = $8D52
  #RENDERBUFFER_ALPHA_SIZE = $8D53
  #RENDERBUFFER_DEPTH_SIZE = $8D54
  #RENDERBUFFER_STENCIL_SIZE = $8D55
  #FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = $8D56
  #MAX_SAMPLES = $8D57
  #FRAMEBUFFER_SRGB = $8DB9
  #PROGRAM_BINARY_RETRIEVABLE_HINT = $8257
  #PROGRAM_BINARY_LENGTH = $8741
  #NUM_PROGRAM_BINARY_FORMATS = $87FE
  #PROGRAM_BINARY_FORMATS = $87FF
  #GEOMETRY_SHADER_INVOCATIONS = $887F
  #MAX_GEOMETRY_SHADER_INVOCATIONS = $8E5A
  #MIN_FRAGMENT_INTERPOLATION_OFFSET = $8E5B
  #MAX_FRAGMENT_INTERPOLATION_OFFSET = $8E5C
  #FRAGMENT_INTERPOLATION_OFFSET_BITS = $8E5D
  #MAX_VERTEX_STREAMS = $8E71
  #DOUBLE_MAT2 = $8F46
  #DOUBLE_MAT3 = $8F47
  #DOUBLE_MAT4 = $8F48
  #DOUBLE_MAT2x3 = $8F49
  #DOUBLE_MAT2x4 = $8F4A
  #DOUBLE_MAT3x2 = $8F4B
  #DOUBLE_MAT3x4 = $8F4C
  #DOUBLE_MAT4x2 = $8F4D
  #DOUBLE_MAT4x3 = $8F4E
  #DOUBLE_VEC2 = $8FFC
  #DOUBLE_VEC3 = $8FFD
  #DOUBLE_VEC4 = $8FFE
  #HALF_FLOAT = $140B
  #CONSTANT_COLOR = $8001
  #ONE_MINUS_CONSTANT_COLOR = $8002
  #CONSTANT_ALPHA = $8003
  #ONE_MINUS_CONSTANT_ALPHA = $8004
  #BLEND_COLOR = $8005
  #FUNC_ADD = $8006
  #MIN = $8007
  #MAX = $8008
  #BLEND_EQUATION = $8009
  #FUNC_SUBTRACT = $800A
  #FUNC_REVERSE_SUBTRACT = $800B
  #CONVOLUTION_1D = $8010
  #CONVOLUTION_2D = $8011
  #SEPARABLE_2D = $8012
  #CONVOLUTION_BORDER_MODE = $8013
  #CONVOLUTION_FILTER_SCALE = $8014
  #CONVOLUTION_FILTER_BIAS = $8015
  #REDUCE = $8016
  #CONVOLUTION_FORMAT = $8017
  #CONVOLUTION_WIDTH = $8018
  #CONVOLUTION_HEIGHT = $8019
  #MAX_CONVOLUTION_WIDTH = $801A
  #MAX_CONVOLUTION_HEIGHT = $801B
  #POST_CONVOLUTION_RED_SCALE = $801C
  #POST_CONVOLUTION_GREEN_SCALE = $801D
  #POST_CONVOLUTION_BLUE_SCALE = $801E
  #POST_CONVOLUTION_ALPHA_SCALE = $801F
  #POST_CONVOLUTION_RED_BIAS = $8020
  #POST_CONVOLUTION_GREEN_BIAS = $8021
  #POST_CONVOLUTION_BLUE_BIAS = $8022
  #POST_CONVOLUTION_ALPHA_BIAS = $8023
  #HISTOGRAM = $8024
  #PROXY_HISTOGRAM = $8025
  #HISTOGRAM_WIDTH = $8026
  #HISTOGRAM_FORMAT = $8027
  #HISTOGRAM_RED_SIZE = $8028
  #HISTOGRAM_GREEN_SIZE = $8029
  #HISTOGRAM_BLUE_SIZE = $802A
  #HISTOGRAM_ALPHA_SIZE = $802B
  #HISTOGRAM_LUMINANCE_SIZE = $802C
  #HISTOGRAM_SINK = $802D
  #MINMAX = $802E
  #MINMAX_FORMAT = $802F
  #MINMAX_SINK = $8030
  #TABLE_TOO_LARGE = $8031
  #COLOR_MATRIX = $80B1
  #COLOR_MATRIX_STACK_DEPTH = $80B2
  #MAX_COLOR_MATRIX_STACK_DEPTH = $80B3
  #POST_COLOR_MATRIX_RED_SCALE = $80B4
  #POST_COLOR_MATRIX_GREEN_SCALE = $80B5
  #POST_COLOR_MATRIX_BLUE_SCALE = $80B6
  #POST_COLOR_MATRIX_ALPHA_SCALE = $80B7
  #POST_COLOR_MATRIX_RED_BIAS = $80B8
  #POST_COLOR_MATRIX_GREEN_BIAS = $80B9
  #POST_COLOR_MATRIX_BLUE_BIAS = $80BA
  #POST_COLOR_MATRIX_ALPHA_BIAS = $80BB
  #COLOR_TABLE = $80D0
  #POST_CONVOLUTION_COLOR_TABLE = $80D1
  #POST_COLOR_MATRIX_COLOR_TABLE = $80D2
  #PROXY_COLOR_TABLE = $80D3
  #PROXY_POST_CONVOLUTION_COLOR_TABLE = $80D4
  #PROXY_POST_COLOR_MATRIX_COLOR_TABLE = $80D5
  #COLOR_TABLE_SCALE = $80D6
  #COLOR_TABLE_BIAS = $80D7
  #COLOR_TABLE_FORMAT = $80D8
  #COLOR_TABLE_WIDTH = $80D9
  #COLOR_TABLE_RED_SIZE = $80DA
  #COLOR_TABLE_GREEN_SIZE = $80DB
  #COLOR_TABLE_BLUE_SIZE = $80DC
  #COLOR_TABLE_ALPHA_SIZE = $80DD
  #COLOR_TABLE_LUMINANCE_SIZE = $80DE
  #COLOR_TABLE_INTENSITY_SIZE = $80DF
  #IGNORE_BORDER = $8150
  #CONSTANT_BORDER = $8151
  #WRAP_BORDER = $8152
  #REPLICATE_BORDER = $8153
  #CONVOLUTION_BORDER_COLOR = $8154
  #NUM_SAMPLE_COUNTS = $9380
  #INTERNALFORMAT_SUPPORTED = $826F
  #INTERNALFORMAT_PREFERRED = $8270
  #INTERNALFORMAT_RED_SIZE = $8271
  #INTERNALFORMAT_GREEN_SIZE = $8272
  #INTERNALFORMAT_BLUE_SIZE = $8273
  #INTERNALFORMAT_ALPHA_SIZE = $8274
  #INTERNALFORMAT_DEPTH_SIZE = $8275
  #INTERNALFORMAT_STENCIL_SIZE = $8276
  #INTERNALFORMAT_SHARED_SIZE = $8277
  #INTERNALFORMAT_RED_TYPE = $8278
  #INTERNALFORMAT_GREEN_TYPE = $8279
  #INTERNALFORMAT_BLUE_TYPE = $827A
  #INTERNALFORMAT_ALPHA_TYPE = $827B
  #INTERNALFORMAT_DEPTH_TYPE = $827C
  #INTERNALFORMAT_STENCIL_TYPE = $827D
  #MAX_WIDTH = $827E
  #MAX_HEIGHT = $827F
  #MAX_DEPTH = $8280
  #MAX_LAYERS = $8281
  #MAX_COMBINED_DIMENSIONS = $8282
  #COLOR_COMPONENTS = $8283
  #DEPTH_COMPONENTS = $8284
  #STENCIL_COMPONENTS = $8285
  #COLOR_RENDERABLE = $8286
  #DEPTH_RENDERABLE = $8287
  #STENCIL_RENDERABLE = $8288
  #FRAMEBUFFER_RENDERABLE = $8289
  #FRAMEBUFFER_RENDERABLE_LAYERED = $828A
  #FRAMEBUFFER_BLEND = $828B
  #READ_PIXELS = $828C
  #READ_PIXELS_FORMAT = $828D
  #READ_PIXELS_TYPE = $828E
  #TEXTURE_IMAGE_FORMAT = $828F
  #TEXTURE_IMAGE_TYPE = $8290
  #GET_TEXTURE_IMAGE_FORMAT = $8291
  #GET_TEXTURE_IMAGE_TYPE = $8292
  #MIPMAP = $8293
  #MANUAL_GENERATE_MIPMAP = $8294
  #AUTO_GENERATE_MIPMAP = $8295
  #COLOR_ENCODING = $8296
  #SRGB_READ = $8297
  #SRGB_WRITE = $8298
  #FILTER = $829A
  #VERTEX_TEXTURE = $829B
  #TESS_CONTROL_TEXTURE = $829C
  #TESS_EVALUATION_TEXTURE = $829D
  #GEOMETRY_TEXTURE = $829E
  #FRAGMENT_TEXTURE = $829F
  #COMPUTE_TEXTURE = $82A0
  #TEXTURE_SHADOW = $82A1
  #TEXTURE_GATHER = $82A2
  #TEXTURE_GATHER_SHADOW = $82A3
  #SHADER_IMAGE_LOAD = $82A4
  #SHADER_IMAGE_STORE = $82A5
  #SHADER_IMAGE_ATOMIC = $82A6
  #IMAGE_TEXEL_SIZE = $82A7
  #IMAGE_COMPATIBILITY_CLASS = $82A8
  #IMAGE_PIXEL_FORMAT = $82A9
  #IMAGE_PIXEL_TYPE = $82AA
  #SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = $82AC
  #SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = $82AD
  #SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = $82AE
  #SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = $82AF
  #TEXTURE_COMPRESSED_BLOCK_WIDTH = $82B1
  #TEXTURE_COMPRESSED_BLOCK_HEIGHT = $82B2
  #TEXTURE_COMPRESSED_BLOCK_SIZE = $82B3
  #CLEAR_BUFFER = $82B4
  #TEXTURE_VIEW = $82B5
  #VIEW_COMPATIBILITY_CLASS = $82B6
  #FULL_SUPPORT = $82B7
  #CAVEAT_SUPPORT = $82B8
  #IMAGE_CLASS_4_X_32 = $82B9
  #IMAGE_CLASS_2_X_32 = $82BA
  #IMAGE_CLASS_1_X_32 = $82BB
  #IMAGE_CLASS_4_X_16 = $82BC
  #IMAGE_CLASS_2_X_16 = $82BD
  #IMAGE_CLASS_1_X_16 = $82BE
  #IMAGE_CLASS_4_X_8 = $82BF
  #IMAGE_CLASS_2_X_8 = $82C0
  #IMAGE_CLASS_1_X_8 = $82C1
  #IMAGE_CLASS_11_11_10 = $82C2
  #IMAGE_CLASS_10_10_10_2 = $82C3
  #VIEW_CLASS_128_BITS = $82C4
  #VIEW_CLASS_96_BITS = $82C5
  #VIEW_CLASS_64_BITS = $82C6
  #VIEW_CLASS_48_BITS = $82C7
  #VIEW_CLASS_32_BITS = $82C8
  #VIEW_CLASS_24_BITS = $82C9
  #VIEW_CLASS_16_BITS = $82CA
  #VIEW_CLASS_8_BITS = $82CB
  #VIEW_CLASS_S3TC_DXT1_RGB = $82CC
  #VIEW_CLASS_S3TC_DXT1_RGBA = $82CD
  #VIEW_CLASS_S3TC_DXT3_RGBA = $82CE
  #VIEW_CLASS_S3TC_DXT5_RGBA = $82CF
  #VIEW_CLASS_RGTC1_RED = $82D0
  #VIEW_CLASS_RGTC2_RG = $82D1
  #VIEW_CLASS_BPTC_UNORM = $82D2
  #VIEW_CLASS_BPTC_FLOAT = $82D3
  #MIN_MAP_BUFFER_ALIGNMENT = $90BC
  #MAP_INVALIDATE_RANGE_BIT = $0004
  #MAP_INVALIDATE_BUFFER_BIT = $0008
  #MAP_FLUSH_EXPLICIT_BIT = $0010
  #MAP_UNSYNCHRONIZED_BIT = $0020
  #ANY_SAMPLES_PASSED = $8C2F
  #UNIFORM = $92E1
  #UNIFORM_BLOCK = $92E2
  #PROGRAM_INPUT = $92E3
  #PROGRAM_OUTPUT = $92E4
  #BUFFER_VARIABLE = $92E5
  #SHADER_STORAGE_BLOCK = $92E6
  #IS_PER_PATCH = $92E7
  #VERTEX_SUBROUTINE = $92E8
  #TESS_CONTROL_SUBROUTINE = $92E9
  #TESS_EVALUATION_SUBROUTINE = $92EA
  #GEOMETRY_SUBROUTINE = $92EB
  #FRAGMENT_SUBROUTINE = $92EC
  #COMPUTE_SUBROUTINE = $92ED
  #VERTEX_SUBROUTINE_UNIFORM = $92EE
  #TESS_CONTROL_SUBROUTINE_UNIFORM = $92EF
  #TESS_EVALUATION_SUBROUTINE_UNIFORM = $92F0
  #GEOMETRY_SUBROUTINE_UNIFORM = $92F1
  #FRAGMENT_SUBROUTINE_UNIFORM = $92F2
  #COMPUTE_SUBROUTINE_UNIFORM = $92F3
  #TRANSFORM_FEEDBACK_VARYING = $92F4
  #ACTIVE_RESOURCES = $92F5
  #MAX_NAME_LENGTH = $92F6
  #MAX_NUM_ACTIVE_VARIABLES = $92F7
  #MAX_NUM_COMPATIBLE_SUBROUTINES = $92F8
  #NAME_LENGTH = $92F9
  #TYPE = $92FA
  #ARRAY_SIZE = $92FB
  #OFFSET = $92FC
  #BLOCK_INDEX = $92FD
  #ARRAY_STRIDE = $92FE
  #MATRIX_STRIDE = $92FF
  #IS_ROW_MAJOR = $9300
  #ATOMIC_COUNTER_BUFFER_INDEX = $9301
  #BUFFER_BINDING = $9302
  #BUFFER_DATA_SIZE = $9303
  #NUM_ACTIVE_VARIABLES = $9304
  #ACTIVE_VARIABLES = $9305
  #REFERENCED_BY_VERTEX_SHADER = $9306
  #REFERENCED_BY_TESS_CONTROL_SHADER = $9307
  #REFERENCED_BY_TESS_EVALUATION_SHADER = $9308
  #REFERENCED_BY_GEOMETRY_SHADER = $9309
  #REFERENCED_BY_FRAGMENT_SHADER = $930A
  #REFERENCED_BY_COMPUTE_SHADER = $930B
  #TOP_LEVEL_ARRAY_SIZE = $930C
  #TOP_LEVEL_ARRAY_STRIDE = $930D
  #LOCATION = $930E
  #LOCATION_INDEX = $930F
  #QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = $8E4C
  #FIRST_VERTEX_CONVENTION = $8E4D
  #LAST_VERTEX_CONVENTION = $8E4E
  #PROVOKING_VERTEX = $8E4F
  #QUERY_BUFFER_BARRIER_BIT = $00008000
  #QUERY_BUFFER = $9192
  #QUERY_BUFFER_BINDING = $9193
  #QUERY_RESULT_NO_WAIT = $9194
  #SAMPLER_BINDING = $8919
  #VERTEX_SHADER_BIT = $00000001
  #FRAGMENT_SHADER_BIT = $00000002
  #GEOMETRY_SHADER_BIT = $00000004
  #TESS_CONTROL_SHADER_BIT = $00000008
  #TESS_EVALUATION_SHADER_BIT = $00000010
  #PROGRAM_SEPARABLE = $8258
  #ACTIVE_PROGRAM = $8259
  #PROGRAM_PIPELINE_BINDING = $825A
  #ALL_SHADER_BITS = $FFFFFFFF
  #ATOMIC_COUNTER_BUFFER = $92C0
  #ATOMIC_COUNTER_BUFFER_BINDING = $92C1
  #ATOMIC_COUNTER_BUFFER_START = $92C2
  #ATOMIC_COUNTER_BUFFER_SIZE = $92C3
  #ATOMIC_COUNTER_BUFFER_DATA_SIZE = $92C4
  #ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = $92C5
  #ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = $92C6
  #ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = $92C7
  #ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = $92C8
  #ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = $92C9
  #ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = $92CA
  #ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = $92CB
  #MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = $92CC
  #MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = $92CD
  #MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = $92CE
  #MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = $92CF
  #MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = $92D0
  #MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = $92D1
  #MAX_VERTEX_ATOMIC_COUNTERS = $92D2
  #MAX_TESS_CONTROL_ATOMIC_COUNTERS = $92D3
  #MAX_TESS_EVALUATION_ATOMIC_COUNTERS = $92D4
  #MAX_GEOMETRY_ATOMIC_COUNTERS = $92D5
  #MAX_FRAGMENT_ATOMIC_COUNTERS = $92D6
  #MAX_COMBINED_ATOMIC_COUNTERS = $92D7
  #MAX_ATOMIC_COUNTER_BUFFER_SIZE = $92D8
  #ACTIVE_ATOMIC_COUNTER_BUFFERS = $92D9
  #UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = $92DA
  #UNSIGNED_INT_ATOMIC_COUNTER = $92DB
  #MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = $92DC
  #VERTEX_ATTRIB_ARRAY_BARRIER_BIT = $00000001
  #ELEMENT_ARRAY_BARRIER_BIT = $00000002
  #UNIFORM_BARRIER_BIT = $00000004
  #TEXTURE_FETCH_BARRIER_BIT = $00000008
  #SHADER_IMAGE_ACCESS_BARRIER_BIT = $00000020
  #COMMAND_BARRIER_BIT = $00000040
  #PIXEL_BUFFER_BARRIER_BIT = $00000080
  #TEXTURE_UPDATE_BARRIER_BIT = $00000100
  #BUFFER_UPDATE_BARRIER_BIT = $00000200
  #FRAMEBUFFER_BARRIER_BIT = $00000400
  #TRANSFORM_FEEDBACK_BARRIER_BIT = $00000800
  #ATOMIC_COUNTER_BARRIER_BIT = $00001000
  #MAX_IMAGE_UNITS = $8F38
  #MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = $8F39
  #IMAGE_BINDING_NAME = $8F3A
  #IMAGE_BINDING_LEVEL = $8F3B
  #IMAGE_BINDING_LAYERED = $8F3C
  #IMAGE_BINDING_LAYER = $8F3D
  #IMAGE_BINDING_ACCESS = $8F3E
  #IMAGE_1D = $904C
  #IMAGE_2D = $904D
  #IMAGE_3D = $904E
  #IMAGE_2D_RECT = $904F
  #IMAGE_CUBE = $9050
  #IMAGE_BUFFER = $9051
  #IMAGE_1D_ARRAY = $9052
  #IMAGE_2D_ARRAY = $9053
  #IMAGE_CUBE_MAP_ARRAY = $9054
  #IMAGE_2D_MULTISAMPLE = $9055
  #IMAGE_2D_MULTISAMPLE_ARRAY = $9056
  #INT_IMAGE_1D = $9057
  #INT_IMAGE_2D = $9058
  #INT_IMAGE_3D = $9059
  #INT_IMAGE_2D_RECT = $905A
  #INT_IMAGE_CUBE = $905B
  #INT_IMAGE_BUFFER = $905C
  #INT_IMAGE_1D_ARRAY = $905D
  #INT_IMAGE_2D_ARRAY = $905E
  #INT_IMAGE_CUBE_MAP_ARRAY = $905F
  #INT_IMAGE_2D_MULTISAMPLE = $9060
  #INT_IMAGE_2D_MULTISAMPLE_ARRAY = $9061
  #UNSIGNED_INT_IMAGE_1D = $9062
  #UNSIGNED_INT_IMAGE_2D = $9063
  #UNSIGNED_INT_IMAGE_3D = $9064
  #UNSIGNED_INT_IMAGE_2D_RECT = $9065
  #UNSIGNED_INT_IMAGE_CUBE = $9066
  #UNSIGNED_INT_IMAGE_BUFFER = $9067
  #UNSIGNED_INT_IMAGE_1D_ARRAY = $9068
  #UNSIGNED_INT_IMAGE_2D_ARRAY = $9069
  #UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = $906A
  #UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = $906B
  #UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = $906C
  #MAX_IMAGE_SAMPLES = $906D
  #IMAGE_BINDING_FORMAT = $906E
  #IMAGE_FORMAT_COMPATIBILITY_TYPE = $90C7
  #IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = $90C8
  #IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = $90C9
  #MAX_VERTEX_IMAGE_UNIFORMS = $90CA
  #MAX_TESS_CONTROL_IMAGE_UNIFORMS = $90CB
  #MAX_TESS_EVALUATION_IMAGE_UNIFORMS = $90CC
  #MAX_GEOMETRY_IMAGE_UNIFORMS = $90CD
  #MAX_FRAGMENT_IMAGE_UNIFORMS = $90CE
  #MAX_COMBINED_IMAGE_UNIFORMS = $90CF
  #ALL_BARRIER_BITS = $FFFFFFFF
  #SHADER_STORAGE_BARRIER_BIT = $2000
  #MAX_COMBINED_SHADER_OUTPUT_RESOURCES = $8F39
  #SHADER_STORAGE_BUFFER = $90D2
  #SHADER_STORAGE_BUFFER_BINDING = $90D3
  #SHADER_STORAGE_BUFFER_START = $90D4
  #SHADER_STORAGE_BUFFER_SIZE = $90D5
  #MAX_VERTEX_SHADER_STORAGE_BLOCKS = $90D6
  #MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = $90D7
  #MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = $90D8
  #MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = $90D9
  #MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = $90DA
  #MAX_COMPUTE_SHADER_STORAGE_BLOCKS = $90DB
  #MAX_COMBINED_SHADER_STORAGE_BLOCKS = $90DC
  #MAX_SHADER_STORAGE_BUFFER_BINDINGS = $90DD
  #MAX_SHADER_STORAGE_BLOCK_SIZE = $90DE
  #SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = $90DF
  #ACTIVE_SUBROUTINES = $8DE5
  #ACTIVE_SUBROUTINE_UNIFORMS = $8DE6
  #MAX_SUBROUTINES = $8DE7
  #MAX_SUBROUTINE_UNIFORM_LOCATIONS = $8DE8
  #ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = $8E47
  #ACTIVE_SUBROUTINE_MAX_LENGTH = $8E48
  #ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = $8E49
  #NUM_COMPATIBLE_SUBROUTINES = $8E4A
  #COMPATIBLE_SUBROUTINES = $8E4B
  #DEPTH_STENCIL_TEXTURE_MODE = $90EA
  #SYNC_FLUSH_COMMANDS_BIT = $00000001
  #MAX_SERVER_WAIT_TIMEOUT = $9111
  #OBJECT_TYPE = $9112
  #SYNC_CONDITION = $9113
  #SYNC_STATUS = $9114
  #SYNC_FLAGS = $9115
  #SYNC_FENCE = $9116
  #SYNC_GPU_COMMANDS_COMPLETE = $9117
  #UNSIGNALED = $9118
  #SIGNALED = $9119
  #ALREADY_SIGNALED = $911A
  #TIMEOUT_EXPIRED = $911B
  #CONDITION_SATISFIED = $911C
  #WAIT_FAILED_ = $911D
  #TIMEOUT_IGNORED = $FFFFFFFFFFFFFFFF
  #PATCHES = $E
  #UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = $84F0
  #UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = $84F1
  #MAX_TESS_CONTROL_INPUT_COMPONENTS = $886C
  #MAX_TESS_EVALUATION_INPUT_COMPONENTS = $886D
  #MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = $8E1E
  #MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E1F
  #PATCH_VERTICES = $8E72
  #PATCH_DEFAULT_INNER_LEVEL = $8E73
  #PATCH_DEFAULT_OUTER_LEVEL = $8E74
  #TESS_CONTROL_OUTPUT_VERTICES = $8E75
  #TESS_GEN_MODE = $8E76
  #TESS_GEN_SPACING = $8E77
  #TESS_GEN_VERTEX_ORDER = $8E78
  #TESS_GEN_POINT_MODE = $8E79
  #ISOLINES = $8E7A
  #FRACTIONAL_ODD = $8E7B
  #FRACTIONAL_EVEN = $8E7C
  #MAX_PATCH_VERTICES = $8E7D
  #MAX_TESS_GEN_LEVEL = $8E7E
  #MAX_TESS_CONTROL_UNIFORM_COMPONENTS = $8E7F
  #MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = $8E80
  #MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = $8E81
  #MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = $8E82
  #MAX_TESS_CONTROL_OUTPUT_COMPONENTS = $8E83
  #MAX_TESS_PATCH_COMPONENTS = $8E84
  #MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = $8E85
  #MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = $8E86
  #TESS_EVALUATION_SHADER = $8E87
  #TESS_CONTROL_SHADER = $8E88
  #MAX_TESS_CONTROL_UNIFORM_BLOCKS = $8E89
  #MAX_TESS_EVALUATION_UNIFORM_BLOCKS = $8E8A
  #TEXTURE_BUFFER_OFFSET = $919D
  #TEXTURE_BUFFER_SIZE = $919E
  #TEXTURE_BUFFER_OFFSET_ALIGNMENT = $919F
  #COMPRESSED_RED_RGTC1 = $8DBB
  #COMPRESSED_SIGNED_RED_RGTC1 = $8DBC
  #COMPRESSED_RG_RGTC2 = $8DBD
  #COMPRESSED_SIGNED_RG_RGTC2 = $8DBE
  #MIRROR_CLAMP_TO_EDGE = $8743
  #SAMPLE_POSITION = $8E50
  #SAMPLE_MASK = $8E51
  #SAMPLE_MASK_VALUE = $8E52
  #MAX_SAMPLE_MASK_WORDS = $8E59
  #TEXTURE_2D_MULTISAMPLE = $9100
  #PROXY_TEXTURE_2D_MULTISAMPLE = $9101
  #TEXTURE_2D_MULTISAMPLE_ARRAY = $9102
  #PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = $9103
  #TEXTURE_BINDING_2D_MULTISAMPLE = $9104
  #TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = $9105
  #TEXTURE_SAMPLES = $9106
  #TEXTURE_FIXED_SAMPLE_LOCATIONS = $9107
  #SAMPLER_2D_MULTISAMPLE = $9108
  #INT_SAMPLER_2D_MULTISAMPLE = $9109
  #UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = $910A
  #SAMPLER_2D_MULTISAMPLE_ARRAY = $910B
  #INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910C
  #UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = $910D
  #MAX_COLOR_TEXTURE_SAMPLES = $910E
  #MAX_DEPTH_TEXTURE_SAMPLES = $910F
  #MAX_INTEGER_SAMPLES = $9110
  #COMPRESSED_RED = $8225
  #COMPRESSED_RG = $8226
  #RG = $8227
  #RG_INTEGER = $8228
  #R8 = $8229
  #R16 = $822A
  #RG8 = $822B
  #RG16 = $822C
  #R16F = $822D
  #R32F = $822E
  #RG16F = $822F
  #RG32F = $8230
  #R8I = $8231
  #R8UI = $8232
  #R16I = $8233
  #R16UI = $8234
  #R32I = $8235
  #R32UI = $8236
  #RG8I = $8237
  #RG16I = $8239
  #RG32I = $823B
  #RG32UI = $823C
  #TEXTURE_IMMUTABLE_FORMAT = $912F
  #TEXTURE_SWIZZLE_R = $8E42
  #TEXTURE_SWIZZLE_G = $8E43
  #TEXTURE_SWIZZLE_B = $8E44
  #TEXTURE_SWIZZLE_A = $8E45
  #TEXTURE_SWIZZLE_RGBA = $8E46
  #TEXTURE_VIEW_MIN_LEVEL = $82DB
  #TEXTURE_VIEW_NUM_LEVELS = $82DC
  #TEXTURE_VIEW_MIN_LAYER = $82DD
  #TEXTURE_VIEW_NUM_LAYERS = $82DE
  #TIME_ELAPSED = $88BF
  #TIMESTAMP = $8E28
  #TRANSFORM_FEEDBACK = $8E22
  #TRANSFORM_FEEDBACK_BUFFER_PAUSED = $8E23
  #TRANSFORM_FEEDBACK_BUFFER_ACTIVE = $8E24
  #TRANSFORM_FEEDBACK_BINDING = $8E25
  #MAX_TRANSFORM_FEEDBACK_BUFFERS = $8E70
  #UNIFORM_BUFFER = $8A11
  #UNIFORM_BUFFER_BINDING = $8A28
  #UNIFORM_BUFFER_START = $8A29
  #UNIFORM_BUFFER_SIZE = $8A2A
  #MAX_VERTEX_UNIFORM_BLOCKS = $8A2B
  #MAX_GEOMETRY_UNIFORM_BLOCKS = $8A2C
  #MAX_FRAGMENT_UNIFORM_BLOCKS = $8A2D
  #MAX_COMBINED_UNIFORM_BLOCKS = $8A2E
  #MAX_UNIFORM_BUFFER_BINDINGS = $8A2F
  #MAX_UNIFORM_BLOCK_SIZE = $8A30
  #MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = $8A31
  #MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = $8A32
  #MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = $8A33
  #UNIFORM_BUFFER_OFFSET_ALIGNMENT = $8A34
  #ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = $8A35
  #ACTIVE_UNIFORM_BLOCKS = $8A36
  #UNIFORM_TYPE = $8A37
  #UNIFORM_SIZE = $8A38
  #UNIFORM_NAME_LENGTH = $8A39
  #UNIFORM_BLOCK_INDEX = $8A3A
  #UNIFORM_OFFSET = $8A3B
  #UNIFORM_ARRAY_STRIDE = $8A3C
  #UNIFORM_MATRIX_STRIDE = $8A3D
  #UNIFORM_IS_ROW_MAJOR = $8A3E
  #UNIFORM_BLOCK_BINDING = $8A3F
  #UNIFORM_BLOCK_DATA_SIZE = $8A40
  #UNIFORM_BLOCK_NAME_LENGTH = $8A41
  #UNIFORM_BLOCK_ACTIVE_UNIFORMS = $8A42
  #UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = $8A43
  #UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = $8A44
  #UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = $8A45
  #UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = $8A46
  #INVALID_INDEX = $FFFFFFFF
  #VERTEX_ARRAY_BINDING = $85B5
  #VERTEX_ATTRIB_BINDING = $82D4
  #VERTEX_ATTRIB_RELATIVE_OFFSET = $82D5
  #VERTEX_BINDING_DIVISOR = $82D6
  #VERTEX_BINDING_OFFSET = $82D7
  #VERTEX_BINDING_STRIDE = $82D8
  #MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = $82D9
  #MAX_VERTEX_ATTRIB_BINDINGS = $82DA
  #VERTEX_BINDING_BUFFER = $8F4F
  #UNSIGNED_INT_2_10_10_10_REV = $8368
  #INT_2_10_10_10_REV = $8D9F
  #MAX_VIEWPORTS = $825B
  #VIEWPORT_SUBPIXEL_BITS = $825C
  #VIEWPORT_BOUNDS_RANGE = $825D
  #LAYER_PROVOKING_VERTEX = $825E
  #VIEWPORT_INDEX_PROVOKING_VERTEX = $825F
  #UNDEFINED_VERTEX = $8260
  #ALPHA_SNORM = $9010
  #LUMINANCE_SNORM = $9011
  #LUMINANCE_ALPHA_SNORM = $9012
  #INTENSITY_SNORM = $9013
  #ALPHA8_SNORM = $9014
  #LUMINANCE8_SNORM = $9015
  #LUMINANCE8_ALPHA8_SNORM = $9016
  #INTENSITY8_SNORM = $9017
  #ALPHA16_SNORM = $9018
  #LUMINANCE16_SNORM = $9019
  #LUMINANCE16_ALPHA16_SNORM = $901A
  #INTENSITY16_SNORM = $901B
  #CONTEXT_FLAG_DEBUG_BIT = $00000002
  #DEBUG_OUTPUT_SYNCHRONOUS = $8242
  #DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = $8243
  #DEBUG_CALLBACK_FUNCTION = $8244
  #DEBUG_CALLBACK_USER_PARAM = $8245
  #DEBUG_SOURCE_API = $8246
  #DEBUG_SOURCE_WINDOW_SYSTEM = $8247
  #DEBUG_SOURCE_SHADER_COMPILER = $8248
  #DEBUG_SOURCE_THIRD_PARTY = $8249
  #DEBUG_SOURCE_APPLICATION = $824A
  #DEBUG_SOURCE_OTHER = $824B
  #DEBUG_TYPE_ERROR = $824C
  #DEBUG_TYPE_DEPRECATED_BEHAVIOR = $824D
  #DEBUG_TYPE_UNDEFINED_BEHAVIOR = $824E
  #DEBUG_TYPE_PORTABILITY = $824F
  #DEBUG_TYPE_PERFORMANCE = $8250
  #DEBUG_TYPE_OTHER = $8251
  #DEBUG_TYPE_MARKER = $8268
  #DEBUG_TYPE_PUSH_GROUP = $8269
  #DEBUG_TYPE_POP_GROUP = $826A
  #DEBUG_SEVERITY_NOTIFICATION = $826B
  #MAX_DEBUG_GROUP_STACK_DEPTH = $826C
  #DEBUG_GROUP_STACK_DEPTH = $826D
  #BUFFER = $82E0
  #SHADER = $82E1
  #PROGRAM = $82E2
  #QUERY = $82E3
  #PROGRAM_PIPELINE = $82E4
  #SAMPLER = $82E6
  #DISPLAY_LIST = $82E7
  #MAX_LABEL_LENGTH = $82E8
  #MAX_DEBUG_MESSAGE_LENGTH = $9143
  #MAX_DEBUG_LOGGED_MESSAGES = $9144
  #DEBUG_LOGGED_MESSAGES = $9145
  #DEBUG_SEVERITY_HIGH = $9146
  #DEBUG_SEVERITY_MEDIUM = $9147
  #DEBUG_SEVERITY_LOW = $9148
  #DEBUG_OUTPUT = $92E0
  #CONTEXT_LOST = $0507
  #LOSE_CONTEXT_ON_RESET = $8252
  #GUILTY_CONTEXT_RESET = $8253
  #INNOCENT_CONTEXT_RESET = $8254
  #UNKNOWN_CONTEXT_RESET = $8255
  #RESET_NOTIFICATION_STRATEGY = $8256
  #NO_RESET_NOTIFICATION = $8261
  #CONTEXT_ROBUST_ACCESS = $90F3
  #STATE_RESTORE = $8BDC
  #REND_screen_coordinates = 1
  #SCREEN_COORDINATES_REND = $8490
  #INVERTED_SCREEN_W_REND = $8491
  #RGB_S3TC = $83A0
  #RGB4_S3TC = $83A1
  #RGBA_S3TC = $83A2
  #RGBA4_S3TC = $83A3
  #RGBA_DXT5_S3TC = $83A4
  #RGBA4_DXT5_S3TC = $83A5
  #BALI_NUM_TRIS_CULLED_INSTRUMENT = $6080
  #BALI_NUM_PRIMS_CLIPPED_INSTRUMENT = $6081
  #BALI_NUM_PRIMS_REJECT_INSTRUMENT = $6082
  #BALI_NUM_PRIMS_CLIP_RESULT_INSTRUMENT = $6083
  #BALI_FRAGMENTS_GENERATED_INSTRUMENT = $6090
  #BALI_DEPTH_PASS_INSTRUMENT = $6091
  #BALI_R_CHIP_COUNT = $6092
  #COLOR_MATRIX_HINT = $8317
  #GEOMETRY_BIT = $1
  #IMAGE_BIT = $2
  #LIGHT31 = $BEAD
CompilerIf _gl::GL_VERSION_ATLEAST(1,1,0)
  Global Accum._gl::_prot_glAccum
  AddElement( _gl::functions() )
  _gl::functions()\name = "glAccum"
  _gl::functions()\pointer = @Accum
  _gl::functions()\version = 1100
  Global AlphaFunc._gl::_prot_glAlphaFunc
  AddElement( _gl::functions() )
  _gl::functions()\name = "glAlphaFunc"
  _gl::functions()\pointer = @AlphaFunc
  _gl::functions()\version = 1100
  Global AreTexturesResident._gl::_prot_glAreTexturesResident
  AddElement( _gl::functions() )
  _gl::functions()\name = "glAreTexturesResident"
  _gl::functions()\pointer = @AreTexturesResident
  _gl::functions()\version = 1100
  Global ArrayElement._gl::_prot_glArrayElement
  AddElement( _gl::functions() )
  _gl::functions()\name = "glArrayElement"
  _gl::functions()\pointer = @ArrayElement
  _gl::functions()\version = 1100
  Global Begin._gl::_prot_glBegin
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBegin"
  _gl::functions()\pointer = @Begin
  _gl::functions()\version = 1100
  Global BindTexture._gl::_prot_glBindTexture
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindTexture"
  _gl::functions()\pointer = @BindTexture
  _gl::functions()\version = 1100
  Global Bitmap._gl::_prot_glBitmap
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBitmap"
  _gl::functions()\pointer = @Bitmap
  _gl::functions()\version = 1100
  Global BlendFunc._gl::_prot_glBlendFunc
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendFunc"
  _gl::functions()\pointer = @BlendFunc
  _gl::functions()\version = 1100
  Global CallList._gl::_prot_glCallList
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCallList"
  _gl::functions()\pointer = @CallList
  _gl::functions()\version = 1100
  Global CallLists._gl::_prot_glCallLists
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCallLists"
  _gl::functions()\pointer = @CallLists
  _gl::functions()\version = 1100
  Global Clear._gl::_prot_glClear
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClear"
  _gl::functions()\pointer = @Clear
  _gl::functions()\version = 1100
  Global ClearAccum._gl::_prot_glClearAccum
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearAccum"
  _gl::functions()\pointer = @ClearAccum
  _gl::functions()\version = 1100
  Global ClearColor._gl::_prot_glClearColor
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearColor"
  _gl::functions()\pointer = @ClearColor
  _gl::functions()\version = 1100
  Global ClearDepth._gl::_prot_glClearDepth
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearDepth"
  _gl::functions()\pointer = @ClearDepth
  _gl::functions()\version = 1100
  Global ClearIndex._gl::_prot_glClearIndex
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearIndex"
  _gl::functions()\pointer = @ClearIndex
  _gl::functions()\version = 1100
  Global ClearStencil._gl::_prot_glClearStencil
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearStencil"
  _gl::functions()\pointer = @ClearStencil
  _gl::functions()\version = 1100
  Global ClipPlane._gl::_prot_glClipPlane
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClipPlane"
  _gl::functions()\pointer = @ClipPlane
  _gl::functions()\version = 1100
  Global Color3b._gl::_prot_glColor3b
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3b"
  _gl::functions()\pointer = @Color3b
  _gl::functions()\version = 1100
  Global Color3bv._gl::_prot_glColor3bv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3bv"
  _gl::functions()\pointer = @Color3bv
  _gl::functions()\version = 1100
  Global Color3d._gl::_prot_glColor3d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3d"
  _gl::functions()\pointer = @Color3d
  _gl::functions()\version = 1100
  Global Color3dv._gl::_prot_glColor3dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3dv"
  _gl::functions()\pointer = @Color3dv
  _gl::functions()\version = 1100
  Global Color3f._gl::_prot_glColor3f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3f"
  _gl::functions()\pointer = @Color3f
  _gl::functions()\version = 1100
  Global Color3fv._gl::_prot_glColor3fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3fv"
  _gl::functions()\pointer = @Color3fv
  _gl::functions()\version = 1100
  Global Color3i._gl::_prot_glColor3i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3i"
  _gl::functions()\pointer = @Color3i
  _gl::functions()\version = 1100
  Global Color3iv._gl::_prot_glColor3iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3iv"
  _gl::functions()\pointer = @Color3iv
  _gl::functions()\version = 1100
  Global Color3s._gl::_prot_glColor3s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3s"
  _gl::functions()\pointer = @Color3s
  _gl::functions()\version = 1100
  Global Color3sv._gl::_prot_glColor3sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3sv"
  _gl::functions()\pointer = @Color3sv
  _gl::functions()\version = 1100
  Global Color3ub._gl::_prot_glColor3ub
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3ub"
  _gl::functions()\pointer = @Color3ub
  _gl::functions()\version = 1100
  Global Color3ubv._gl::_prot_glColor3ubv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3ubv"
  _gl::functions()\pointer = @Color3ubv
  _gl::functions()\version = 1100
  Global Color3ui._gl::_prot_glColor3ui
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3ui"
  _gl::functions()\pointer = @Color3ui
  _gl::functions()\version = 1100
  Global Color3uiv._gl::_prot_glColor3uiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3uiv"
  _gl::functions()\pointer = @Color3uiv
  _gl::functions()\version = 1100
  Global Color3us._gl::_prot_glColor3us
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3us"
  _gl::functions()\pointer = @Color3us
  _gl::functions()\version = 1100
  Global Color3usv._gl::_prot_glColor3usv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor3usv"
  _gl::functions()\pointer = @Color3usv
  _gl::functions()\version = 1100
  Global Color4b._gl::_prot_glColor4b
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4b"
  _gl::functions()\pointer = @Color4b
  _gl::functions()\version = 1100
  Global Color4bv._gl::_prot_glColor4bv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4bv"
  _gl::functions()\pointer = @Color4bv
  _gl::functions()\version = 1100
  Global Color4d._gl::_prot_glColor4d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4d"
  _gl::functions()\pointer = @Color4d
  _gl::functions()\version = 1100
  Global Color4dv._gl::_prot_glColor4dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4dv"
  _gl::functions()\pointer = @Color4dv
  _gl::functions()\version = 1100
  Global Color4f._gl::_prot_glColor4f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4f"
  _gl::functions()\pointer = @Color4f
  _gl::functions()\version = 1100
  Global Color4fv._gl::_prot_glColor4fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4fv"
  _gl::functions()\pointer = @Color4fv
  _gl::functions()\version = 1100
  Global Color4i._gl::_prot_glColor4i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4i"
  _gl::functions()\pointer = @Color4i
  _gl::functions()\version = 1100
  Global Color4iv._gl::_prot_glColor4iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4iv"
  _gl::functions()\pointer = @Color4iv
  _gl::functions()\version = 1100
  Global Color4s._gl::_prot_glColor4s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4s"
  _gl::functions()\pointer = @Color4s
  _gl::functions()\version = 1100
  Global Color4sv._gl::_prot_glColor4sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4sv"
  _gl::functions()\pointer = @Color4sv
  _gl::functions()\version = 1100
  Global Color4ub._gl::_prot_glColor4ub
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4ub"
  _gl::functions()\pointer = @Color4ub
  _gl::functions()\version = 1100
  Global Color4ubv._gl::_prot_glColor4ubv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4ubv"
  _gl::functions()\pointer = @Color4ubv
  _gl::functions()\version = 1100
  Global Color4ui._gl::_prot_glColor4ui
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4ui"
  _gl::functions()\pointer = @Color4ui
  _gl::functions()\version = 1100
  Global Color4uiv._gl::_prot_glColor4uiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4uiv"
  _gl::functions()\pointer = @Color4uiv
  _gl::functions()\version = 1100
  Global Color4us._gl::_prot_glColor4us
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4us"
  _gl::functions()\pointer = @Color4us
  _gl::functions()\version = 1100
  Global Color4usv._gl::_prot_glColor4usv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4usv"
  _gl::functions()\pointer = @Color4usv
  _gl::functions()\version = 1100
  Global ColorMask._gl::_prot_glColorMask
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorMask"
  _gl::functions()\pointer = @ColorMask
  _gl::functions()\version = 1100
  Global ColorMaterial._gl::_prot_glColorMaterial
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorMaterial"
  _gl::functions()\pointer = @ColorMaterial
  _gl::functions()\version = 1100
  Global ColorPointer._gl::_prot_glColorPointer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorPointer"
  _gl::functions()\pointer = @ColorPointer
  _gl::functions()\version = 1100
  Global CopyPixels._gl::_prot_glCopyPixels
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyPixels"
  _gl::functions()\pointer = @CopyPixels
  _gl::functions()\version = 1100
  Global CopyTexImage1D._gl::_prot_glCopyTexImage1D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTexImage1D"
  _gl::functions()\pointer = @CopyTexImage1D
  _gl::functions()\version = 1100
  Global CopyTexImage2D._gl::_prot_glCopyTexImage2D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTexImage2D"
  _gl::functions()\pointer = @CopyTexImage2D
  _gl::functions()\version = 1100
  Global CopyTexSubImage1D._gl::_prot_glCopyTexSubImage1D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTexSubImage1D"
  _gl::functions()\pointer = @CopyTexSubImage1D
  _gl::functions()\version = 1100
  Global CopyTexSubImage2D._gl::_prot_glCopyTexSubImage2D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTexSubImage2D"
  _gl::functions()\pointer = @CopyTexSubImage2D
  _gl::functions()\version = 1100
  Global CullFace._gl::_prot_glCullFace
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCullFace"
  _gl::functions()\pointer = @CullFace
  _gl::functions()\version = 1100
  Global DeleteLists._gl::_prot_glDeleteLists
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteLists"
  _gl::functions()\pointer = @DeleteLists
  _gl::functions()\version = 1100
  Global DeleteTextures._gl::_prot_glDeleteTextures
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteTextures"
  _gl::functions()\pointer = @DeleteTextures
  _gl::functions()\version = 1100
  Global DepthFunc._gl::_prot_glDepthFunc
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthFunc"
  _gl::functions()\pointer = @DepthFunc
  _gl::functions()\version = 1100
  Global DepthMask._gl::_prot_glDepthMask
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthMask"
  _gl::functions()\pointer = @DepthMask
  _gl::functions()\version = 1100
  Global DepthRange._gl::_prot_glDepthRange
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthRange"
  _gl::functions()\pointer = @DepthRange
  _gl::functions()\version = 1100
  Global Disable._gl::_prot_glDisable
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDisable"
  _gl::functions()\pointer = @Disable
  _gl::functions()\version = 1100
  Global DisableClientState._gl::_prot_glDisableClientState
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDisableClientState"
  _gl::functions()\pointer = @DisableClientState
  _gl::functions()\version = 1100
  Global DrawArrays._gl::_prot_glDrawArrays
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawArrays"
  _gl::functions()\pointer = @DrawArrays
  _gl::functions()\version = 1100
  Global DrawBuffer._gl::_prot_glDrawBuffer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawBuffer"
  _gl::functions()\pointer = @DrawBuffer
  _gl::functions()\version = 1100
  Global DrawElements._gl::_prot_glDrawElements
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElements"
  _gl::functions()\pointer = @DrawElements
  _gl::functions()\version = 1100
  Global DrawPixels._gl::_prot_glDrawPixels
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawPixels"
  _gl::functions()\pointer = @DrawPixels
  _gl::functions()\version = 1100
  Global EdgeFlag._gl::_prot_glEdgeFlag
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEdgeFlag"
  _gl::functions()\pointer = @EdgeFlag
  _gl::functions()\version = 1100
  Global EdgeFlagPointer._gl::_prot_glEdgeFlagPointer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEdgeFlagPointer"
  _gl::functions()\pointer = @EdgeFlagPointer
  _gl::functions()\version = 1100
  Global EdgeFlagv._gl::_prot_glEdgeFlagv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEdgeFlagv"
  _gl::functions()\pointer = @EdgeFlagv
  _gl::functions()\version = 1100
  Global Enable._gl::_prot_glEnable
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEnable"
  _gl::functions()\pointer = @Enable
  _gl::functions()\version = 1100
  Global EnableClientState._gl::_prot_glEnableClientState
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEnableClientState"
  _gl::functions()\pointer = @EnableClientState
  _gl::functions()\version = 1100
  Global End_._gl::_prot_glEnd
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEnd"
  _gl::functions()\pointer = @End_
  _gl::functions()\version = 1100
  Global EndList._gl::_prot_glEndList
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEndList"
  _gl::functions()\pointer = @EndList
  _gl::functions()\version = 1100
  Global EvalCoord1d._gl::_prot_glEvalCoord1d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord1d"
  _gl::functions()\pointer = @EvalCoord1d
  _gl::functions()\version = 1100
  Global EvalCoord1dv._gl::_prot_glEvalCoord1dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord1dv"
  _gl::functions()\pointer = @EvalCoord1dv
  _gl::functions()\version = 1100
  Global EvalCoord1f._gl::_prot_glEvalCoord1f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord1f"
  _gl::functions()\pointer = @EvalCoord1f
  _gl::functions()\version = 1100
  Global EvalCoord1fv._gl::_prot_glEvalCoord1fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord1fv"
  _gl::functions()\pointer = @EvalCoord1fv
  _gl::functions()\version = 1100
  Global EvalCoord2d._gl::_prot_glEvalCoord2d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord2d"
  _gl::functions()\pointer = @EvalCoord2d
  _gl::functions()\version = 1100
  Global EvalCoord2dv._gl::_prot_glEvalCoord2dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord2dv"
  _gl::functions()\pointer = @EvalCoord2dv
  _gl::functions()\version = 1100
  Global EvalCoord2f._gl::_prot_glEvalCoord2f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord2f"
  _gl::functions()\pointer = @EvalCoord2f
  _gl::functions()\version = 1100
  Global EvalCoord2fv._gl::_prot_glEvalCoord2fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalCoord2fv"
  _gl::functions()\pointer = @EvalCoord2fv
  _gl::functions()\version = 1100
  Global EvalMesh1._gl::_prot_glEvalMesh1
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalMesh1"
  _gl::functions()\pointer = @EvalMesh1
  _gl::functions()\version = 1100
  Global EvalMesh2._gl::_prot_glEvalMesh2
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalMesh2"
  _gl::functions()\pointer = @EvalMesh2
  _gl::functions()\version = 1100
  Global EvalPoint1._gl::_prot_glEvalPoint1
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalPoint1"
  _gl::functions()\pointer = @EvalPoint1
  _gl::functions()\version = 1100
  Global EvalPoint2._gl::_prot_glEvalPoint2
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEvalPoint2"
  _gl::functions()\pointer = @EvalPoint2
  _gl::functions()\version = 1100
  Global FeedbackBuffer._gl::_prot_glFeedbackBuffer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFeedbackBuffer"
  _gl::functions()\pointer = @FeedbackBuffer
  _gl::functions()\version = 1100
  Global Finish._gl::_prot_glFinish
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFinish"
  _gl::functions()\pointer = @Finish
  _gl::functions()\version = 1100
  Global Flush._gl::_prot_glFlush
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFlush"
  _gl::functions()\pointer = @Flush
  _gl::functions()\version = 1100
  Global Fogf._gl::_prot_glFogf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogf"
  _gl::functions()\pointer = @Fogf
  _gl::functions()\version = 1100
  Global Fogfv._gl::_prot_glFogfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogfv"
  _gl::functions()\pointer = @Fogfv
  _gl::functions()\version = 1100
  Global Fogi._gl::_prot_glFogi
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogi"
  _gl::functions()\pointer = @Fogi
  _gl::functions()\version = 1100
  Global Fogiv._gl::_prot_glFogiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogiv"
  _gl::functions()\pointer = @Fogiv
  _gl::functions()\version = 1100
  Global FrontFace._gl::_prot_glFrontFace
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFrontFace"
  _gl::functions()\pointer = @FrontFace
  _gl::functions()\version = 1100
  Global Frustum._gl::_prot_glFrustum
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFrustum"
  _gl::functions()\pointer = @Frustum
  _gl::functions()\version = 1100
  Global GenLists._gl::_prot_glGenLists
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenLists"
  _gl::functions()\pointer = @GenLists
  _gl::functions()\version = 1100
  Global GenTextures._gl::_prot_glGenTextures
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenTextures"
  _gl::functions()\pointer = @GenTextures
  _gl::functions()\version = 1100
  Global GetBooleanv._gl::_prot_glGetBooleanv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetBooleanv"
  _gl::functions()\pointer = @GetBooleanv
  _gl::functions()\version = 1100
  Global GetClipPlane._gl::_prot_glGetClipPlane
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetClipPlane"
  _gl::functions()\pointer = @GetClipPlane
  _gl::functions()\version = 1100
  Global GetDoublev._gl::_prot_glGetDoublev
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetDoublev"
  _gl::functions()\pointer = @GetDoublev
  _gl::functions()\version = 1100
  Global GetError._gl::_prot_glGetError
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetError"
  _gl::functions()\pointer = @GetError
  _gl::functions()\version = 1100
  Global GetFloatv._gl::_prot_glGetFloatv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFloatv"
  _gl::functions()\pointer = @GetFloatv
  _gl::functions()\version = 1100
  Global GetIntegerv._gl::_prot_glGetIntegerv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetIntegerv"
  _gl::functions()\pointer = @GetIntegerv
  _gl::functions()\version = 1100
  Global GetLightfv._gl::_prot_glGetLightfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetLightfv"
  _gl::functions()\pointer = @GetLightfv
  _gl::functions()\version = 1100
  Global GetLightiv._gl::_prot_glGetLightiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetLightiv"
  _gl::functions()\pointer = @GetLightiv
  _gl::functions()\version = 1100
  Global GetMapdv._gl::_prot_glGetMapdv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMapdv"
  _gl::functions()\pointer = @GetMapdv
  _gl::functions()\version = 1100
  Global GetMapfv._gl::_prot_glGetMapfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMapfv"
  _gl::functions()\pointer = @GetMapfv
  _gl::functions()\version = 1100
  Global GetMapiv._gl::_prot_glGetMapiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMapiv"
  _gl::functions()\pointer = @GetMapiv
  _gl::functions()\version = 1100
  Global GetMaterialfv._gl::_prot_glGetMaterialfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMaterialfv"
  _gl::functions()\pointer = @GetMaterialfv
  _gl::functions()\version = 1100
  Global GetMaterialiv._gl::_prot_glGetMaterialiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMaterialiv"
  _gl::functions()\pointer = @GetMaterialiv
  _gl::functions()\version = 1100
  Global GetPixelMapfv._gl::_prot_glGetPixelMapfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetPixelMapfv"
  _gl::functions()\pointer = @GetPixelMapfv
  _gl::functions()\version = 1100
  Global GetPixelMapuiv._gl::_prot_glGetPixelMapuiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetPixelMapuiv"
  _gl::functions()\pointer = @GetPixelMapuiv
  _gl::functions()\version = 1100
  Global GetPixelMapusv._gl::_prot_glGetPixelMapusv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetPixelMapusv"
  _gl::functions()\pointer = @GetPixelMapusv
  _gl::functions()\version = 1100
  Global GetPointerv._gl::_prot_glGetPointerv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetPointerv"
  _gl::functions()\pointer = @GetPointerv
  _gl::functions()\version = 1100
  Global GetPolygonStipple._gl::_prot_glGetPolygonStipple
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetPolygonStipple"
  _gl::functions()\pointer = @GetPolygonStipple
  _gl::functions()\version = 1100
  Global GetString._gl::_prot_glGetString
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetString"
  _gl::functions()\pointer = @GetString
  _gl::functions()\version = 1100
  Global GetTexEnvfv._gl::_prot_glGetTexEnvfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexEnvfv"
  _gl::functions()\pointer = @GetTexEnvfv
  _gl::functions()\version = 1100
  Global GetTexEnviv._gl::_prot_glGetTexEnviv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexEnviv"
  _gl::functions()\pointer = @GetTexEnviv
  _gl::functions()\version = 1100
  Global GetTexGendv._gl::_prot_glGetTexGendv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexGendv"
  _gl::functions()\pointer = @GetTexGendv
  _gl::functions()\version = 1100
  Global GetTexGenfv._gl::_prot_glGetTexGenfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexGenfv"
  _gl::functions()\pointer = @GetTexGenfv
  _gl::functions()\version = 1100
  Global GetTexGeniv._gl::_prot_glGetTexGeniv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexGeniv"
  _gl::functions()\pointer = @GetTexGeniv
  _gl::functions()\version = 1100
  Global GetTexImage._gl::_prot_glGetTexImage
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexImage"
  _gl::functions()\pointer = @GetTexImage
  _gl::functions()\version = 1100
  Global GetTexLevelParameterfv._gl::_prot_glGetTexLevelParameterfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexLevelParameterfv"
  _gl::functions()\pointer = @GetTexLevelParameterfv
  _gl::functions()\version = 1100
  Global GetTexLevelParameteriv._gl::_prot_glGetTexLevelParameteriv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexLevelParameteriv"
  _gl::functions()\pointer = @GetTexLevelParameteriv
  _gl::functions()\version = 1100
  Global GetTexParameterfv._gl::_prot_glGetTexParameterfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexParameterfv"
  _gl::functions()\pointer = @GetTexParameterfv
  _gl::functions()\version = 1100
  Global GetTexParameteriv._gl::_prot_glGetTexParameteriv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexParameteriv"
  _gl::functions()\pointer = @GetTexParameteriv
  _gl::functions()\version = 1100
  Global Hint._gl::_prot_glHint
  AddElement( _gl::functions() )
  _gl::functions()\name = "glHint"
  _gl::functions()\pointer = @Hint
  _gl::functions()\version = 1100
  Global IndexMask._gl::_prot_glIndexMask
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexMask"
  _gl::functions()\pointer = @IndexMask
  _gl::functions()\version = 1100
  Global IndexPointer._gl::_prot_glIndexPointer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexPointer"
  _gl::functions()\pointer = @IndexPointer
  _gl::functions()\version = 1100
  Global Indexd._gl::_prot_glIndexd
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexd"
  _gl::functions()\pointer = @Indexd
  _gl::functions()\version = 1100
  Global Indexdv._gl::_prot_glIndexdv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexdv"
  _gl::functions()\pointer = @Indexdv
  _gl::functions()\version = 1100
  Global Indexf._gl::_prot_glIndexf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexf"
  _gl::functions()\pointer = @Indexf
  _gl::functions()\version = 1100
  Global Indexfv._gl::_prot_glIndexfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexfv"
  _gl::functions()\pointer = @Indexfv
  _gl::functions()\version = 1100
  Global Indexi._gl::_prot_glIndexi
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexi"
  _gl::functions()\pointer = @Indexi
  _gl::functions()\version = 1100
  Global Indexiv._gl::_prot_glIndexiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexiv"
  _gl::functions()\pointer = @Indexiv
  _gl::functions()\version = 1100
  Global Indexs._gl::_prot_glIndexs
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexs"
  _gl::functions()\pointer = @Indexs
  _gl::functions()\version = 1100
  Global Indexsv._gl::_prot_glIndexsv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexsv"
  _gl::functions()\pointer = @Indexsv
  _gl::functions()\version = 1100
  Global Indexub._gl::_prot_glIndexub
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexub"
  _gl::functions()\pointer = @Indexub
  _gl::functions()\version = 1100
  Global Indexubv._gl::_prot_glIndexubv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIndexubv"
  _gl::functions()\pointer = @Indexubv
  _gl::functions()\version = 1100
  Global InitNames._gl::_prot_glInitNames
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInitNames"
  _gl::functions()\pointer = @InitNames
  _gl::functions()\version = 1100
  Global InterleavedArrays._gl::_prot_glInterleavedArrays
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInterleavedArrays"
  _gl::functions()\pointer = @InterleavedArrays
  _gl::functions()\version = 1100
  Global IsEnabled._gl::_prot_glIsEnabled
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsEnabled"
  _gl::functions()\pointer = @IsEnabled
  _gl::functions()\version = 1100
  Global IsList._gl::_prot_glIsList
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsList"
  _gl::functions()\pointer = @IsList
  _gl::functions()\version = 1100
  Global IsTexture._gl::_prot_glIsTexture
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsTexture"
  _gl::functions()\pointer = @IsTexture
  _gl::functions()\version = 1100
  Global LightModelf._gl::_prot_glLightModelf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightModelf"
  _gl::functions()\pointer = @LightModelf
  _gl::functions()\version = 1100
  Global LightModelfv._gl::_prot_glLightModelfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightModelfv"
  _gl::functions()\pointer = @LightModelfv
  _gl::functions()\version = 1100
  Global LightModeli._gl::_prot_glLightModeli
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightModeli"
  _gl::functions()\pointer = @LightModeli
  _gl::functions()\version = 1100
  Global LightModeliv._gl::_prot_glLightModeliv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightModeliv"
  _gl::functions()\pointer = @LightModeliv
  _gl::functions()\version = 1100
  Global Lightf._gl::_prot_glLightf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightf"
  _gl::functions()\pointer = @Lightf
  _gl::functions()\version = 1100
  Global Lightfv._gl::_prot_glLightfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightfv"
  _gl::functions()\pointer = @Lightfv
  _gl::functions()\version = 1100
  Global Lighti._gl::_prot_glLighti
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLighti"
  _gl::functions()\pointer = @Lighti
  _gl::functions()\version = 1100
  Global Lightiv._gl::_prot_glLightiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightiv"
  _gl::functions()\pointer = @Lightiv
  _gl::functions()\version = 1100
  Global LineStipple._gl::_prot_glLineStipple
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLineStipple"
  _gl::functions()\pointer = @LineStipple
  _gl::functions()\version = 1100
  Global LineWidth._gl::_prot_glLineWidth
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLineWidth"
  _gl::functions()\pointer = @LineWidth
  _gl::functions()\version = 1100
  Global ListBase._gl::_prot_glListBase
  AddElement( _gl::functions() )
  _gl::functions()\name = "glListBase"
  _gl::functions()\pointer = @ListBase
  _gl::functions()\version = 1100
  Global LoadIdentity._gl::_prot_glLoadIdentity
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadIdentity"
  _gl::functions()\pointer = @LoadIdentity
  _gl::functions()\version = 1100
  Global LoadMatrixd._gl::_prot_glLoadMatrixd
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadMatrixd"
  _gl::functions()\pointer = @LoadMatrixd
  _gl::functions()\version = 1100
  Global LoadMatrixf._gl::_prot_glLoadMatrixf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadMatrixf"
  _gl::functions()\pointer = @LoadMatrixf
  _gl::functions()\version = 1100
  Global LoadName._gl::_prot_glLoadName
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadName"
  _gl::functions()\pointer = @LoadName
  _gl::functions()\version = 1100
  Global LogicOp._gl::_prot_glLogicOp
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLogicOp"
  _gl::functions()\pointer = @LogicOp
  _gl::functions()\version = 1100
  Global Map1d._gl::_prot_glMap1d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMap1d"
  _gl::functions()\pointer = @Map1d
  _gl::functions()\version = 1100
  Global Map1f._gl::_prot_glMap1f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMap1f"
  _gl::functions()\pointer = @Map1f
  _gl::functions()\version = 1100
  Global Map2d._gl::_prot_glMap2d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMap2d"
  _gl::functions()\pointer = @Map2d
  _gl::functions()\version = 1100
  Global Map2f._gl::_prot_glMap2f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMap2f"
  _gl::functions()\pointer = @Map2f
  _gl::functions()\version = 1100
  Global MapGrid1d._gl::_prot_glMapGrid1d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapGrid1d"
  _gl::functions()\pointer = @MapGrid1d
  _gl::functions()\version = 1100
  Global MapGrid1f._gl::_prot_glMapGrid1f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapGrid1f"
  _gl::functions()\pointer = @MapGrid1f
  _gl::functions()\version = 1100
  Global MapGrid2d._gl::_prot_glMapGrid2d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapGrid2d"
  _gl::functions()\pointer = @MapGrid2d
  _gl::functions()\version = 1100
  Global MapGrid2f._gl::_prot_glMapGrid2f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapGrid2f"
  _gl::functions()\pointer = @MapGrid2f
  _gl::functions()\version = 1100
  Global Materialf._gl::_prot_glMaterialf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMaterialf"
  _gl::functions()\pointer = @Materialf
  _gl::functions()\version = 1100
  Global Materialfv._gl::_prot_glMaterialfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMaterialfv"
  _gl::functions()\pointer = @Materialfv
  _gl::functions()\version = 1100
  Global Materiali._gl::_prot_glMateriali
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMateriali"
  _gl::functions()\pointer = @Materiali
  _gl::functions()\version = 1100
  Global Materialiv._gl::_prot_glMaterialiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMaterialiv"
  _gl::functions()\pointer = @Materialiv
  _gl::functions()\version = 1100
  Global MatrixMode._gl::_prot_glMatrixMode
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMatrixMode"
  _gl::functions()\pointer = @MatrixMode
  _gl::functions()\version = 1100
  Global MultMatrixd._gl::_prot_glMultMatrixd
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultMatrixd"
  _gl::functions()\pointer = @MultMatrixd
  _gl::functions()\version = 1100
  Global MultMatrixf._gl::_prot_glMultMatrixf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultMatrixf"
  _gl::functions()\pointer = @MultMatrixf
  _gl::functions()\version = 1100
  Global NewList_._gl::_prot_glNewList
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNewList"
  _gl::functions()\pointer = @NewList_
  _gl::functions()\version = 1100
  Global Normal3b._gl::_prot_glNormal3b
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3b"
  _gl::functions()\pointer = @Normal3b
  _gl::functions()\version = 1100
  Global Normal3bv._gl::_prot_glNormal3bv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3bv"
  _gl::functions()\pointer = @Normal3bv
  _gl::functions()\version = 1100
  Global Normal3d._gl::_prot_glNormal3d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3d"
  _gl::functions()\pointer = @Normal3d
  _gl::functions()\version = 1100
  Global Normal3dv._gl::_prot_glNormal3dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3dv"
  _gl::functions()\pointer = @Normal3dv
  _gl::functions()\version = 1100
  Global Normal3f._gl::_prot_glNormal3f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3f"
  _gl::functions()\pointer = @Normal3f
  _gl::functions()\version = 1100
  Global Normal3fv._gl::_prot_glNormal3fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3fv"
  _gl::functions()\pointer = @Normal3fv
  _gl::functions()\version = 1100
  Global Normal3i._gl::_prot_glNormal3i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3i"
  _gl::functions()\pointer = @Normal3i
  _gl::functions()\version = 1100
  Global Normal3iv._gl::_prot_glNormal3iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3iv"
  _gl::functions()\pointer = @Normal3iv
  _gl::functions()\version = 1100
  Global Normal3s._gl::_prot_glNormal3s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3s"
  _gl::functions()\pointer = @Normal3s
  _gl::functions()\version = 1100
  Global Normal3sv._gl::_prot_glNormal3sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3sv"
  _gl::functions()\pointer = @Normal3sv
  _gl::functions()\version = 1100
  Global NormalPointer._gl::_prot_glNormalPointer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormalPointer"
  _gl::functions()\pointer = @NormalPointer
  _gl::functions()\version = 1100
  Global Ortho._gl::_prot_glOrtho
  AddElement( _gl::functions() )
  _gl::functions()\name = "glOrtho"
  _gl::functions()\pointer = @Ortho
  _gl::functions()\version = 1100
  Global PassThrough._gl::_prot_glPassThrough
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPassThrough"
  _gl::functions()\pointer = @PassThrough
  _gl::functions()\version = 1100
  Global PixelMapfv._gl::_prot_glPixelMapfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelMapfv"
  _gl::functions()\pointer = @PixelMapfv
  _gl::functions()\version = 1100
  Global PixelMapuiv._gl::_prot_glPixelMapuiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelMapuiv"
  _gl::functions()\pointer = @PixelMapuiv
  _gl::functions()\version = 1100
  Global PixelMapusv._gl::_prot_glPixelMapusv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelMapusv"
  _gl::functions()\pointer = @PixelMapusv
  _gl::functions()\version = 1100
  Global PixelStoref._gl::_prot_glPixelStoref
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelStoref"
  _gl::functions()\pointer = @PixelStoref
  _gl::functions()\version = 1100
  Global PixelStorei._gl::_prot_glPixelStorei
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelStorei"
  _gl::functions()\pointer = @PixelStorei
  _gl::functions()\version = 1100
  Global PixelTransferf._gl::_prot_glPixelTransferf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelTransferf"
  _gl::functions()\pointer = @PixelTransferf
  _gl::functions()\version = 1100
  Global PixelTransferi._gl::_prot_glPixelTransferi
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelTransferi"
  _gl::functions()\pointer = @PixelTransferi
  _gl::functions()\version = 1100
  Global PixelZoom._gl::_prot_glPixelZoom
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPixelZoom"
  _gl::functions()\pointer = @PixelZoom
  _gl::functions()\version = 1100
  Global PointSize._gl::_prot_glPointSize
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointSize"
  _gl::functions()\pointer = @PointSize
  _gl::functions()\version = 1100
  Global PolygonMode._gl::_prot_glPolygonMode
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPolygonMode"
  _gl::functions()\pointer = @PolygonMode
  _gl::functions()\version = 1100
  Global PolygonOffset._gl::_prot_glPolygonOffset
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPolygonOffset"
  _gl::functions()\pointer = @PolygonOffset
  _gl::functions()\version = 1100
  Global PolygonStipple._gl::_prot_glPolygonStipple
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPolygonStipple"
  _gl::functions()\pointer = @PolygonStipple
  _gl::functions()\version = 1100
  Global PopAttrib._gl::_prot_glPopAttrib
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPopAttrib"
  _gl::functions()\pointer = @PopAttrib
  _gl::functions()\version = 1100
  Global PopClientAttrib._gl::_prot_glPopClientAttrib
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPopClientAttrib"
  _gl::functions()\pointer = @PopClientAttrib
  _gl::functions()\version = 1100
  Global PopMatrix._gl::_prot_glPopMatrix
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPopMatrix"
  _gl::functions()\pointer = @PopMatrix
  _gl::functions()\version = 1100
  Global PopName._gl::_prot_glPopName
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPopName"
  _gl::functions()\pointer = @PopName
  _gl::functions()\version = 1100
  Global PrioritizeTextures._gl::_prot_glPrioritizeTextures
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPrioritizeTextures"
  _gl::functions()\pointer = @PrioritizeTextures
  _gl::functions()\version = 1100
  Global PushAttrib._gl::_prot_glPushAttrib
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPushAttrib"
  _gl::functions()\pointer = @PushAttrib
  _gl::functions()\version = 1100
  Global PushClientAttrib._gl::_prot_glPushClientAttrib
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPushClientAttrib"
  _gl::functions()\pointer = @PushClientAttrib
  _gl::functions()\version = 1100
  Global PushMatrix._gl::_prot_glPushMatrix
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPushMatrix"
  _gl::functions()\pointer = @PushMatrix
  _gl::functions()\version = 1100
  Global PushName._gl::_prot_glPushName
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPushName"
  _gl::functions()\pointer = @PushName
  _gl::functions()\version = 1100
  Global RasterPos2d._gl::_prot_glRasterPos2d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2d"
  _gl::functions()\pointer = @RasterPos2d
  _gl::functions()\version = 1100
  Global RasterPos2dv._gl::_prot_glRasterPos2dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2dv"
  _gl::functions()\pointer = @RasterPos2dv
  _gl::functions()\version = 1100
  Global RasterPos2f._gl::_prot_glRasterPos2f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2f"
  _gl::functions()\pointer = @RasterPos2f
  _gl::functions()\version = 1100
  Global RasterPos2fv._gl::_prot_glRasterPos2fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2fv"
  _gl::functions()\pointer = @RasterPos2fv
  _gl::functions()\version = 1100
  Global RasterPos2i._gl::_prot_glRasterPos2i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2i"
  _gl::functions()\pointer = @RasterPos2i
  _gl::functions()\version = 1100
  Global RasterPos2iv._gl::_prot_glRasterPos2iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2iv"
  _gl::functions()\pointer = @RasterPos2iv
  _gl::functions()\version = 1100
  Global RasterPos2s._gl::_prot_glRasterPos2s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2s"
  _gl::functions()\pointer = @RasterPos2s
  _gl::functions()\version = 1100
  Global RasterPos2sv._gl::_prot_glRasterPos2sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos2sv"
  _gl::functions()\pointer = @RasterPos2sv
  _gl::functions()\version = 1100
  Global RasterPos3d._gl::_prot_glRasterPos3d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3d"
  _gl::functions()\pointer = @RasterPos3d
  _gl::functions()\version = 1100
  Global RasterPos3dv._gl::_prot_glRasterPos3dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3dv"
  _gl::functions()\pointer = @RasterPos3dv
  _gl::functions()\version = 1100
  Global RasterPos3f._gl::_prot_glRasterPos3f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3f"
  _gl::functions()\pointer = @RasterPos3f
  _gl::functions()\version = 1100
  Global RasterPos3fv._gl::_prot_glRasterPos3fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3fv"
  _gl::functions()\pointer = @RasterPos3fv
  _gl::functions()\version = 1100
  Global RasterPos3i._gl::_prot_glRasterPos3i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3i"
  _gl::functions()\pointer = @RasterPos3i
  _gl::functions()\version = 1100
  Global RasterPos3iv._gl::_prot_glRasterPos3iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3iv"
  _gl::functions()\pointer = @RasterPos3iv
  _gl::functions()\version = 1100
  Global RasterPos3s._gl::_prot_glRasterPos3s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3s"
  _gl::functions()\pointer = @RasterPos3s
  _gl::functions()\version = 1100
  Global RasterPos3sv._gl::_prot_glRasterPos3sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos3sv"
  _gl::functions()\pointer = @RasterPos3sv
  _gl::functions()\version = 1100
  Global RasterPos4d._gl::_prot_glRasterPos4d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4d"
  _gl::functions()\pointer = @RasterPos4d
  _gl::functions()\version = 1100
  Global RasterPos4dv._gl::_prot_glRasterPos4dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4dv"
  _gl::functions()\pointer = @RasterPos4dv
  _gl::functions()\version = 1100
  Global RasterPos4f._gl::_prot_glRasterPos4f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4f"
  _gl::functions()\pointer = @RasterPos4f
  _gl::functions()\version = 1100
  Global RasterPos4fv._gl::_prot_glRasterPos4fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4fv"
  _gl::functions()\pointer = @RasterPos4fv
  _gl::functions()\version = 1100
  Global RasterPos4i._gl::_prot_glRasterPos4i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4i"
  _gl::functions()\pointer = @RasterPos4i
  _gl::functions()\version = 1100
  Global RasterPos4iv._gl::_prot_glRasterPos4iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4iv"
  _gl::functions()\pointer = @RasterPos4iv
  _gl::functions()\version = 1100
  Global RasterPos4s._gl::_prot_glRasterPos4s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4s"
  _gl::functions()\pointer = @RasterPos4s
  _gl::functions()\version = 1100
  Global RasterPos4sv._gl::_prot_glRasterPos4sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRasterPos4sv"
  _gl::functions()\pointer = @RasterPos4sv
  _gl::functions()\version = 1100
  Global ReadBuffer._gl::_prot_glReadBuffer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glReadBuffer"
  _gl::functions()\pointer = @ReadBuffer
  _gl::functions()\version = 1100
  Global ReadPixels._gl::_prot_glReadPixels
  AddElement( _gl::functions() )
  _gl::functions()\name = "glReadPixels"
  _gl::functions()\pointer = @ReadPixels
  _gl::functions()\version = 1100
  Global Rectd._gl::_prot_glRectd
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRectd"
  _gl::functions()\pointer = @Rectd
  _gl::functions()\version = 1100
  Global Rectdv._gl::_prot_glRectdv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRectdv"
  _gl::functions()\pointer = @Rectdv
  _gl::functions()\version = 1100
  Global Rectf._gl::_prot_glRectf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRectf"
  _gl::functions()\pointer = @Rectf
  _gl::functions()\version = 1100
  Global Rectfv._gl::_prot_glRectfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRectfv"
  _gl::functions()\pointer = @Rectfv
  _gl::functions()\version = 1100
  Global Recti._gl::_prot_glRecti
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRecti"
  _gl::functions()\pointer = @Recti
  _gl::functions()\version = 1100
  Global Rectiv._gl::_prot_glRectiv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRectiv"
  _gl::functions()\pointer = @Rectiv
  _gl::functions()\version = 1100
  Global Rects._gl::_prot_glRects
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRects"
  _gl::functions()\pointer = @Rects
  _gl::functions()\version = 1100
  Global Rectsv._gl::_prot_glRectsv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRectsv"
  _gl::functions()\pointer = @Rectsv
  _gl::functions()\version = 1100
  Global RenderMode._gl::_prot_glRenderMode
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRenderMode"
  _gl::functions()\pointer = @RenderMode
  _gl::functions()\version = 1100
  Global Rotated._gl::_prot_glRotated
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRotated"
  _gl::functions()\pointer = @Rotated
  _gl::functions()\version = 1100
  Global Rotatef._gl::_prot_glRotatef
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRotatef"
  _gl::functions()\pointer = @Rotatef
  _gl::functions()\version = 1100
  Global Scaled._gl::_prot_glScaled
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScaled"
  _gl::functions()\pointer = @Scaled
  _gl::functions()\version = 1100
  Global Scalef._gl::_prot_glScalef
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScalef"
  _gl::functions()\pointer = @Scalef
  _gl::functions()\version = 1100
  Global Scissor._gl::_prot_glScissor
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScissor"
  _gl::functions()\pointer = @Scissor
  _gl::functions()\version = 1100
  Global SelectBuffer._gl::_prot_glSelectBuffer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSelectBuffer"
  _gl::functions()\pointer = @SelectBuffer
  _gl::functions()\version = 1100
  Global ShadeModel._gl::_prot_glShadeModel
  AddElement( _gl::functions() )
  _gl::functions()\name = "glShadeModel"
  _gl::functions()\pointer = @ShadeModel
  _gl::functions()\version = 1100
  Global StencilFunc._gl::_prot_glStencilFunc
  AddElement( _gl::functions() )
  _gl::functions()\name = "glStencilFunc"
  _gl::functions()\pointer = @StencilFunc
  _gl::functions()\version = 1100
  Global StencilMask._gl::_prot_glStencilMask
  AddElement( _gl::functions() )
  _gl::functions()\name = "glStencilMask"
  _gl::functions()\pointer = @StencilMask
  _gl::functions()\version = 1100
  Global StencilOp._gl::_prot_glStencilOp
  AddElement( _gl::functions() )
  _gl::functions()\name = "glStencilOp"
  _gl::functions()\pointer = @StencilOp
  _gl::functions()\version = 1100
  Global TexCoord1d._gl::_prot_glTexCoord1d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1d"
  _gl::functions()\pointer = @TexCoord1d
  _gl::functions()\version = 1100
  Global TexCoord1dv._gl::_prot_glTexCoord1dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1dv"
  _gl::functions()\pointer = @TexCoord1dv
  _gl::functions()\version = 1100
  Global TexCoord1f._gl::_prot_glTexCoord1f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1f"
  _gl::functions()\pointer = @TexCoord1f
  _gl::functions()\version = 1100
  Global TexCoord1fv._gl::_prot_glTexCoord1fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1fv"
  _gl::functions()\pointer = @TexCoord1fv
  _gl::functions()\version = 1100
  Global TexCoord1i._gl::_prot_glTexCoord1i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1i"
  _gl::functions()\pointer = @TexCoord1i
  _gl::functions()\version = 1100
  Global TexCoord1iv._gl::_prot_glTexCoord1iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1iv"
  _gl::functions()\pointer = @TexCoord1iv
  _gl::functions()\version = 1100
  Global TexCoord1s._gl::_prot_glTexCoord1s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1s"
  _gl::functions()\pointer = @TexCoord1s
  _gl::functions()\version = 1100
  Global TexCoord1sv._gl::_prot_glTexCoord1sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord1sv"
  _gl::functions()\pointer = @TexCoord1sv
  _gl::functions()\version = 1100
  Global TexCoord2d._gl::_prot_glTexCoord2d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2d"
  _gl::functions()\pointer = @TexCoord2d
  _gl::functions()\version = 1100
  Global TexCoord2dv._gl::_prot_glTexCoord2dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2dv"
  _gl::functions()\pointer = @TexCoord2dv
  _gl::functions()\version = 1100
  Global TexCoord2f._gl::_prot_glTexCoord2f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2f"
  _gl::functions()\pointer = @TexCoord2f
  _gl::functions()\version = 1100
  Global TexCoord2fv._gl::_prot_glTexCoord2fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2fv"
  _gl::functions()\pointer = @TexCoord2fv
  _gl::functions()\version = 1100
  Global TexCoord2i._gl::_prot_glTexCoord2i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2i"
  _gl::functions()\pointer = @TexCoord2i
  _gl::functions()\version = 1100
  Global TexCoord2iv._gl::_prot_glTexCoord2iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2iv"
  _gl::functions()\pointer = @TexCoord2iv
  _gl::functions()\version = 1100
  Global TexCoord2s._gl::_prot_glTexCoord2s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2s"
  _gl::functions()\pointer = @TexCoord2s
  _gl::functions()\version = 1100
  Global TexCoord2sv._gl::_prot_glTexCoord2sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord2sv"
  _gl::functions()\pointer = @TexCoord2sv
  _gl::functions()\version = 1100
  Global TexCoord3d._gl::_prot_glTexCoord3d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3d"
  _gl::functions()\pointer = @TexCoord3d
  _gl::functions()\version = 1100
  Global TexCoord3dv._gl::_prot_glTexCoord3dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3dv"
  _gl::functions()\pointer = @TexCoord3dv
  _gl::functions()\version = 1100
  Global TexCoord3f._gl::_prot_glTexCoord3f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3f"
  _gl::functions()\pointer = @TexCoord3f
  _gl::functions()\version = 1100
  Global TexCoord3fv._gl::_prot_glTexCoord3fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3fv"
  _gl::functions()\pointer = @TexCoord3fv
  _gl::functions()\version = 1100
  Global TexCoord3i._gl::_prot_glTexCoord3i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3i"
  _gl::functions()\pointer = @TexCoord3i
  _gl::functions()\version = 1100
  Global TexCoord3iv._gl::_prot_glTexCoord3iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3iv"
  _gl::functions()\pointer = @TexCoord3iv
  _gl::functions()\version = 1100
  Global TexCoord3s._gl::_prot_glTexCoord3s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3s"
  _gl::functions()\pointer = @TexCoord3s
  _gl::functions()\version = 1100
  Global TexCoord3sv._gl::_prot_glTexCoord3sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord3sv"
  _gl::functions()\pointer = @TexCoord3sv
  _gl::functions()\version = 1100
  Global TexCoord4d._gl::_prot_glTexCoord4d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4d"
  _gl::functions()\pointer = @TexCoord4d
  _gl::functions()\version = 1100
  Global TexCoord4dv._gl::_prot_glTexCoord4dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4dv"
  _gl::functions()\pointer = @TexCoord4dv
  _gl::functions()\version = 1100
  Global TexCoord4f._gl::_prot_glTexCoord4f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4f"
  _gl::functions()\pointer = @TexCoord4f
  _gl::functions()\version = 1100
  Global TexCoord4fv._gl::_prot_glTexCoord4fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4fv"
  _gl::functions()\pointer = @TexCoord4fv
  _gl::functions()\version = 1100
  Global TexCoord4i._gl::_prot_glTexCoord4i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4i"
  _gl::functions()\pointer = @TexCoord4i
  _gl::functions()\version = 1100
  Global TexCoord4iv._gl::_prot_glTexCoord4iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4iv"
  _gl::functions()\pointer = @TexCoord4iv
  _gl::functions()\version = 1100
  Global TexCoord4s._gl::_prot_glTexCoord4s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4s"
  _gl::functions()\pointer = @TexCoord4s
  _gl::functions()\version = 1100
  Global TexCoord4sv._gl::_prot_glTexCoord4sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoord4sv"
  _gl::functions()\pointer = @TexCoord4sv
  _gl::functions()\version = 1100
  Global TexCoordPointer._gl::_prot_glTexCoordPointer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordPointer"
  _gl::functions()\pointer = @TexCoordPointer
  _gl::functions()\version = 1100
  Global TexEnvf._gl::_prot_glTexEnvf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexEnvf"
  _gl::functions()\pointer = @TexEnvf
  _gl::functions()\version = 1100
  Global TexEnvfv._gl::_prot_glTexEnvfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexEnvfv"
  _gl::functions()\pointer = @TexEnvfv
  _gl::functions()\version = 1100
  Global TexEnvi._gl::_prot_glTexEnvi
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexEnvi"
  _gl::functions()\pointer = @TexEnvi
  _gl::functions()\version = 1100
  Global TexEnviv._gl::_prot_glTexEnviv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexEnviv"
  _gl::functions()\pointer = @TexEnviv
  _gl::functions()\version = 1100
  Global TexGend._gl::_prot_glTexGend
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexGend"
  _gl::functions()\pointer = @TexGend
  _gl::functions()\version = 1100
  Global TexGendv._gl::_prot_glTexGendv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexGendv"
  _gl::functions()\pointer = @TexGendv
  _gl::functions()\version = 1100
  Global TexGenf._gl::_prot_glTexGenf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexGenf"
  _gl::functions()\pointer = @TexGenf
  _gl::functions()\version = 1100
  Global TexGenfv._gl::_prot_glTexGenfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexGenfv"
  _gl::functions()\pointer = @TexGenfv
  _gl::functions()\version = 1100
  Global TexGeni._gl::_prot_glTexGeni
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexGeni"
  _gl::functions()\pointer = @TexGeni
  _gl::functions()\version = 1100
  Global TexGeniv._gl::_prot_glTexGeniv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexGeniv"
  _gl::functions()\pointer = @TexGeniv
  _gl::functions()\version = 1100
  Global TexImage1D._gl::_prot_glTexImage1D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexImage1D"
  _gl::functions()\pointer = @TexImage1D
  _gl::functions()\version = 1100
  Global TexImage2D._gl::_prot_glTexImage2D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexImage2D"
  _gl::functions()\pointer = @TexImage2D
  _gl::functions()\version = 1100
  Global TexParameterf._gl::_prot_glTexParameterf
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameterf"
  _gl::functions()\pointer = @TexParameterf
  _gl::functions()\version = 1100
  Global TexParameterfv._gl::_prot_glTexParameterfv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameterfv"
  _gl::functions()\pointer = @TexParameterfv
  _gl::functions()\version = 1100
  Global TexParameteri._gl::_prot_glTexParameteri
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameteri"
  _gl::functions()\pointer = @TexParameteri
  _gl::functions()\version = 1100
  Global TexParameteriv._gl::_prot_glTexParameteriv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameteriv"
  _gl::functions()\pointer = @TexParameteriv
  _gl::functions()\version = 1100
  Global TexSubImage1D._gl::_prot_glTexSubImage1D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexSubImage1D"
  _gl::functions()\pointer = @TexSubImage1D
  _gl::functions()\version = 1100
  Global TexSubImage2D._gl::_prot_glTexSubImage2D
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexSubImage2D"
  _gl::functions()\pointer = @TexSubImage2D
  _gl::functions()\version = 1100
  Global Translated._gl::_prot_glTranslated
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTranslated"
  _gl::functions()\pointer = @Translated
  _gl::functions()\version = 1100
  Global Translatef._gl::_prot_glTranslatef
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTranslatef"
  _gl::functions()\pointer = @Translatef
  _gl::functions()\version = 1100
  Global Vertex2d._gl::_prot_glVertex2d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2d"
  _gl::functions()\pointer = @Vertex2d
  _gl::functions()\version = 1100
  Global Vertex2dv._gl::_prot_glVertex2dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2dv"
  _gl::functions()\pointer = @Vertex2dv
  _gl::functions()\version = 1100
  Global Vertex2f._gl::_prot_glVertex2f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2f"
  _gl::functions()\pointer = @Vertex2f
  _gl::functions()\version = 1100
  Global Vertex2fv._gl::_prot_glVertex2fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2fv"
  _gl::functions()\pointer = @Vertex2fv
  _gl::functions()\version = 1100
  Global Vertex2i._gl::_prot_glVertex2i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2i"
  _gl::functions()\pointer = @Vertex2i
  _gl::functions()\version = 1100
  Global Vertex2iv._gl::_prot_glVertex2iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2iv"
  _gl::functions()\pointer = @Vertex2iv
  _gl::functions()\version = 1100
  Global Vertex2s._gl::_prot_glVertex2s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2s"
  _gl::functions()\pointer = @Vertex2s
  _gl::functions()\version = 1100
  Global Vertex2sv._gl::_prot_glVertex2sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex2sv"
  _gl::functions()\pointer = @Vertex2sv
  _gl::functions()\version = 1100
  Global Vertex3d._gl::_prot_glVertex3d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3d"
  _gl::functions()\pointer = @Vertex3d
  _gl::functions()\version = 1100
  Global Vertex3dv._gl::_prot_glVertex3dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3dv"
  _gl::functions()\pointer = @Vertex3dv
  _gl::functions()\version = 1100
  Global Vertex3f._gl::_prot_glVertex3f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3f"
  _gl::functions()\pointer = @Vertex3f
  _gl::functions()\version = 1100
  Global Vertex3fv._gl::_prot_glVertex3fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3fv"
  _gl::functions()\pointer = @Vertex3fv
  _gl::functions()\version = 1100
  Global Vertex3i._gl::_prot_glVertex3i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3i"
  _gl::functions()\pointer = @Vertex3i
  _gl::functions()\version = 1100
  Global Vertex3iv._gl::_prot_glVertex3iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3iv"
  _gl::functions()\pointer = @Vertex3iv
  _gl::functions()\version = 1100
  Global Vertex3s._gl::_prot_glVertex3s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3s"
  _gl::functions()\pointer = @Vertex3s
  _gl::functions()\version = 1100
  Global Vertex3sv._gl::_prot_glVertex3sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex3sv"
  _gl::functions()\pointer = @Vertex3sv
  _gl::functions()\version = 1100
  Global Vertex4d._gl::_prot_glVertex4d
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4d"
  _gl::functions()\pointer = @Vertex4d
  _gl::functions()\version = 1100
  Global Vertex4dv._gl::_prot_glVertex4dv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4dv"
  _gl::functions()\pointer = @Vertex4dv
  _gl::functions()\version = 1100
  Global Vertex4f._gl::_prot_glVertex4f
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4f"
  _gl::functions()\pointer = @Vertex4f
  _gl::functions()\version = 1100
  Global Vertex4fv._gl::_prot_glVertex4fv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4fv"
  _gl::functions()\pointer = @Vertex4fv
  _gl::functions()\version = 1100
  Global Vertex4i._gl::_prot_glVertex4i
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4i"
  _gl::functions()\pointer = @Vertex4i
  _gl::functions()\version = 1100
  Global Vertex4iv._gl::_prot_glVertex4iv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4iv"
  _gl::functions()\pointer = @Vertex4iv
  _gl::functions()\version = 1100
  Global Vertex4s._gl::_prot_glVertex4s
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4s"
  _gl::functions()\pointer = @Vertex4s
  _gl::functions()\version = 1100
  Global Vertex4sv._gl::_prot_glVertex4sv
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertex4sv"
  _gl::functions()\pointer = @Vertex4sv
  _gl::functions()\version = 1100
  Global VertexPointer._gl::_prot_glVertexPointer
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexPointer"
  _gl::functions()\pointer = @VertexPointer
  _gl::functions()\version = 1100
  Global Viewport._gl::_prot_glViewport
  AddElement( _gl::functions() )
  _gl::functions()\name = "glViewport"
  _gl::functions()\pointer = @Viewport
  _gl::functions()\version = 1100
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,2,0)
  Global CopyTexSubImage3D._gl::PFNGLCOPYTEXSUBIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTexSubImage3D"
  _gl::functions()\pointer = @CopyTexSubImage3D
  _gl::functions()\version = 1200
  Global DrawRangeElements._gl::PFNGLDRAWRANGEELEMENTSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawRangeElements"
  _gl::functions()\pointer = @DrawRangeElements
  _gl::functions()\version = 1200
  Global TexImage3D._gl::PFNGLTEXIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexImage3D"
  _gl::functions()\pointer = @TexImage3D
  _gl::functions()\version = 1200
  Global TexSubImage3D._gl::PFNGLTEXSUBIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexSubImage3D"
  _gl::functions()\pointer = @TexSubImage3D
  _gl::functions()\version = 1200
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,2,1)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,3,0)
  Global ActiveTexture._gl::PFNGLACTIVETEXTUREPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glActiveTexture"
  _gl::functions()\pointer = @ActiveTexture
  _gl::functions()\version = 1300
  Global ClientActiveTexture._gl::PFNGLCLIENTACTIVETEXTUREPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClientActiveTexture"
  _gl::functions()\pointer = @ClientActiveTexture
  _gl::functions()\version = 1300
  Global CompressedTexImage1D._gl::PFNGLCOMPRESSEDTEXIMAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTexImage1D"
  _gl::functions()\pointer = @CompressedTexImage1D
  _gl::functions()\version = 1300
  Global CompressedTexImage2D._gl::PFNGLCOMPRESSEDTEXIMAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTexImage2D"
  _gl::functions()\pointer = @CompressedTexImage2D
  _gl::functions()\version = 1300
  Global CompressedTexImage3D._gl::PFNGLCOMPRESSEDTEXIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTexImage3D"
  _gl::functions()\pointer = @CompressedTexImage3D
  _gl::functions()\version = 1300
  Global CompressedTexSubImage1D._gl::PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTexSubImage1D"
  _gl::functions()\pointer = @CompressedTexSubImage1D
  _gl::functions()\version = 1300
  Global CompressedTexSubImage2D._gl::PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTexSubImage2D"
  _gl::functions()\pointer = @CompressedTexSubImage2D
  _gl::functions()\version = 1300
  Global CompressedTexSubImage3D._gl::PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTexSubImage3D"
  _gl::functions()\pointer = @CompressedTexSubImage3D
  _gl::functions()\version = 1300
  Global GetCompressedTexImage._gl::PFNGLGETCOMPRESSEDTEXIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetCompressedTexImage"
  _gl::functions()\pointer = @GetCompressedTexImage
  _gl::functions()\version = 1300
  Global LoadTransposeMatrixd._gl::PFNGLLOADTRANSPOSEMATRIXDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadTransposeMatrixd"
  _gl::functions()\pointer = @LoadTransposeMatrixd
  _gl::functions()\version = 1300
  Global LoadTransposeMatrixf._gl::PFNGLLOADTRANSPOSEMATRIXFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadTransposeMatrixf"
  _gl::functions()\pointer = @LoadTransposeMatrixf
  _gl::functions()\version = 1300
  Global MultTransposeMatrixd._gl::PFNGLMULTTRANSPOSEMATRIXDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultTransposeMatrixd"
  _gl::functions()\pointer = @MultTransposeMatrixd
  _gl::functions()\version = 1300
  Global MultTransposeMatrixf._gl::PFNGLMULTTRANSPOSEMATRIXFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultTransposeMatrixf"
  _gl::functions()\pointer = @MultTransposeMatrixf
  _gl::functions()\version = 1300
  Global MultiTexCoord1d._gl::PFNGLMULTITEXCOORD1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1d"
  _gl::functions()\pointer = @MultiTexCoord1d
  _gl::functions()\version = 1300
  Global MultiTexCoord1dv._gl::PFNGLMULTITEXCOORD1DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1dv"
  _gl::functions()\pointer = @MultiTexCoord1dv
  _gl::functions()\version = 1300
  Global MultiTexCoord1f._gl::PFNGLMULTITEXCOORD1FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1f"
  _gl::functions()\pointer = @MultiTexCoord1f
  _gl::functions()\version = 1300
  Global MultiTexCoord1fv._gl::PFNGLMULTITEXCOORD1FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1fv"
  _gl::functions()\pointer = @MultiTexCoord1fv
  _gl::functions()\version = 1300
  Global MultiTexCoord1i._gl::PFNGLMULTITEXCOORD1IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1i"
  _gl::functions()\pointer = @MultiTexCoord1i
  _gl::functions()\version = 1300
  Global MultiTexCoord1iv._gl::PFNGLMULTITEXCOORD1IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1iv"
  _gl::functions()\pointer = @MultiTexCoord1iv
  _gl::functions()\version = 1300
  Global MultiTexCoord1s._gl::PFNGLMULTITEXCOORD1SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1s"
  _gl::functions()\pointer = @MultiTexCoord1s
  _gl::functions()\version = 1300
  Global MultiTexCoord1sv._gl::PFNGLMULTITEXCOORD1SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord1sv"
  _gl::functions()\pointer = @MultiTexCoord1sv
  _gl::functions()\version = 1300
  Global MultiTexCoord2d._gl::PFNGLMULTITEXCOORD2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2d"
  _gl::functions()\pointer = @MultiTexCoord2d
  _gl::functions()\version = 1300
  Global MultiTexCoord2dv._gl::PFNGLMULTITEXCOORD2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2dv"
  _gl::functions()\pointer = @MultiTexCoord2dv
  _gl::functions()\version = 1300
  Global MultiTexCoord2f._gl::PFNGLMULTITEXCOORD2FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2f"
  _gl::functions()\pointer = @MultiTexCoord2f
  _gl::functions()\version = 1300
  Global MultiTexCoord2fv._gl::PFNGLMULTITEXCOORD2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2fv"
  _gl::functions()\pointer = @MultiTexCoord2fv
  _gl::functions()\version = 1300
  Global MultiTexCoord2i._gl::PFNGLMULTITEXCOORD2IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2i"
  _gl::functions()\pointer = @MultiTexCoord2i
  _gl::functions()\version = 1300
  Global MultiTexCoord2iv._gl::PFNGLMULTITEXCOORD2IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2iv"
  _gl::functions()\pointer = @MultiTexCoord2iv
  _gl::functions()\version = 1300
  Global MultiTexCoord2s._gl::PFNGLMULTITEXCOORD2SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2s"
  _gl::functions()\pointer = @MultiTexCoord2s
  _gl::functions()\version = 1300
  Global MultiTexCoord2sv._gl::PFNGLMULTITEXCOORD2SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord2sv"
  _gl::functions()\pointer = @MultiTexCoord2sv
  _gl::functions()\version = 1300
  Global MultiTexCoord3d._gl::PFNGLMULTITEXCOORD3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3d"
  _gl::functions()\pointer = @MultiTexCoord3d
  _gl::functions()\version = 1300
  Global MultiTexCoord3dv._gl::PFNGLMULTITEXCOORD3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3dv"
  _gl::functions()\pointer = @MultiTexCoord3dv
  _gl::functions()\version = 1300
  Global MultiTexCoord3f._gl::PFNGLMULTITEXCOORD3FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3f"
  _gl::functions()\pointer = @MultiTexCoord3f
  _gl::functions()\version = 1300
  Global MultiTexCoord3fv._gl::PFNGLMULTITEXCOORD3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3fv"
  _gl::functions()\pointer = @MultiTexCoord3fv
  _gl::functions()\version = 1300
  Global MultiTexCoord3i._gl::PFNGLMULTITEXCOORD3IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3i"
  _gl::functions()\pointer = @MultiTexCoord3i
  _gl::functions()\version = 1300
  Global MultiTexCoord3iv._gl::PFNGLMULTITEXCOORD3IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3iv"
  _gl::functions()\pointer = @MultiTexCoord3iv
  _gl::functions()\version = 1300
  Global MultiTexCoord3s._gl::PFNGLMULTITEXCOORD3SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3s"
  _gl::functions()\pointer = @MultiTexCoord3s
  _gl::functions()\version = 1300
  Global MultiTexCoord3sv._gl::PFNGLMULTITEXCOORD3SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord3sv"
  _gl::functions()\pointer = @MultiTexCoord3sv
  _gl::functions()\version = 1300
  Global MultiTexCoord4d._gl::PFNGLMULTITEXCOORD4DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4d"
  _gl::functions()\pointer = @MultiTexCoord4d
  _gl::functions()\version = 1300
  Global MultiTexCoord4dv._gl::PFNGLMULTITEXCOORD4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4dv"
  _gl::functions()\pointer = @MultiTexCoord4dv
  _gl::functions()\version = 1300
  Global MultiTexCoord4f._gl::PFNGLMULTITEXCOORD4FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4f"
  _gl::functions()\pointer = @MultiTexCoord4f
  _gl::functions()\version = 1300
  Global MultiTexCoord4fv._gl::PFNGLMULTITEXCOORD4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4fv"
  _gl::functions()\pointer = @MultiTexCoord4fv
  _gl::functions()\version = 1300
  Global MultiTexCoord4i._gl::PFNGLMULTITEXCOORD4IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4i"
  _gl::functions()\pointer = @MultiTexCoord4i
  _gl::functions()\version = 1300
  Global MultiTexCoord4iv._gl::PFNGLMULTITEXCOORD4IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4iv"
  _gl::functions()\pointer = @MultiTexCoord4iv
  _gl::functions()\version = 1300
  Global MultiTexCoord4s._gl::PFNGLMULTITEXCOORD4SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4s"
  _gl::functions()\pointer = @MultiTexCoord4s
  _gl::functions()\version = 1300
  Global MultiTexCoord4sv._gl::PFNGLMULTITEXCOORD4SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4sv"
  _gl::functions()\pointer = @MultiTexCoord4sv
  _gl::functions()\version = 1300
  Global SampleCoverage._gl::PFNGLSAMPLECOVERAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSampleCoverage"
  _gl::functions()\pointer = @SampleCoverage
  _gl::functions()\version = 1300
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,4,0)
  Global BlendColor._gl::PFNGLBLENDCOLORPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendColor"
  _gl::functions()\pointer = @BlendColor
  _gl::functions()\version = 1400
  Global BlendEquation._gl::PFNGLBLENDEQUATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendEquation"
  _gl::functions()\pointer = @BlendEquation
  _gl::functions()\version = 1400
  Global BlendFuncSeparate._gl::PFNGLBLENDFUNCSEPARATEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendFuncSeparate"
  _gl::functions()\pointer = @BlendFuncSeparate
  _gl::functions()\version = 1400
  Global FogCoordPointer._gl::PFNGLFOGCOORDPOINTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogCoordPointer"
  _gl::functions()\pointer = @FogCoordPointer
  _gl::functions()\version = 1400
  Global FogCoordd._gl::PFNGLFOGCOORDDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogCoordd"
  _gl::functions()\pointer = @FogCoordd
  _gl::functions()\version = 1400
  Global FogCoorddv._gl::PFNGLFOGCOORDDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogCoorddv"
  _gl::functions()\pointer = @FogCoorddv
  _gl::functions()\version = 1400
  Global FogCoordf._gl::PFNGLFOGCOORDFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogCoordf"
  _gl::functions()\pointer = @FogCoordf
  _gl::functions()\version = 1400
  Global FogCoordfv._gl::PFNGLFOGCOORDFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogCoordfv"
  _gl::functions()\pointer = @FogCoordfv
  _gl::functions()\version = 1400
  Global MultiDrawArrays._gl::PFNGLMULTIDRAWARRAYSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawArrays"
  _gl::functions()\pointer = @MultiDrawArrays
  _gl::functions()\version = 1400
  Global MultiDrawElements._gl::PFNGLMULTIDRAWELEMENTSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawElements"
  _gl::functions()\pointer = @MultiDrawElements
  _gl::functions()\version = 1400
  Global PointParameterf._gl::PFNGLPOINTPARAMETERFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointParameterf"
  _gl::functions()\pointer = @PointParameterf
  _gl::functions()\version = 1400
  Global PointParameterfv._gl::PFNGLPOINTPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointParameterfv"
  _gl::functions()\pointer = @PointParameterfv
  _gl::functions()\version = 1400
  Global PointParameteri._gl::PFNGLPOINTPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointParameteri"
  _gl::functions()\pointer = @PointParameteri
  _gl::functions()\version = 1400
  Global PointParameteriv._gl::PFNGLPOINTPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointParameteriv"
  _gl::functions()\pointer = @PointParameteriv
  _gl::functions()\version = 1400
  Global SecondaryColor3b._gl::PFNGLSECONDARYCOLOR3BPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3b"
  _gl::functions()\pointer = @SecondaryColor3b
  _gl::functions()\version = 1400
  Global SecondaryColor3bv._gl::PFNGLSECONDARYCOLOR3BVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3bv"
  _gl::functions()\pointer = @SecondaryColor3bv
  _gl::functions()\version = 1400
  Global SecondaryColor3d._gl::PFNGLSECONDARYCOLOR3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3d"
  _gl::functions()\pointer = @SecondaryColor3d
  _gl::functions()\version = 1400
  Global SecondaryColor3dv._gl::PFNGLSECONDARYCOLOR3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3dv"
  _gl::functions()\pointer = @SecondaryColor3dv
  _gl::functions()\version = 1400
  Global SecondaryColor3f._gl::PFNGLSECONDARYCOLOR3FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3f"
  _gl::functions()\pointer = @SecondaryColor3f
  _gl::functions()\version = 1400
  Global SecondaryColor3fv._gl::PFNGLSECONDARYCOLOR3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3fv"
  _gl::functions()\pointer = @SecondaryColor3fv
  _gl::functions()\version = 1400
  Global SecondaryColor3i._gl::PFNGLSECONDARYCOLOR3IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3i"
  _gl::functions()\pointer = @SecondaryColor3i
  _gl::functions()\version = 1400
  Global SecondaryColor3iv._gl::PFNGLSECONDARYCOLOR3IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3iv"
  _gl::functions()\pointer = @SecondaryColor3iv
  _gl::functions()\version = 1400
  Global SecondaryColor3s._gl::PFNGLSECONDARYCOLOR3SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3s"
  _gl::functions()\pointer = @SecondaryColor3s
  _gl::functions()\version = 1400
  Global SecondaryColor3sv._gl::PFNGLSECONDARYCOLOR3SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3sv"
  _gl::functions()\pointer = @SecondaryColor3sv
  _gl::functions()\version = 1400
  Global SecondaryColor3ub._gl::PFNGLSECONDARYCOLOR3UBPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3ub"
  _gl::functions()\pointer = @SecondaryColor3ub
  _gl::functions()\version = 1400
  Global SecondaryColor3ubv._gl::PFNGLSECONDARYCOLOR3UBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3ubv"
  _gl::functions()\pointer = @SecondaryColor3ubv
  _gl::functions()\version = 1400
  Global SecondaryColor3ui._gl::PFNGLSECONDARYCOLOR3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3ui"
  _gl::functions()\pointer = @SecondaryColor3ui
  _gl::functions()\version = 1400
  Global SecondaryColor3uiv._gl::PFNGLSECONDARYCOLOR3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3uiv"
  _gl::functions()\pointer = @SecondaryColor3uiv
  _gl::functions()\version = 1400
  Global SecondaryColor3us._gl::PFNGLSECONDARYCOLOR3USPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3us"
  _gl::functions()\pointer = @SecondaryColor3us
  _gl::functions()\version = 1400
  Global SecondaryColor3usv._gl::PFNGLSECONDARYCOLOR3USVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColor3usv"
  _gl::functions()\pointer = @SecondaryColor3usv
  _gl::functions()\version = 1400
  Global SecondaryColorPointer._gl::PFNGLSECONDARYCOLORPOINTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColorPointer"
  _gl::functions()\pointer = @SecondaryColorPointer
  _gl::functions()\version = 1400
  Global WindowPos2d._gl::PFNGLWINDOWPOS2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2d"
  _gl::functions()\pointer = @WindowPos2d
  _gl::functions()\version = 1400
  Global WindowPos2dv._gl::PFNGLWINDOWPOS2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2dv"
  _gl::functions()\pointer = @WindowPos2dv
  _gl::functions()\version = 1400
  Global WindowPos2f._gl::PFNGLWINDOWPOS2FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2f"
  _gl::functions()\pointer = @WindowPos2f
  _gl::functions()\version = 1400
  Global WindowPos2fv._gl::PFNGLWINDOWPOS2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2fv"
  _gl::functions()\pointer = @WindowPos2fv
  _gl::functions()\version = 1400
  Global WindowPos2i._gl::PFNGLWINDOWPOS2IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2i"
  _gl::functions()\pointer = @WindowPos2i
  _gl::functions()\version = 1400
  Global WindowPos2iv._gl::PFNGLWINDOWPOS2IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2iv"
  _gl::functions()\pointer = @WindowPos2iv
  _gl::functions()\version = 1400
  Global WindowPos2s._gl::PFNGLWINDOWPOS2SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2s"
  _gl::functions()\pointer = @WindowPos2s
  _gl::functions()\version = 1400
  Global WindowPos2sv._gl::PFNGLWINDOWPOS2SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos2sv"
  _gl::functions()\pointer = @WindowPos2sv
  _gl::functions()\version = 1400
  Global WindowPos3d._gl::PFNGLWINDOWPOS3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3d"
  _gl::functions()\pointer = @WindowPos3d
  _gl::functions()\version = 1400
  Global WindowPos3dv._gl::PFNGLWINDOWPOS3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3dv"
  _gl::functions()\pointer = @WindowPos3dv
  _gl::functions()\version = 1400
  Global WindowPos3f._gl::PFNGLWINDOWPOS3FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3f"
  _gl::functions()\pointer = @WindowPos3f
  _gl::functions()\version = 1400
  Global WindowPos3fv._gl::PFNGLWINDOWPOS3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3fv"
  _gl::functions()\pointer = @WindowPos3fv
  _gl::functions()\version = 1400
  Global WindowPos3i._gl::PFNGLWINDOWPOS3IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3i"
  _gl::functions()\pointer = @WindowPos3i
  _gl::functions()\version = 1400
  Global WindowPos3iv._gl::PFNGLWINDOWPOS3IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3iv"
  _gl::functions()\pointer = @WindowPos3iv
  _gl::functions()\version = 1400
  Global WindowPos3s._gl::PFNGLWINDOWPOS3SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3s"
  _gl::functions()\pointer = @WindowPos3s
  _gl::functions()\version = 1400
  Global WindowPos3sv._gl::PFNGLWINDOWPOS3SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWindowPos3sv"
  _gl::functions()\pointer = @WindowPos3sv
  _gl::functions()\version = 1400
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(1,5,0)
  Global BeginQuery._gl::PFNGLBEGINQUERYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBeginQuery"
  _gl::functions()\pointer = @BeginQuery
  _gl::functions()\version = 1500
  Global BindBuffer._gl::PFNGLBINDBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindBuffer"
  _gl::functions()\pointer = @BindBuffer
  _gl::functions()\version = 1500
  Global BufferData._gl::PFNGLBUFFERDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBufferData"
  _gl::functions()\pointer = @BufferData
  _gl::functions()\version = 1500
  Global BufferSubData._gl::PFNGLBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBufferSubData"
  _gl::functions()\pointer = @BufferSubData
  _gl::functions()\version = 1500
  Global DeleteBuffers._gl::PFNGLDELETEBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteBuffers"
  _gl::functions()\pointer = @DeleteBuffers
  _gl::functions()\version = 1500
  Global DeleteQueries._gl::PFNGLDELETEQUERIESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteQueries"
  _gl::functions()\pointer = @DeleteQueries
  _gl::functions()\version = 1500
  Global EndQuery._gl::PFNGLENDQUERYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEndQuery"
  _gl::functions()\pointer = @EndQuery
  _gl::functions()\version = 1500
  Global GenBuffers._gl::PFNGLGENBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenBuffers"
  _gl::functions()\pointer = @GenBuffers
  _gl::functions()\version = 1500
  Global GenQueries._gl::PFNGLGENQUERIESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenQueries"
  _gl::functions()\pointer = @GenQueries
  _gl::functions()\version = 1500
  Global GetBufferParameteriv._gl::PFNGLGETBUFFERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetBufferParameteriv"
  _gl::functions()\pointer = @GetBufferParameteriv
  _gl::functions()\version = 1500
  Global GetBufferPointerv._gl::PFNGLGETBUFFERPOINTERVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetBufferPointerv"
  _gl::functions()\pointer = @GetBufferPointerv
  _gl::functions()\version = 1500
  Global GetBufferSubData._gl::PFNGLGETBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetBufferSubData"
  _gl::functions()\pointer = @GetBufferSubData
  _gl::functions()\version = 1500
  Global GetQueryObjectiv._gl::PFNGLGETQUERYOBJECTIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryObjectiv"
  _gl::functions()\pointer = @GetQueryObjectiv
  _gl::functions()\version = 1500
  Global GetQueryObjectuiv._gl::PFNGLGETQUERYOBJECTUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryObjectuiv"
  _gl::functions()\pointer = @GetQueryObjectuiv
  _gl::functions()\version = 1500
  Global GetQueryiv._gl::PFNGLGETQUERYIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryiv"
  _gl::functions()\pointer = @GetQueryiv
  _gl::functions()\version = 1500
  Global IsBuffer._gl::PFNGLISBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsBuffer"
  _gl::functions()\pointer = @IsBuffer
  _gl::functions()\version = 1500
  Global IsQuery._gl::PFNGLISQUERYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsQuery"
  _gl::functions()\pointer = @IsQuery
  _gl::functions()\version = 1500
  Global MapBuffer._gl::PFNGLMAPBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapBuffer"
  _gl::functions()\pointer = @MapBuffer
  _gl::functions()\version = 1500
  Global UnmapBuffer._gl::PFNGLUNMAPBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUnmapBuffer"
  _gl::functions()\pointer = @UnmapBuffer
  _gl::functions()\version = 1500
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(2,0,0)
  Global AttachShader._gl::PFNGLATTACHSHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glAttachShader"
  _gl::functions()\pointer = @AttachShader
  _gl::functions()\version = 2000
  Global BindAttribLocation._gl::PFNGLBINDATTRIBLOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindAttribLocation"
  _gl::functions()\pointer = @BindAttribLocation
  _gl::functions()\version = 2000
  Global BlendEquationSeparate._gl::PFNGLBLENDEQUATIONSEPARATEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendEquationSeparate"
  _gl::functions()\pointer = @BlendEquationSeparate
  _gl::functions()\version = 2000
  Global CompileShader._gl::PFNGLCOMPILESHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompileShader"
  _gl::functions()\pointer = @CompileShader
  _gl::functions()\version = 2000
  Global CreateProgram._gl::PFNGLCREATEPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateProgram"
  _gl::functions()\pointer = @CreateProgram
  _gl::functions()\version = 2000
  Global CreateShader._gl::PFNGLCREATESHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateShader"
  _gl::functions()\pointer = @CreateShader
  _gl::functions()\version = 2000
  Global DeleteProgram._gl::PFNGLDELETEPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteProgram"
  _gl::functions()\pointer = @DeleteProgram
  _gl::functions()\version = 2000
  Global DeleteShader._gl::PFNGLDELETESHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteShader"
  _gl::functions()\pointer = @DeleteShader
  _gl::functions()\version = 2000
  Global DetachShader._gl::PFNGLDETACHSHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDetachShader"
  _gl::functions()\pointer = @DetachShader
  _gl::functions()\version = 2000
  Global DisableVertexAttribArray._gl::PFNGLDISABLEVERTEXATTRIBARRAYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDisableVertexAttribArray"
  _gl::functions()\pointer = @DisableVertexAttribArray
  _gl::functions()\version = 2000
  Global DrawBuffers._gl::PFNGLDRAWBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawBuffers"
  _gl::functions()\pointer = @DrawBuffers
  _gl::functions()\version = 2000
  Global EnableVertexAttribArray._gl::PFNGLENABLEVERTEXATTRIBARRAYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEnableVertexAttribArray"
  _gl::functions()\pointer = @EnableVertexAttribArray
  _gl::functions()\version = 2000
  Global GetActiveAttrib._gl::PFNGLGETACTIVEATTRIBPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveAttrib"
  _gl::functions()\pointer = @GetActiveAttrib
  _gl::functions()\version = 2000
  Global GetActiveUniform._gl::PFNGLGETACTIVEUNIFORMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveUniform"
  _gl::functions()\pointer = @GetActiveUniform
  _gl::functions()\version = 2000
  Global GetAttachedShaders._gl::PFNGLGETATTACHEDSHADERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetAttachedShaders"
  _gl::functions()\pointer = @GetAttachedShaders
  _gl::functions()\version = 2000
  Global GetAttribLocation._gl::PFNGLGETATTRIBLOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetAttribLocation"
  _gl::functions()\pointer = @GetAttribLocation
  _gl::functions()\version = 2000
  Global GetProgramInfoLog._gl::PFNGLGETPROGRAMINFOLOGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramInfoLog"
  _gl::functions()\pointer = @GetProgramInfoLog
  _gl::functions()\version = 2000
  Global GetProgramiv._gl::PFNGLGETPROGRAMIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramiv"
  _gl::functions()\pointer = @GetProgramiv
  _gl::functions()\version = 2000
  Global GetShaderInfoLog._gl::PFNGLGETSHADERINFOLOGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetShaderInfoLog"
  _gl::functions()\pointer = @GetShaderInfoLog
  _gl::functions()\version = 2000
  Global GetShaderSource._gl::PFNGLGETSHADERSOURCEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetShaderSource"
  _gl::functions()\pointer = @GetShaderSource
  _gl::functions()\version = 2000
  Global GetShaderiv._gl::PFNGLGETSHADERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetShaderiv"
  _gl::functions()\pointer = @GetShaderiv
  _gl::functions()\version = 2000
  Global GetUniformLocation._gl::PFNGLGETUNIFORMLOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformLocation"
  _gl::functions()\pointer = @GetUniformLocation
  _gl::functions()\version = 2000
  Global GetUniformfv._gl::PFNGLGETUNIFORMFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformfv"
  _gl::functions()\pointer = @GetUniformfv
  _gl::functions()\version = 2000
  Global GetUniformiv._gl::PFNGLGETUNIFORMIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformiv"
  _gl::functions()\pointer = @GetUniformiv
  _gl::functions()\version = 2000
  Global GetVertexAttribPointerv._gl::PFNGLGETVERTEXATTRIBPOINTERVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribPointerv"
  _gl::functions()\pointer = @GetVertexAttribPointerv
  _gl::functions()\version = 2000
  Global GetVertexAttribdv._gl::PFNGLGETVERTEXATTRIBDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribdv"
  _gl::functions()\pointer = @GetVertexAttribdv
  _gl::functions()\version = 2000
  Global GetVertexAttribfv._gl::PFNGLGETVERTEXATTRIBFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribfv"
  _gl::functions()\pointer = @GetVertexAttribfv
  _gl::functions()\version = 2000
  Global GetVertexAttribiv._gl::PFNGLGETVERTEXATTRIBIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribiv"
  _gl::functions()\pointer = @GetVertexAttribiv
  _gl::functions()\version = 2000
  Global IsProgram._gl::PFNGLISPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsProgram"
  _gl::functions()\pointer = @IsProgram
  _gl::functions()\version = 2000
  Global IsShader._gl::PFNGLISSHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsShader"
  _gl::functions()\pointer = @IsShader
  _gl::functions()\version = 2000
  Global LinkProgram._gl::PFNGLLINKPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLinkProgram"
  _gl::functions()\pointer = @LinkProgram
  _gl::functions()\version = 2000
  Global ShaderSource._gl::PFNGLSHADERSOURCEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glShaderSource"
  _gl::functions()\pointer = @ShaderSource
  _gl::functions()\version = 2000
  Global StencilFuncSeparate._gl::PFNGLSTENCILFUNCSEPARATEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glStencilFuncSeparate"
  _gl::functions()\pointer = @StencilFuncSeparate
  _gl::functions()\version = 2000
  Global StencilMaskSeparate._gl::PFNGLSTENCILMASKSEPARATEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glStencilMaskSeparate"
  _gl::functions()\pointer = @StencilMaskSeparate
  _gl::functions()\version = 2000
  Global StencilOpSeparate._gl::PFNGLSTENCILOPSEPARATEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glStencilOpSeparate"
  _gl::functions()\pointer = @StencilOpSeparate
  _gl::functions()\version = 2000
  Global Uniform1f._gl::PFNGLUNIFORM1FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1f"
  _gl::functions()\pointer = @Uniform1f
  _gl::functions()\version = 2000
  Global Uniform1fv._gl::PFNGLUNIFORM1FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1fv"
  _gl::functions()\pointer = @Uniform1fv
  _gl::functions()\version = 2000
  Global Uniform1i._gl::PFNGLUNIFORM1IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1i"
  _gl::functions()\pointer = @Uniform1i
  _gl::functions()\version = 2000
  Global Uniform1iv._gl::PFNGLUNIFORM1IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1iv"
  _gl::functions()\pointer = @Uniform1iv
  _gl::functions()\version = 2000
  Global Uniform2f._gl::PFNGLUNIFORM2FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2f"
  _gl::functions()\pointer = @Uniform2f
  _gl::functions()\version = 2000
  Global Uniform2fv._gl::PFNGLUNIFORM2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2fv"
  _gl::functions()\pointer = @Uniform2fv
  _gl::functions()\version = 2000
  Global Uniform2i._gl::PFNGLUNIFORM2IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2i"
  _gl::functions()\pointer = @Uniform2i
  _gl::functions()\version = 2000
  Global Uniform2iv._gl::PFNGLUNIFORM2IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2iv"
  _gl::functions()\pointer = @Uniform2iv
  _gl::functions()\version = 2000
  Global Uniform3f._gl::PFNGLUNIFORM3FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3f"
  _gl::functions()\pointer = @Uniform3f
  _gl::functions()\version = 2000
  Global Uniform3fv._gl::PFNGLUNIFORM3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3fv"
  _gl::functions()\pointer = @Uniform3fv
  _gl::functions()\version = 2000
  Global Uniform3i._gl::PFNGLUNIFORM3IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3i"
  _gl::functions()\pointer = @Uniform3i
  _gl::functions()\version = 2000
  Global Uniform3iv._gl::PFNGLUNIFORM3IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3iv"
  _gl::functions()\pointer = @Uniform3iv
  _gl::functions()\version = 2000
  Global Uniform4f._gl::PFNGLUNIFORM4FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4f"
  _gl::functions()\pointer = @Uniform4f
  _gl::functions()\version = 2000
  Global Uniform4fv._gl::PFNGLUNIFORM4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4fv"
  _gl::functions()\pointer = @Uniform4fv
  _gl::functions()\version = 2000
  Global Uniform4i._gl::PFNGLUNIFORM4IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4i"
  _gl::functions()\pointer = @Uniform4i
  _gl::functions()\version = 2000
  Global Uniform4iv._gl::PFNGLUNIFORM4IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4iv"
  _gl::functions()\pointer = @Uniform4iv
  _gl::functions()\version = 2000
  Global UniformMatrix2fv._gl::PFNGLUNIFORMMATRIX2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix2fv"
  _gl::functions()\pointer = @UniformMatrix2fv
  _gl::functions()\version = 2000
  Global UniformMatrix3fv._gl::PFNGLUNIFORMMATRIX3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix3fv"
  _gl::functions()\pointer = @UniformMatrix3fv
  _gl::functions()\version = 2000
  Global UniformMatrix4fv._gl::PFNGLUNIFORMMATRIX4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix4fv"
  _gl::functions()\pointer = @UniformMatrix4fv
  _gl::functions()\version = 2000
  Global UseProgram._gl::PFNGLUSEPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUseProgram"
  _gl::functions()\pointer = @UseProgram
  _gl::functions()\version = 2000
  Global ValidateProgram._gl::PFNGLVALIDATEPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glValidateProgram"
  _gl::functions()\pointer = @ValidateProgram
  _gl::functions()\version = 2000
  Global VertexAttrib1d._gl::PFNGLVERTEXATTRIB1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib1d"
  _gl::functions()\pointer = @VertexAttrib1d
  _gl::functions()\version = 2000
  Global VertexAttrib1dv._gl::PFNGLVERTEXATTRIB1DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib1dv"
  _gl::functions()\pointer = @VertexAttrib1dv
  _gl::functions()\version = 2000
  Global VertexAttrib1f._gl::PFNGLVERTEXATTRIB1FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib1f"
  _gl::functions()\pointer = @VertexAttrib1f
  _gl::functions()\version = 2000
  Global VertexAttrib1fv._gl::PFNGLVERTEXATTRIB1FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib1fv"
  _gl::functions()\pointer = @VertexAttrib1fv
  _gl::functions()\version = 2000
  Global VertexAttrib1s._gl::PFNGLVERTEXATTRIB1SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib1s"
  _gl::functions()\pointer = @VertexAttrib1s
  _gl::functions()\version = 2000
  Global VertexAttrib1sv._gl::PFNGLVERTEXATTRIB1SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib1sv"
  _gl::functions()\pointer = @VertexAttrib1sv
  _gl::functions()\version = 2000
  Global VertexAttrib2d._gl::PFNGLVERTEXATTRIB2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib2d"
  _gl::functions()\pointer = @VertexAttrib2d
  _gl::functions()\version = 2000
  Global VertexAttrib2dv._gl::PFNGLVERTEXATTRIB2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib2dv"
  _gl::functions()\pointer = @VertexAttrib2dv
  _gl::functions()\version = 2000
  Global VertexAttrib2f._gl::PFNGLVERTEXATTRIB2FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib2f"
  _gl::functions()\pointer = @VertexAttrib2f
  _gl::functions()\version = 2000
  Global VertexAttrib2fv._gl::PFNGLVERTEXATTRIB2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib2fv"
  _gl::functions()\pointer = @VertexAttrib2fv
  _gl::functions()\version = 2000
  Global VertexAttrib2s._gl::PFNGLVERTEXATTRIB2SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib2s"
  _gl::functions()\pointer = @VertexAttrib2s
  _gl::functions()\version = 2000
  Global VertexAttrib2sv._gl::PFNGLVERTEXATTRIB2SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib2sv"
  _gl::functions()\pointer = @VertexAttrib2sv
  _gl::functions()\version = 2000
  Global VertexAttrib3d._gl::PFNGLVERTEXATTRIB3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib3d"
  _gl::functions()\pointer = @VertexAttrib3d
  _gl::functions()\version = 2000
  Global VertexAttrib3dv._gl::PFNGLVERTEXATTRIB3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib3dv"
  _gl::functions()\pointer = @VertexAttrib3dv
  _gl::functions()\version = 2000
  Global VertexAttrib3f._gl::PFNGLVERTEXATTRIB3FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib3f"
  _gl::functions()\pointer = @VertexAttrib3f
  _gl::functions()\version = 2000
  Global VertexAttrib3fv._gl::PFNGLVERTEXATTRIB3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib3fv"
  _gl::functions()\pointer = @VertexAttrib3fv
  _gl::functions()\version = 2000
  Global VertexAttrib3s._gl::PFNGLVERTEXATTRIB3SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib3s"
  _gl::functions()\pointer = @VertexAttrib3s
  _gl::functions()\version = 2000
  Global VertexAttrib3sv._gl::PFNGLVERTEXATTRIB3SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib3sv"
  _gl::functions()\pointer = @VertexAttrib3sv
  _gl::functions()\version = 2000
  Global VertexAttrib4Nbv._gl::PFNGLVERTEXATTRIB4NBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Nbv"
  _gl::functions()\pointer = @VertexAttrib4Nbv
  _gl::functions()\version = 2000
  Global VertexAttrib4Niv._gl::PFNGLVERTEXATTRIB4NIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Niv"
  _gl::functions()\pointer = @VertexAttrib4Niv
  _gl::functions()\version = 2000
  Global VertexAttrib4Nsv._gl::PFNGLVERTEXATTRIB4NSVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Nsv"
  _gl::functions()\pointer = @VertexAttrib4Nsv
  _gl::functions()\version = 2000
  Global VertexAttrib4Nub._gl::PFNGLVERTEXATTRIB4NUBPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Nub"
  _gl::functions()\pointer = @VertexAttrib4Nub
  _gl::functions()\version = 2000
  Global VertexAttrib4Nubv._gl::PFNGLVERTEXATTRIB4NUBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Nubv"
  _gl::functions()\pointer = @VertexAttrib4Nubv
  _gl::functions()\version = 2000
  Global VertexAttrib4Nuiv._gl::PFNGLVERTEXATTRIB4NUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Nuiv"
  _gl::functions()\pointer = @VertexAttrib4Nuiv
  _gl::functions()\version = 2000
  Global VertexAttrib4Nusv._gl::PFNGLVERTEXATTRIB4NUSVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4Nusv"
  _gl::functions()\pointer = @VertexAttrib4Nusv
  _gl::functions()\version = 2000
  Global VertexAttrib4bv._gl::PFNGLVERTEXATTRIB4BVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4bv"
  _gl::functions()\pointer = @VertexAttrib4bv
  _gl::functions()\version = 2000
  Global VertexAttrib4d._gl::PFNGLVERTEXATTRIB4DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4d"
  _gl::functions()\pointer = @VertexAttrib4d
  _gl::functions()\version = 2000
  Global VertexAttrib4dv._gl::PFNGLVERTEXATTRIB4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4dv"
  _gl::functions()\pointer = @VertexAttrib4dv
  _gl::functions()\version = 2000
  Global VertexAttrib4f._gl::PFNGLVERTEXATTRIB4FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4f"
  _gl::functions()\pointer = @VertexAttrib4f
  _gl::functions()\version = 2000
  Global VertexAttrib4fv._gl::PFNGLVERTEXATTRIB4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4fv"
  _gl::functions()\pointer = @VertexAttrib4fv
  _gl::functions()\version = 2000
  Global VertexAttrib4iv._gl::PFNGLVERTEXATTRIB4IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4iv"
  _gl::functions()\pointer = @VertexAttrib4iv
  _gl::functions()\version = 2000
  Global VertexAttrib4s._gl::PFNGLVERTEXATTRIB4SPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4s"
  _gl::functions()\pointer = @VertexAttrib4s
  _gl::functions()\version = 2000
  Global VertexAttrib4sv._gl::PFNGLVERTEXATTRIB4SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4sv"
  _gl::functions()\pointer = @VertexAttrib4sv
  _gl::functions()\version = 2000
  Global VertexAttrib4ubv._gl::PFNGLVERTEXATTRIB4UBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4ubv"
  _gl::functions()\pointer = @VertexAttrib4ubv
  _gl::functions()\version = 2000
  Global VertexAttrib4uiv._gl::PFNGLVERTEXATTRIB4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4uiv"
  _gl::functions()\pointer = @VertexAttrib4uiv
  _gl::functions()\version = 2000
  Global VertexAttrib4usv._gl::PFNGLVERTEXATTRIB4USVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttrib4usv"
  _gl::functions()\pointer = @VertexAttrib4usv
  _gl::functions()\version = 2000
  Global VertexAttribPointer._gl::PFNGLVERTEXATTRIBPOINTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribPointer"
  _gl::functions()\pointer = @VertexAttribPointer
  _gl::functions()\version = 2000
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(2,1,0)
  Global UniformMatrix2x3fv._gl::PFNGLUNIFORMMATRIX2X3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix2x3fv"
  _gl::functions()\pointer = @UniformMatrix2x3fv
  _gl::functions()\version = 2100
  Global UniformMatrix2x4fv._gl::PFNGLUNIFORMMATRIX2X4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix2x4fv"
  _gl::functions()\pointer = @UniformMatrix2x4fv
  _gl::functions()\version = 2100
  Global UniformMatrix3x2fv._gl::PFNGLUNIFORMMATRIX3X2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix3x2fv"
  _gl::functions()\pointer = @UniformMatrix3x2fv
  _gl::functions()\version = 2100
  Global UniformMatrix3x4fv._gl::PFNGLUNIFORMMATRIX3X4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix3x4fv"
  _gl::functions()\pointer = @UniformMatrix3x4fv
  _gl::functions()\version = 2100
  Global UniformMatrix4x2fv._gl::PFNGLUNIFORMMATRIX4X2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix4x2fv"
  _gl::functions()\pointer = @UniformMatrix4x2fv
  _gl::functions()\version = 2100
  Global UniformMatrix4x3fv._gl::PFNGLUNIFORMMATRIX4X3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix4x3fv"
  _gl::functions()\pointer = @UniformMatrix4x3fv
  _gl::functions()\version = 2100
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,0,0)
  Global BeginConditionalRender._gl::PFNGLBEGINCONDITIONALRENDERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBeginConditionalRender"
  _gl::functions()\pointer = @BeginConditionalRender
  _gl::functions()\version = 3000
  Global BeginTransformFeedback._gl::PFNGLBEGINTRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBeginTransformFeedback"
  _gl::functions()\pointer = @BeginTransformFeedback
  _gl::functions()\version = 3000
  Global BindFragDataLocation._gl::PFNGLBINDFRAGDATALOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindFragDataLocation"
  _gl::functions()\pointer = @BindFragDataLocation
  _gl::functions()\version = 3000
  Global ClampColor._gl::PFNGLCLAMPCOLORPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClampColor"
  _gl::functions()\pointer = @ClampColor
  _gl::functions()\version = 3000
  Global ClearBufferfi._gl::PFNGLCLEARBUFFERFIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearBufferfi"
  _gl::functions()\pointer = @ClearBufferfi
  _gl::functions()\version = 3000
  Global ClearBufferfv._gl::PFNGLCLEARBUFFERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearBufferfv"
  _gl::functions()\pointer = @ClearBufferfv
  _gl::functions()\version = 3000
  Global ClearBufferiv._gl::PFNGLCLEARBUFFERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearBufferiv"
  _gl::functions()\pointer = @ClearBufferiv
  _gl::functions()\version = 3000
  Global ClearBufferuiv._gl::PFNGLCLEARBUFFERUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearBufferuiv"
  _gl::functions()\pointer = @ClearBufferuiv
  _gl::functions()\version = 3000
  Global ColorMaski._gl::PFNGLCOLORMASKIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorMaski"
  _gl::functions()\pointer = @ColorMaski
  _gl::functions()\version = 3000
  Global Disablei._gl::PFNGLDISABLEIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDisablei"
  _gl::functions()\pointer = @Disablei
  _gl::functions()\version = 3000
  Global Enablei._gl::PFNGLENABLEIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEnablei"
  _gl::functions()\pointer = @Enablei
  _gl::functions()\version = 3000
  Global EndConditionalRender._gl::PFNGLENDCONDITIONALRENDERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEndConditionalRender"
  _gl::functions()\pointer = @EndConditionalRender
  _gl::functions()\version = 3000
  Global EndTransformFeedback._gl::PFNGLENDTRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEndTransformFeedback"
  _gl::functions()\pointer = @EndTransformFeedback
  _gl::functions()\version = 3000
  Global GetBooleani_v._gl::PFNGLGETBOOLEANI_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetBooleani_v"
  _gl::functions()\pointer = @GetBooleani_v
  _gl::functions()\version = 3000
  Global GetFragDataLocation._gl::PFNGLGETFRAGDATALOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFragDataLocation"
  _gl::functions()\pointer = @GetFragDataLocation
  _gl::functions()\version = 3000
  Global GetStringi._gl::PFNGLGETSTRINGIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetStringi"
  _gl::functions()\pointer = @GetStringi
  _gl::functions()\version = 3000
  Global GetTexParameterIiv._gl::PFNGLGETTEXPARAMETERIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexParameterIiv"
  _gl::functions()\pointer = @GetTexParameterIiv
  _gl::functions()\version = 3000
  Global GetTexParameterIuiv._gl::PFNGLGETTEXPARAMETERIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexParameterIuiv"
  _gl::functions()\pointer = @GetTexParameterIuiv
  _gl::functions()\version = 3000
  Global GetTransformFeedbackVarying._gl::PFNGLGETTRANSFORMFEEDBACKVARYINGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTransformFeedbackVarying"
  _gl::functions()\pointer = @GetTransformFeedbackVarying
  _gl::functions()\version = 3000
  Global GetUniformuiv._gl::PFNGLGETUNIFORMUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformuiv"
  _gl::functions()\pointer = @GetUniformuiv
  _gl::functions()\version = 3000
  Global GetVertexAttribIiv._gl::PFNGLGETVERTEXATTRIBIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribIiv"
  _gl::functions()\pointer = @GetVertexAttribIiv
  _gl::functions()\version = 3000
  Global GetVertexAttribIuiv._gl::PFNGLGETVERTEXATTRIBIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribIuiv"
  _gl::functions()\pointer = @GetVertexAttribIuiv
  _gl::functions()\version = 3000
  Global IsEnabledi._gl::PFNGLISENABLEDIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsEnabledi"
  _gl::functions()\pointer = @IsEnabledi
  _gl::functions()\version = 3000
  Global TexParameterIiv._gl::PFNGLTEXPARAMETERIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameterIiv"
  _gl::functions()\pointer = @TexParameterIiv
  _gl::functions()\version = 3000
  Global TexParameterIuiv._gl::PFNGLTEXPARAMETERIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameterIuiv"
  _gl::functions()\pointer = @TexParameterIuiv
  _gl::functions()\version = 3000
  Global TransformFeedbackVaryings._gl::PFNGLTRANSFORMFEEDBACKVARYINGSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTransformFeedbackVaryings"
  _gl::functions()\pointer = @TransformFeedbackVaryings
  _gl::functions()\version = 3000
  Global Uniform1ui._gl::PFNGLUNIFORM1UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1ui"
  _gl::functions()\pointer = @Uniform1ui
  _gl::functions()\version = 3000
  Global Uniform1uiv._gl::PFNGLUNIFORM1UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1uiv"
  _gl::functions()\pointer = @Uniform1uiv
  _gl::functions()\version = 3000
  Global Uniform2ui._gl::PFNGLUNIFORM2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2ui"
  _gl::functions()\pointer = @Uniform2ui
  _gl::functions()\version = 3000
  Global Uniform2uiv._gl::PFNGLUNIFORM2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2uiv"
  _gl::functions()\pointer = @Uniform2uiv
  _gl::functions()\version = 3000
  Global Uniform3ui._gl::PFNGLUNIFORM3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3ui"
  _gl::functions()\pointer = @Uniform3ui
  _gl::functions()\version = 3000
  Global Uniform3uiv._gl::PFNGLUNIFORM3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3uiv"
  _gl::functions()\pointer = @Uniform3uiv
  _gl::functions()\version = 3000
  Global Uniform4ui._gl::PFNGLUNIFORM4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4ui"
  _gl::functions()\pointer = @Uniform4ui
  _gl::functions()\version = 3000
  Global Uniform4uiv._gl::PFNGLUNIFORM4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4uiv"
  _gl::functions()\pointer = @Uniform4uiv
  _gl::functions()\version = 3000
  Global VertexAttribI1i._gl::PFNGLVERTEXATTRIBI1IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI1i"
  _gl::functions()\pointer = @VertexAttribI1i
  _gl::functions()\version = 3000
  Global VertexAttribI1iv._gl::PFNGLVERTEXATTRIBI1IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI1iv"
  _gl::functions()\pointer = @VertexAttribI1iv
  _gl::functions()\version = 3000
  Global VertexAttribI1ui._gl::PFNGLVERTEXATTRIBI1UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI1ui"
  _gl::functions()\pointer = @VertexAttribI1ui
  _gl::functions()\version = 3000
  Global VertexAttribI1uiv._gl::PFNGLVERTEXATTRIBI1UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI1uiv"
  _gl::functions()\pointer = @VertexAttribI1uiv
  _gl::functions()\version = 3000
  Global VertexAttribI2i._gl::PFNGLVERTEXATTRIBI2IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI2i"
  _gl::functions()\pointer = @VertexAttribI2i
  _gl::functions()\version = 3000
  Global VertexAttribI2iv._gl::PFNGLVERTEXATTRIBI2IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI2iv"
  _gl::functions()\pointer = @VertexAttribI2iv
  _gl::functions()\version = 3000
  Global VertexAttribI2ui._gl::PFNGLVERTEXATTRIBI2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI2ui"
  _gl::functions()\pointer = @VertexAttribI2ui
  _gl::functions()\version = 3000
  Global VertexAttribI2uiv._gl::PFNGLVERTEXATTRIBI2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI2uiv"
  _gl::functions()\pointer = @VertexAttribI2uiv
  _gl::functions()\version = 3000
  Global VertexAttribI3i._gl::PFNGLVERTEXATTRIBI3IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI3i"
  _gl::functions()\pointer = @VertexAttribI3i
  _gl::functions()\version = 3000
  Global VertexAttribI3iv._gl::PFNGLVERTEXATTRIBI3IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI3iv"
  _gl::functions()\pointer = @VertexAttribI3iv
  _gl::functions()\version = 3000
  Global VertexAttribI3ui._gl::PFNGLVERTEXATTRIBI3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI3ui"
  _gl::functions()\pointer = @VertexAttribI3ui
  _gl::functions()\version = 3000
  Global VertexAttribI3uiv._gl::PFNGLVERTEXATTRIBI3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI3uiv"
  _gl::functions()\pointer = @VertexAttribI3uiv
  _gl::functions()\version = 3000
  Global VertexAttribI4bv._gl::PFNGLVERTEXATTRIBI4BVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4bv"
  _gl::functions()\pointer = @VertexAttribI4bv
  _gl::functions()\version = 3000
  Global VertexAttribI4i._gl::PFNGLVERTEXATTRIBI4IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4i"
  _gl::functions()\pointer = @VertexAttribI4i
  _gl::functions()\version = 3000
  Global VertexAttribI4iv._gl::PFNGLVERTEXATTRIBI4IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4iv"
  _gl::functions()\pointer = @VertexAttribI4iv
  _gl::functions()\version = 3000
  Global VertexAttribI4sv._gl::PFNGLVERTEXATTRIBI4SVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4sv"
  _gl::functions()\pointer = @VertexAttribI4sv
  _gl::functions()\version = 3000
  Global VertexAttribI4ubv._gl::PFNGLVERTEXATTRIBI4UBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4ubv"
  _gl::functions()\pointer = @VertexAttribI4ubv
  _gl::functions()\version = 3000
  Global VertexAttribI4ui._gl::PFNGLVERTEXATTRIBI4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4ui"
  _gl::functions()\pointer = @VertexAttribI4ui
  _gl::functions()\version = 3000
  Global VertexAttribI4uiv._gl::PFNGLVERTEXATTRIBI4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4uiv"
  _gl::functions()\pointer = @VertexAttribI4uiv
  _gl::functions()\version = 3000
  Global VertexAttribI4usv._gl::PFNGLVERTEXATTRIBI4USVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribI4usv"
  _gl::functions()\pointer = @VertexAttribI4usv
  _gl::functions()\version = 3000
  Global VertexAttribIPointer._gl::PFNGLVERTEXATTRIBIPOINTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribIPointer"
  _gl::functions()\pointer = @VertexAttribIPointer
  _gl::functions()\version = 3000
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,1,0)
  Global DrawArraysInstanced._gl::PFNGLDRAWARRAYSINSTANCEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawArraysInstanced"
  _gl::functions()\pointer = @DrawArraysInstanced
  _gl::functions()\version = 3100
  Global DrawElementsInstanced._gl::PFNGLDRAWELEMENTSINSTANCEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElementsInstanced"
  _gl::functions()\pointer = @DrawElementsInstanced
  _gl::functions()\version = 3100
  Global PrimitiveRestartIndex._gl::PFNGLPRIMITIVERESTARTINDEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPrimitiveRestartIndex"
  _gl::functions()\pointer = @PrimitiveRestartIndex
  _gl::functions()\version = 3100
  Global TexBuffer._gl::PFNGLTEXBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexBuffer"
  _gl::functions()\pointer = @TexBuffer
  _gl::functions()\version = 3100
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,2,0)
  Global FramebufferTexture._gl::PFNGLFRAMEBUFFERTEXTUREPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferTexture"
  _gl::functions()\pointer = @FramebufferTexture
  _gl::functions()\version = 3200
  Global GetBufferParameteri64v._gl::PFNGLGETBUFFERPARAMETERI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetBufferParameteri64v"
  _gl::functions()\pointer = @GetBufferParameteri64v
  _gl::functions()\version = 3200
  Global GetInteger64i_v._gl::PFNGLGETINTEGER64I_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetInteger64i_v"
  _gl::functions()\pointer = @GetInteger64i_v
  _gl::functions()\version = 3200
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(3,3,0)
  Global VertexAttribDivisor._gl::PFNGLVERTEXATTRIBDIVISORPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribDivisor"
  _gl::functions()\pointer = @VertexAttribDivisor
  _gl::functions()\version = 3300
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,0,0)
  Global BlendEquationSeparatei._gl::PFNGLBLENDEQUATIONSEPARATEIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendEquationSeparatei"
  _gl::functions()\pointer = @BlendEquationSeparatei
  _gl::functions()\version = 4000
  Global BlendEquationi._gl::PFNGLBLENDEQUATIONIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendEquationi"
  _gl::functions()\pointer = @BlendEquationi
  _gl::functions()\version = 4000
  Global BlendFuncSeparatei._gl::PFNGLBLENDFUNCSEPARATEIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendFuncSeparatei"
  _gl::functions()\pointer = @BlendFuncSeparatei
  _gl::functions()\version = 4000
  Global BlendFunci._gl::PFNGLBLENDFUNCIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlendFunci"
  _gl::functions()\pointer = @BlendFunci
  _gl::functions()\version = 4000
  Global MinSampleShading._gl::PFNGLMINSAMPLESHADINGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMinSampleShading"
  _gl::functions()\pointer = @MinSampleShading
  _gl::functions()\version = 4000
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,1,0)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,2,0)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,3,0)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,4,0)
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,5,0)
  Global GetGraphicsResetStatus._gl::PFNGLGETGRAPHICSRESETSTATUSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetGraphicsResetStatus"
  _gl::functions()\pointer = @GetGraphicsResetStatus
  _gl::functions()\version = 4500
  Global GetnCompressedTexImage._gl::PFNGLGETNCOMPRESSEDTEXIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetnCompressedTexImage"
  _gl::functions()\pointer = @GetnCompressedTexImage
  _gl::functions()\version = 4500
  Global GetnTexImage._gl::PFNGLGETNTEXIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetnTexImage"
  _gl::functions()\pointer = @GetnTexImage
  _gl::functions()\version = 4500
  Global GetnUniformdv._gl::PFNGLGETNUNIFORMDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetnUniformdv"
  _gl::functions()\pointer = @GetnUniformdv
  _gl::functions()\version = 4500
CompilerEndif
CompilerIf _gl::GL_VERSION_ATLEAST(4,6,0)
  Global MultiDrawArraysIndirectCount._gl::PFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawArraysIndirectCount"
  _gl::functions()\pointer = @MultiDrawArraysIndirectCount
  _gl::functions()\version = 4600
  Global MultiDrawElementsIndirectCount._gl::PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawElementsIndirectCount"
  _gl::functions()\pointer = @MultiDrawElementsIndirectCount
  _gl::functions()\version = 4600
  Global SpecializeShader._gl::PFNGLSPECIALIZESHADERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSpecializeShader"
  _gl::functions()\pointer = @SpecializeShader
  _gl::functions()\version = 4600
CompilerEndif
  Global ClearDepthf._gl::PFNGLCLEARDEPTHFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearDepthf"
  _gl::functions()\pointer = @ClearDepthf
  _gl::functions()\version = 0
  Global DepthRangef._gl::PFNGLDEPTHRANGEFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthRangef"
  _gl::functions()\pointer = @DepthRangef
  _gl::functions()\version = 0
  Global GetShaderPrecisionFormat._gl::PFNGLGETSHADERPRECISIONFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetShaderPrecisionFormat"
  _gl::functions()\pointer = @GetShaderPrecisionFormat
  _gl::functions()\version = 0
  Global ReleaseShaderCompiler._gl::PFNGLRELEASESHADERCOMPILERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glReleaseShaderCompiler"
  _gl::functions()\pointer = @ReleaseShaderCompiler
  _gl::functions()\version = 0
  Global ShaderBinary._gl::PFNGLSHADERBINARYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glShaderBinary"
  _gl::functions()\pointer = @ShaderBinary
  _gl::functions()\version = 0
  Global MemoryBarrierByRegion._gl::PFNGLMEMORYBARRIERBYREGIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMemoryBarrierByRegion"
  _gl::functions()\pointer = @MemoryBarrierByRegion
  _gl::functions()\version = 0
  Global DrawArraysInstancedBaseInstance._gl::PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawArraysInstancedBaseInstance"
  _gl::functions()\pointer = @DrawArraysInstancedBaseInstance
  _gl::functions()\version = 0
  Global DrawElementsInstancedBaseInstance._gl::PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElementsInstancedBaseInstance"
  _gl::functions()\pointer = @DrawElementsInstancedBaseInstance
  _gl::functions()\version = 0
  Global DrawElementsInstancedBaseVertexBaseInstance._gl::PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElementsInstancedBaseVertexBaseInstance"
  _gl::functions()\pointer = @DrawElementsInstancedBaseVertexBaseInstance
  _gl::functions()\version = 0
  Global BindFragDataLocationIndexed._gl::PFNGLBINDFRAGDATALOCATIONINDEXEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindFragDataLocationIndexed"
  _gl::functions()\pointer = @BindFragDataLocationIndexed
  _gl::functions()\version = 0
  Global GetFragDataIndex._gl::PFNGLGETFRAGDATAINDEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFragDataIndex"
  _gl::functions()\pointer = @GetFragDataIndex
  _gl::functions()\version = 0
  Global BufferStorage._gl::PFNGLBUFFERSTORAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBufferStorage"
  _gl::functions()\pointer = @BufferStorage
  _gl::functions()\version = 0
  Global ClearBufferData._gl::PFNGLCLEARBUFFERDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearBufferData"
  _gl::functions()\pointer = @ClearBufferData
  _gl::functions()\version = 0
  Global ClearBufferSubData._gl::PFNGLCLEARBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearBufferSubData"
  _gl::functions()\pointer = @ClearBufferSubData
  _gl::functions()\version = 0
  Global ClearTexImage._gl::PFNGLCLEARTEXIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearTexImage"
  _gl::functions()\pointer = @ClearTexImage
  _gl::functions()\version = 0
  Global ClearTexSubImage._gl::PFNGLCLEARTEXSUBIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearTexSubImage"
  _gl::functions()\pointer = @ClearTexSubImage
  _gl::functions()\version = 0
  Global ClipControl._gl::PFNGLCLIPCONTROLPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClipControl"
  _gl::functions()\pointer = @ClipControl
  _gl::functions()\version = 0
  Global DispatchCompute._gl::PFNGLDISPATCHCOMPUTEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDispatchCompute"
  _gl::functions()\pointer = @DispatchCompute
  _gl::functions()\version = 0
  Global DispatchComputeIndirect._gl::PFNGLDISPATCHCOMPUTEINDIRECTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDispatchComputeIndirect"
  _gl::functions()\pointer = @DispatchComputeIndirect
  _gl::functions()\version = 0
  Global CopyBufferSubData._gl::PFNGLCOPYBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyBufferSubData"
  _gl::functions()\pointer = @CopyBufferSubData
  _gl::functions()\version = 0
  Global CopyImageSubData._gl::PFNGLCOPYIMAGESUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyImageSubData"
  _gl::functions()\pointer = @CopyImageSubData
  _gl::functions()\version = 0
  Global BindTextureUnit._gl::PFNGLBINDTEXTUREUNITPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindTextureUnit"
  _gl::functions()\pointer = @BindTextureUnit
  _gl::functions()\version = 0
  Global BlitNamedFramebuffer._gl::PFNGLBLITNAMEDFRAMEBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlitNamedFramebuffer"
  _gl::functions()\pointer = @BlitNamedFramebuffer
  _gl::functions()\version = 0
  Global CheckNamedFramebufferStatus._gl::PFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCheckNamedFramebufferStatus"
  _gl::functions()\pointer = @CheckNamedFramebufferStatus
  _gl::functions()\version = 0
  Global ClearNamedBufferData._gl::PFNGLCLEARNAMEDBUFFERDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearNamedBufferData"
  _gl::functions()\pointer = @ClearNamedBufferData
  _gl::functions()\version = 0
  Global ClearNamedBufferSubData._gl::PFNGLCLEARNAMEDBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearNamedBufferSubData"
  _gl::functions()\pointer = @ClearNamedBufferSubData
  _gl::functions()\version = 0
  Global ClearNamedFramebufferfi._gl::PFNGLCLEARNAMEDFRAMEBUFFERFIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearNamedFramebufferfi"
  _gl::functions()\pointer = @ClearNamedFramebufferfi
  _gl::functions()\version = 0
  Global ClearNamedFramebufferfv._gl::PFNGLCLEARNAMEDFRAMEBUFFERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearNamedFramebufferfv"
  _gl::functions()\pointer = @ClearNamedFramebufferfv
  _gl::functions()\version = 0
  Global ClearNamedFramebufferiv._gl::PFNGLCLEARNAMEDFRAMEBUFFERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearNamedFramebufferiv"
  _gl::functions()\pointer = @ClearNamedFramebufferiv
  _gl::functions()\version = 0
  Global ClearNamedFramebufferuiv._gl::PFNGLCLEARNAMEDFRAMEBUFFERUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearNamedFramebufferuiv"
  _gl::functions()\pointer = @ClearNamedFramebufferuiv
  _gl::functions()\version = 0
  Global CompressedTextureSubImage1D._gl::PFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTextureSubImage1D"
  _gl::functions()\pointer = @CompressedTextureSubImage1D
  _gl::functions()\version = 0
  Global CompressedTextureSubImage2D._gl::PFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTextureSubImage2D"
  _gl::functions()\pointer = @CompressedTextureSubImage2D
  _gl::functions()\version = 0
  Global CompressedTextureSubImage3D._gl::PFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCompressedTextureSubImage3D"
  _gl::functions()\pointer = @CompressedTextureSubImage3D
  _gl::functions()\version = 0
  Global CopyNamedBufferSubData._gl::PFNGLCOPYNAMEDBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyNamedBufferSubData"
  _gl::functions()\pointer = @CopyNamedBufferSubData
  _gl::functions()\version = 0
  Global CopyTextureSubImage1D._gl::PFNGLCOPYTEXTURESUBIMAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTextureSubImage1D"
  _gl::functions()\pointer = @CopyTextureSubImage1D
  _gl::functions()\version = 0
  Global CopyTextureSubImage2D._gl::PFNGLCOPYTEXTURESUBIMAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTextureSubImage2D"
  _gl::functions()\pointer = @CopyTextureSubImage2D
  _gl::functions()\version = 0
  Global CopyTextureSubImage3D._gl::PFNGLCOPYTEXTURESUBIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyTextureSubImage3D"
  _gl::functions()\pointer = @CopyTextureSubImage3D
  _gl::functions()\version = 0
  Global CreateBuffers._gl::PFNGLCREATEBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateBuffers"
  _gl::functions()\pointer = @CreateBuffers
  _gl::functions()\version = 0
  Global CreateFramebuffers._gl::PFNGLCREATEFRAMEBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateFramebuffers"
  _gl::functions()\pointer = @CreateFramebuffers
  _gl::functions()\version = 0
  Global CreateProgramPipelines._gl::PFNGLCREATEPROGRAMPIPELINESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateProgramPipelines"
  _gl::functions()\pointer = @CreateProgramPipelines
  _gl::functions()\version = 0
  Global CreateQueries._gl::PFNGLCREATEQUERIESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateQueries"
  _gl::functions()\pointer = @CreateQueries
  _gl::functions()\version = 0
  Global CreateRenderbuffers._gl::PFNGLCREATERENDERBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateRenderbuffers"
  _gl::functions()\pointer = @CreateRenderbuffers
  _gl::functions()\version = 0
  Global CreateSamplers._gl::PFNGLCREATESAMPLERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateSamplers"
  _gl::functions()\pointer = @CreateSamplers
  _gl::functions()\version = 0
  Global CreateTextures._gl::PFNGLCREATETEXTURESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateTextures"
  _gl::functions()\pointer = @CreateTextures
  _gl::functions()\version = 0
  Global CreateTransformFeedbacks._gl::PFNGLCREATETRANSFORMFEEDBACKSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateTransformFeedbacks"
  _gl::functions()\pointer = @CreateTransformFeedbacks
  _gl::functions()\version = 0
  Global CreateVertexArrays._gl::PFNGLCREATEVERTEXARRAYSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateVertexArrays"
  _gl::functions()\pointer = @CreateVertexArrays
  _gl::functions()\version = 0
  Global DisableVertexArrayAttrib._gl::PFNGLDISABLEVERTEXARRAYATTRIBPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDisableVertexArrayAttrib"
  _gl::functions()\pointer = @DisableVertexArrayAttrib
  _gl::functions()\version = 0
  Global EnableVertexArrayAttrib._gl::PFNGLENABLEVERTEXARRAYATTRIBPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEnableVertexArrayAttrib"
  _gl::functions()\pointer = @EnableVertexArrayAttrib
  _gl::functions()\version = 0
  Global FlushMappedNamedBufferRange._gl::PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFlushMappedNamedBufferRange"
  _gl::functions()\pointer = @FlushMappedNamedBufferRange
  _gl::functions()\version = 0
  Global GenerateTextureMipmap._gl::PFNGLGENERATETEXTUREMIPMAPPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenerateTextureMipmap"
  _gl::functions()\pointer = @GenerateTextureMipmap
  _gl::functions()\version = 0
  Global GetCompressedTextureImage._gl::PFNGLGETCOMPRESSEDTEXTUREIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetCompressedTextureImage"
  _gl::functions()\pointer = @GetCompressedTextureImage
  _gl::functions()\version = 0
  Global GetNamedBufferParameteri64v._gl::PFNGLGETNAMEDBUFFERPARAMETERI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedBufferParameteri64v"
  _gl::functions()\pointer = @GetNamedBufferParameteri64v
  _gl::functions()\version = 0
  Global GetNamedBufferParameteriv._gl::PFNGLGETNAMEDBUFFERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedBufferParameteriv"
  _gl::functions()\pointer = @GetNamedBufferParameteriv
  _gl::functions()\version = 0
  Global GetNamedBufferPointerv._gl::PFNGLGETNAMEDBUFFERPOINTERVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedBufferPointerv"
  _gl::functions()\pointer = @GetNamedBufferPointerv
  _gl::functions()\version = 0
  Global GetNamedBufferSubData._gl::PFNGLGETNAMEDBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedBufferSubData"
  _gl::functions()\pointer = @GetNamedBufferSubData
  _gl::functions()\version = 0
  Global GetNamedFramebufferAttachmentParameteriv._gl::PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedFramebufferAttachmentParameteriv"
  _gl::functions()\pointer = @GetNamedFramebufferAttachmentParameteriv
  _gl::functions()\version = 0
  Global GetNamedFramebufferParameteriv._gl::PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedFramebufferParameteriv"
  _gl::functions()\pointer = @GetNamedFramebufferParameteriv
  _gl::functions()\version = 0
  Global GetNamedRenderbufferParameteriv._gl::PFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetNamedRenderbufferParameteriv"
  _gl::functions()\pointer = @GetNamedRenderbufferParameteriv
  _gl::functions()\version = 0
  Global GetQueryBufferObjecti64v._gl::PFNGLGETQUERYBUFFEROBJECTI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryBufferObjecti64v"
  _gl::functions()\pointer = @GetQueryBufferObjecti64v
  _gl::functions()\version = 0
  Global GetQueryBufferObjectiv._gl::PFNGLGETQUERYBUFFEROBJECTIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryBufferObjectiv"
  _gl::functions()\pointer = @GetQueryBufferObjectiv
  _gl::functions()\version = 0
  Global GetQueryBufferObjectui64v._gl::PFNGLGETQUERYBUFFEROBJECTUI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryBufferObjectui64v"
  _gl::functions()\pointer = @GetQueryBufferObjectui64v
  _gl::functions()\version = 0
  Global GetQueryBufferObjectuiv._gl::PFNGLGETQUERYBUFFEROBJECTUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryBufferObjectuiv"
  _gl::functions()\pointer = @GetQueryBufferObjectuiv
  _gl::functions()\version = 0
  Global GetTextureImage._gl::PFNGLGETTEXTUREIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureImage"
  _gl::functions()\pointer = @GetTextureImage
  _gl::functions()\version = 0
  Global GetTextureLevelParameterfv._gl::PFNGLGETTEXTURELEVELPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureLevelParameterfv"
  _gl::functions()\pointer = @GetTextureLevelParameterfv
  _gl::functions()\version = 0
  Global GetTextureLevelParameteriv._gl::PFNGLGETTEXTURELEVELPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureLevelParameteriv"
  _gl::functions()\pointer = @GetTextureLevelParameteriv
  _gl::functions()\version = 0
  Global GetTextureParameterIiv._gl::PFNGLGETTEXTUREPARAMETERIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureParameterIiv"
  _gl::functions()\pointer = @GetTextureParameterIiv
  _gl::functions()\version = 0
  Global GetTextureParameterIuiv._gl::PFNGLGETTEXTUREPARAMETERIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureParameterIuiv"
  _gl::functions()\pointer = @GetTextureParameterIuiv
  _gl::functions()\version = 0
  Global GetTextureParameterfv._gl::PFNGLGETTEXTUREPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureParameterfv"
  _gl::functions()\pointer = @GetTextureParameterfv
  _gl::functions()\version = 0
  Global GetTextureParameteriv._gl::PFNGLGETTEXTUREPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureParameteriv"
  _gl::functions()\pointer = @GetTextureParameteriv
  _gl::functions()\version = 0
  Global GetTransformFeedbacki64_v._gl::PFNGLGETTRANSFORMFEEDBACKI64_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTransformFeedbacki64_v"
  _gl::functions()\pointer = @GetTransformFeedbacki64_v
  _gl::functions()\version = 0
  Global GetTransformFeedbacki_v._gl::PFNGLGETTRANSFORMFEEDBACKI_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTransformFeedbacki_v"
  _gl::functions()\pointer = @GetTransformFeedbacki_v
  _gl::functions()\version = 0
  Global GetTransformFeedbackiv._gl::PFNGLGETTRANSFORMFEEDBACKIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTransformFeedbackiv"
  _gl::functions()\pointer = @GetTransformFeedbackiv
  _gl::functions()\version = 0
  Global GetVertexArrayIndexed64iv._gl::PFNGLGETVERTEXARRAYINDEXED64IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexArrayIndexed64iv"
  _gl::functions()\pointer = @GetVertexArrayIndexed64iv
  _gl::functions()\version = 0
  Global GetVertexArrayIndexediv._gl::PFNGLGETVERTEXARRAYINDEXEDIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexArrayIndexediv"
  _gl::functions()\pointer = @GetVertexArrayIndexediv
  _gl::functions()\version = 0
  Global GetVertexArrayiv._gl::PFNGLGETVERTEXARRAYIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexArrayiv"
  _gl::functions()\pointer = @GetVertexArrayiv
  _gl::functions()\version = 0
  Global InvalidateNamedFramebufferData._gl::PFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateNamedFramebufferData"
  _gl::functions()\pointer = @InvalidateNamedFramebufferData
  _gl::functions()\version = 0
  Global InvalidateNamedFramebufferSubData._gl::PFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateNamedFramebufferSubData"
  _gl::functions()\pointer = @InvalidateNamedFramebufferSubData
  _gl::functions()\version = 0
  Global MapNamedBuffer._gl::PFNGLMAPNAMEDBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapNamedBuffer"
  _gl::functions()\pointer = @MapNamedBuffer
  _gl::functions()\version = 0
  Global MapNamedBufferRange._gl::PFNGLMAPNAMEDBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapNamedBufferRange"
  _gl::functions()\pointer = @MapNamedBufferRange
  _gl::functions()\version = 0
  Global NamedBufferData._gl::PFNGLNAMEDBUFFERDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedBufferData"
  _gl::functions()\pointer = @NamedBufferData
  _gl::functions()\version = 0
  Global NamedBufferStorage._gl::PFNGLNAMEDBUFFERSTORAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedBufferStorage"
  _gl::functions()\pointer = @NamedBufferStorage
  _gl::functions()\version = 0
  Global NamedBufferSubData._gl::PFNGLNAMEDBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedBufferSubData"
  _gl::functions()\pointer = @NamedBufferSubData
  _gl::functions()\version = 0
  Global NamedFramebufferDrawBuffer._gl::PFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferDrawBuffer"
  _gl::functions()\pointer = @NamedFramebufferDrawBuffer
  _gl::functions()\version = 0
  Global NamedFramebufferDrawBuffers._gl::PFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferDrawBuffers"
  _gl::functions()\pointer = @NamedFramebufferDrawBuffers
  _gl::functions()\version = 0
  Global NamedFramebufferParameteri._gl::PFNGLNAMEDFRAMEBUFFERPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferParameteri"
  _gl::functions()\pointer = @NamedFramebufferParameteri
  _gl::functions()\version = 0
  Global NamedFramebufferReadBuffer._gl::PFNGLNAMEDFRAMEBUFFERREADBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferReadBuffer"
  _gl::functions()\pointer = @NamedFramebufferReadBuffer
  _gl::functions()\version = 0
  Global NamedFramebufferRenderbuffer._gl::PFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferRenderbuffer"
  _gl::functions()\pointer = @NamedFramebufferRenderbuffer
  _gl::functions()\version = 0
  Global NamedFramebufferTexture._gl::PFNGLNAMEDFRAMEBUFFERTEXTUREPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferTexture"
  _gl::functions()\pointer = @NamedFramebufferTexture
  _gl::functions()\version = 0
  Global NamedFramebufferTextureLayer._gl::PFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedFramebufferTextureLayer"
  _gl::functions()\pointer = @NamedFramebufferTextureLayer
  _gl::functions()\version = 0
  Global NamedRenderbufferStorage._gl::PFNGLNAMEDRENDERBUFFERSTORAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedRenderbufferStorage"
  _gl::functions()\pointer = @NamedRenderbufferStorage
  _gl::functions()\version = 0
  Global NamedRenderbufferStorageMultisample._gl::PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNamedRenderbufferStorageMultisample"
  _gl::functions()\pointer = @NamedRenderbufferStorageMultisample
  _gl::functions()\version = 0
  Global TextureBuffer._gl::PFNGLTEXTUREBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureBuffer"
  _gl::functions()\pointer = @TextureBuffer
  _gl::functions()\version = 0
  Global TextureBufferRange._gl::PFNGLTEXTUREBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureBufferRange"
  _gl::functions()\pointer = @TextureBufferRange
  _gl::functions()\version = 0
  Global TextureParameterIiv._gl::PFNGLTEXTUREPARAMETERIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureParameterIiv"
  _gl::functions()\pointer = @TextureParameterIiv
  _gl::functions()\version = 0
  Global TextureParameterIuiv._gl::PFNGLTEXTUREPARAMETERIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureParameterIuiv"
  _gl::functions()\pointer = @TextureParameterIuiv
  _gl::functions()\version = 0
  Global TextureParameterf._gl::PFNGLTEXTUREPARAMETERFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureParameterf"
  _gl::functions()\pointer = @TextureParameterf
  _gl::functions()\version = 0
  Global TextureParameterfv._gl::PFNGLTEXTUREPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureParameterfv"
  _gl::functions()\pointer = @TextureParameterfv
  _gl::functions()\version = 0
  Global TextureParameteri._gl::PFNGLTEXTUREPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureParameteri"
  _gl::functions()\pointer = @TextureParameteri
  _gl::functions()\version = 0
  Global TextureParameteriv._gl::PFNGLTEXTUREPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureParameteriv"
  _gl::functions()\pointer = @TextureParameteriv
  _gl::functions()\version = 0
  Global TextureStorage1D._gl::PFNGLTEXTURESTORAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureStorage1D"
  _gl::functions()\pointer = @TextureStorage1D
  _gl::functions()\version = 0
  Global TextureStorage2D._gl::PFNGLTEXTURESTORAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureStorage2D"
  _gl::functions()\pointer = @TextureStorage2D
  _gl::functions()\version = 0
  Global TextureStorage2DMultisample._gl::PFNGLTEXTURESTORAGE2DMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureStorage2DMultisample"
  _gl::functions()\pointer = @TextureStorage2DMultisample
  _gl::functions()\version = 0
  Global TextureStorage3D._gl::PFNGLTEXTURESTORAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureStorage3D"
  _gl::functions()\pointer = @TextureStorage3D
  _gl::functions()\version = 0
  Global TextureStorage3DMultisample._gl::PFNGLTEXTURESTORAGE3DMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureStorage3DMultisample"
  _gl::functions()\pointer = @TextureStorage3DMultisample
  _gl::functions()\version = 0
  Global TextureSubImage1D._gl::PFNGLTEXTURESUBIMAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureSubImage1D"
  _gl::functions()\pointer = @TextureSubImage1D
  _gl::functions()\version = 0
  Global TextureSubImage2D._gl::PFNGLTEXTURESUBIMAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureSubImage2D"
  _gl::functions()\pointer = @TextureSubImage2D
  _gl::functions()\version = 0
  Global TextureSubImage3D._gl::PFNGLTEXTURESUBIMAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureSubImage3D"
  _gl::functions()\pointer = @TextureSubImage3D
  _gl::functions()\version = 0
  Global TransformFeedbackBufferBase._gl::PFNGLTRANSFORMFEEDBACKBUFFERBASEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTransformFeedbackBufferBase"
  _gl::functions()\pointer = @TransformFeedbackBufferBase
  _gl::functions()\version = 0
  Global TransformFeedbackBufferRange._gl::PFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTransformFeedbackBufferRange"
  _gl::functions()\pointer = @TransformFeedbackBufferRange
  _gl::functions()\version = 0
  Global UnmapNamedBuffer._gl::PFNGLUNMAPNAMEDBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUnmapNamedBuffer"
  _gl::functions()\pointer = @UnmapNamedBuffer
  _gl::functions()\version = 0
  Global VertexArrayAttribBinding._gl::PFNGLVERTEXARRAYATTRIBBINDINGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayAttribBinding"
  _gl::functions()\pointer = @VertexArrayAttribBinding
  _gl::functions()\version = 0
  Global VertexArrayAttribFormat._gl::PFNGLVERTEXARRAYATTRIBFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayAttribFormat"
  _gl::functions()\pointer = @VertexArrayAttribFormat
  _gl::functions()\version = 0
  Global VertexArrayAttribIFormat._gl::PFNGLVERTEXARRAYATTRIBIFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayAttribIFormat"
  _gl::functions()\pointer = @VertexArrayAttribIFormat
  _gl::functions()\version = 0
  Global VertexArrayAttribLFormat._gl::PFNGLVERTEXARRAYATTRIBLFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayAttribLFormat"
  _gl::functions()\pointer = @VertexArrayAttribLFormat
  _gl::functions()\version = 0
  Global VertexArrayBindingDivisor._gl::PFNGLVERTEXARRAYBINDINGDIVISORPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayBindingDivisor"
  _gl::functions()\pointer = @VertexArrayBindingDivisor
  _gl::functions()\version = 0
  Global VertexArrayElementBuffer._gl::PFNGLVERTEXARRAYELEMENTBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayElementBuffer"
  _gl::functions()\pointer = @VertexArrayElementBuffer
  _gl::functions()\version = 0
  Global VertexArrayVertexBuffer._gl::PFNGLVERTEXARRAYVERTEXBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayVertexBuffer"
  _gl::functions()\pointer = @VertexArrayVertexBuffer
  _gl::functions()\version = 0
  Global VertexArrayVertexBuffers._gl::PFNGLVERTEXARRAYVERTEXBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexArrayVertexBuffers"
  _gl::functions()\pointer = @VertexArrayVertexBuffers
  _gl::functions()\version = 0
  Global DrawElementsBaseVertex._gl::PFNGLDRAWELEMENTSBASEVERTEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElementsBaseVertex"
  _gl::functions()\pointer = @DrawElementsBaseVertex
  _gl::functions()\version = 0
  Global DrawElementsInstancedBaseVertex._gl::PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElementsInstancedBaseVertex"
  _gl::functions()\pointer = @DrawElementsInstancedBaseVertex
  _gl::functions()\version = 0
  Global DrawRangeElementsBaseVertex._gl::PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawRangeElementsBaseVertex"
  _gl::functions()\pointer = @DrawRangeElementsBaseVertex
  _gl::functions()\version = 0
  Global MultiDrawElementsBaseVertex._gl::PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawElementsBaseVertex"
  _gl::functions()\pointer = @MultiDrawElementsBaseVertex
  _gl::functions()\version = 0
  Global DrawArraysIndirect._gl::PFNGLDRAWARRAYSINDIRECTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawArraysIndirect"
  _gl::functions()\pointer = @DrawArraysIndirect
  _gl::functions()\version = 0
  Global DrawElementsIndirect._gl::PFNGLDRAWELEMENTSINDIRECTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawElementsIndirect"
  _gl::functions()\pointer = @DrawElementsIndirect
  _gl::functions()\version = 0
  Global FramebufferParameteri._gl::PFNGLFRAMEBUFFERPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferParameteri"
  _gl::functions()\pointer = @FramebufferParameteri
  _gl::functions()\version = 0
  Global GetFramebufferParameteriv._gl::PFNGLGETFRAMEBUFFERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFramebufferParameteriv"
  _gl::functions()\pointer = @GetFramebufferParameteriv
  _gl::functions()\version = 0
  Global BindFramebuffer._gl::PFNGLBINDFRAMEBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindFramebuffer"
  _gl::functions()\pointer = @BindFramebuffer
  _gl::functions()\version = 0
  Global BindRenderbuffer._gl::PFNGLBINDRENDERBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindRenderbuffer"
  _gl::functions()\pointer = @BindRenderbuffer
  _gl::functions()\version = 0
  Global BlitFramebuffer._gl::PFNGLBLITFRAMEBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBlitFramebuffer"
  _gl::functions()\pointer = @BlitFramebuffer
  _gl::functions()\version = 0
  Global CheckFramebufferStatus._gl::PFNGLCHECKFRAMEBUFFERSTATUSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCheckFramebufferStatus"
  _gl::functions()\pointer = @CheckFramebufferStatus
  _gl::functions()\version = 0
  Global DeleteFramebuffers._gl::PFNGLDELETEFRAMEBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteFramebuffers"
  _gl::functions()\pointer = @DeleteFramebuffers
  _gl::functions()\version = 0
  Global DeleteRenderbuffers._gl::PFNGLDELETERENDERBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteRenderbuffers"
  _gl::functions()\pointer = @DeleteRenderbuffers
  _gl::functions()\version = 0
  Global FramebufferRenderbuffer._gl::PFNGLFRAMEBUFFERRENDERBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferRenderbuffer"
  _gl::functions()\pointer = @FramebufferRenderbuffer
  _gl::functions()\version = 0
  Global FramebufferTexture1D._gl::PFNGLFRAMEBUFFERTEXTURE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferTexture1D"
  _gl::functions()\pointer = @FramebufferTexture1D
  _gl::functions()\version = 0
  Global FramebufferTexture2D._gl::PFNGLFRAMEBUFFERTEXTURE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferTexture2D"
  _gl::functions()\pointer = @FramebufferTexture2D
  _gl::functions()\version = 0
  Global FramebufferTexture3D._gl::PFNGLFRAMEBUFFERTEXTURE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferTexture3D"
  _gl::functions()\pointer = @FramebufferTexture3D
  _gl::functions()\version = 0
  Global FramebufferTextureLayer._gl::PFNGLFRAMEBUFFERTEXTURELAYERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFramebufferTextureLayer"
  _gl::functions()\pointer = @FramebufferTextureLayer
  _gl::functions()\version = 0
  Global GenFramebuffers._gl::PFNGLGENFRAMEBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenFramebuffers"
  _gl::functions()\pointer = @GenFramebuffers
  _gl::functions()\version = 0
  Global GenRenderbuffers._gl::PFNGLGENRENDERBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenRenderbuffers"
  _gl::functions()\pointer = @GenRenderbuffers
  _gl::functions()\version = 0
  Global GenerateMipmap._gl::PFNGLGENERATEMIPMAPPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenerateMipmap"
  _gl::functions()\pointer = @GenerateMipmap
  _gl::functions()\version = 0
  Global GetFramebufferAttachmentParameteriv._gl::PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFramebufferAttachmentParameteriv"
  _gl::functions()\pointer = @GetFramebufferAttachmentParameteriv
  _gl::functions()\version = 0
  Global GetRenderbufferParameteriv._gl::PFNGLGETRENDERBUFFERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetRenderbufferParameteriv"
  _gl::functions()\pointer = @GetRenderbufferParameteriv
  _gl::functions()\version = 0
  Global IsFramebuffer._gl::PFNGLISFRAMEBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsFramebuffer"
  _gl::functions()\pointer = @IsFramebuffer
  _gl::functions()\version = 0
  Global IsRenderbuffer._gl::PFNGLISRENDERBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsRenderbuffer"
  _gl::functions()\pointer = @IsRenderbuffer
  _gl::functions()\version = 0
  Global RenderbufferStorage._gl::PFNGLRENDERBUFFERSTORAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRenderbufferStorage"
  _gl::functions()\pointer = @RenderbufferStorage
  _gl::functions()\version = 0
  Global RenderbufferStorageMultisample._gl::PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRenderbufferStorageMultisample"
  _gl::functions()\pointer = @RenderbufferStorageMultisample
  _gl::functions()\version = 0
  Global GetProgramBinary._gl::PFNGLGETPROGRAMBINARYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramBinary"
  _gl::functions()\pointer = @GetProgramBinary
  _gl::functions()\version = 0
  Global ProgramBinary._gl::PFNGLPROGRAMBINARYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramBinary"
  _gl::functions()\pointer = @ProgramBinary
  _gl::functions()\version = 0
  Global ProgramParameteri._gl::PFNGLPROGRAMPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramParameteri"
  _gl::functions()\pointer = @ProgramParameteri
  _gl::functions()\version = 0
  Global GetCompressedTextureSubImage._gl::PFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetCompressedTextureSubImage"
  _gl::functions()\pointer = @GetCompressedTextureSubImage
  _gl::functions()\version = 0
  Global GetTextureSubImage._gl::PFNGLGETTEXTURESUBIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTextureSubImage"
  _gl::functions()\pointer = @GetTextureSubImage
  _gl::functions()\version = 0
  Global GetUniformdv._gl::PFNGLGETUNIFORMDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformdv"
  _gl::functions()\pointer = @GetUniformdv
  _gl::functions()\version = 0
  Global Uniform1d._gl::PFNGLUNIFORM1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1d"
  _gl::functions()\pointer = @Uniform1d
  _gl::functions()\version = 0
  Global Uniform1dv._gl::PFNGLUNIFORM1DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform1dv"
  _gl::functions()\pointer = @Uniform1dv
  _gl::functions()\version = 0
  Global Uniform2d._gl::PFNGLUNIFORM2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2d"
  _gl::functions()\pointer = @Uniform2d
  _gl::functions()\version = 0
  Global Uniform2dv._gl::PFNGLUNIFORM2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform2dv"
  _gl::functions()\pointer = @Uniform2dv
  _gl::functions()\version = 0
  Global Uniform3d._gl::PFNGLUNIFORM3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3d"
  _gl::functions()\pointer = @Uniform3d
  _gl::functions()\version = 0
  Global Uniform3dv._gl::PFNGLUNIFORM3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform3dv"
  _gl::functions()\pointer = @Uniform3dv
  _gl::functions()\version = 0
  Global Uniform4d._gl::PFNGLUNIFORM4DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4d"
  _gl::functions()\pointer = @Uniform4d
  _gl::functions()\version = 0
  Global Uniform4dv._gl::PFNGLUNIFORM4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniform4dv"
  _gl::functions()\pointer = @Uniform4dv
  _gl::functions()\version = 0
  Global UniformMatrix2dv._gl::PFNGLUNIFORMMATRIX2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix2dv"
  _gl::functions()\pointer = @UniformMatrix2dv
  _gl::functions()\version = 0
  Global UniformMatrix2x3dv._gl::PFNGLUNIFORMMATRIX2X3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix2x3dv"
  _gl::functions()\pointer = @UniformMatrix2x3dv
  _gl::functions()\version = 0
  Global UniformMatrix2x4dv._gl::PFNGLUNIFORMMATRIX2X4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix2x4dv"
  _gl::functions()\pointer = @UniformMatrix2x4dv
  _gl::functions()\version = 0
  Global UniformMatrix3dv._gl::PFNGLUNIFORMMATRIX3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix3dv"
  _gl::functions()\pointer = @UniformMatrix3dv
  _gl::functions()\version = 0
  Global UniformMatrix3x2dv._gl::PFNGLUNIFORMMATRIX3X2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix3x2dv"
  _gl::functions()\pointer = @UniformMatrix3x2dv
  _gl::functions()\version = 0
  Global UniformMatrix3x4dv._gl::PFNGLUNIFORMMATRIX3X4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix3x4dv"
  _gl::functions()\pointer = @UniformMatrix3x4dv
  _gl::functions()\version = 0
  Global UniformMatrix4dv._gl::PFNGLUNIFORMMATRIX4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix4dv"
  _gl::functions()\pointer = @UniformMatrix4dv
  _gl::functions()\version = 0
  Global UniformMatrix4x2dv._gl::PFNGLUNIFORMMATRIX4X2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix4x2dv"
  _gl::functions()\pointer = @UniformMatrix4x2dv
  _gl::functions()\version = 0
  Global UniformMatrix4x3dv._gl::PFNGLUNIFORMMATRIX4X3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformMatrix4x3dv"
  _gl::functions()\pointer = @UniformMatrix4x3dv
  _gl::functions()\version = 0
  Global ColorSubTable._gl::PFNGLCOLORSUBTABLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorSubTable"
  _gl::functions()\pointer = @ColorSubTable
  _gl::functions()\version = 0
  Global ColorTable._gl::PFNGLCOLORTABLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorTable"
  _gl::functions()\pointer = @ColorTable
  _gl::functions()\version = 0
  Global ColorTableParameterfv._gl::PFNGLCOLORTABLEPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorTableParameterfv"
  _gl::functions()\pointer = @ColorTableParameterfv
  _gl::functions()\version = 0
  Global ColorTableParameteriv._gl::PFNGLCOLORTABLEPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorTableParameteriv"
  _gl::functions()\pointer = @ColorTableParameteriv
  _gl::functions()\version = 0
  Global ConvolutionFilter1D._gl::PFNGLCONVOLUTIONFILTER1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glConvolutionFilter1D"
  _gl::functions()\pointer = @ConvolutionFilter1D
  _gl::functions()\version = 0
  Global ConvolutionFilter2D._gl::PFNGLCONVOLUTIONFILTER2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glConvolutionFilter2D"
  _gl::functions()\pointer = @ConvolutionFilter2D
  _gl::functions()\version = 0
  Global ConvolutionParameterf._gl::PFNGLCONVOLUTIONPARAMETERFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glConvolutionParameterf"
  _gl::functions()\pointer = @ConvolutionParameterf
  _gl::functions()\version = 0
  Global ConvolutionParameterfv._gl::PFNGLCONVOLUTIONPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glConvolutionParameterfv"
  _gl::functions()\pointer = @ConvolutionParameterfv
  _gl::functions()\version = 0
  Global ConvolutionParameteri._gl::PFNGLCONVOLUTIONPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glConvolutionParameteri"
  _gl::functions()\pointer = @ConvolutionParameteri
  _gl::functions()\version = 0
  Global ConvolutionParameteriv._gl::PFNGLCONVOLUTIONPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glConvolutionParameteriv"
  _gl::functions()\pointer = @ConvolutionParameteriv
  _gl::functions()\version = 0
  Global CopyColorSubTable._gl::PFNGLCOPYCOLORSUBTABLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyColorSubTable"
  _gl::functions()\pointer = @CopyColorSubTable
  _gl::functions()\version = 0
  Global CopyColorTable._gl::PFNGLCOPYCOLORTABLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyColorTable"
  _gl::functions()\pointer = @CopyColorTable
  _gl::functions()\version = 0
  Global CopyConvolutionFilter1D._gl::PFNGLCOPYCONVOLUTIONFILTER1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyConvolutionFilter1D"
  _gl::functions()\pointer = @CopyConvolutionFilter1D
  _gl::functions()\version = 0
  Global CopyConvolutionFilter2D._gl::PFNGLCOPYCONVOLUTIONFILTER2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCopyConvolutionFilter2D"
  _gl::functions()\pointer = @CopyConvolutionFilter2D
  _gl::functions()\version = 0
  Global GetColorTable._gl::PFNGLGETCOLORTABLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetColorTable"
  _gl::functions()\pointer = @GetColorTable
  _gl::functions()\version = 0
  Global GetColorTableParameterfv._gl::PFNGLGETCOLORTABLEPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetColorTableParameterfv"
  _gl::functions()\pointer = @GetColorTableParameterfv
  _gl::functions()\version = 0
  Global GetColorTableParameteriv._gl::PFNGLGETCOLORTABLEPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetColorTableParameteriv"
  _gl::functions()\pointer = @GetColorTableParameteriv
  _gl::functions()\version = 0
  Global GetConvolutionFilter._gl::PFNGLGETCONVOLUTIONFILTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetConvolutionFilter"
  _gl::functions()\pointer = @GetConvolutionFilter
  _gl::functions()\version = 0
  Global GetConvolutionParameterfv._gl::PFNGLGETCONVOLUTIONPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetConvolutionParameterfv"
  _gl::functions()\pointer = @GetConvolutionParameterfv
  _gl::functions()\version = 0
  Global GetConvolutionParameteriv._gl::PFNGLGETCONVOLUTIONPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetConvolutionParameteriv"
  _gl::functions()\pointer = @GetConvolutionParameteriv
  _gl::functions()\version = 0
  Global GetHistogram._gl::PFNGLGETHISTOGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetHistogram"
  _gl::functions()\pointer = @GetHistogram
  _gl::functions()\version = 0
  Global GetHistogramParameterfv._gl::PFNGLGETHISTOGRAMPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetHistogramParameterfv"
  _gl::functions()\pointer = @GetHistogramParameterfv
  _gl::functions()\version = 0
  Global GetHistogramParameteriv._gl::PFNGLGETHISTOGRAMPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetHistogramParameteriv"
  _gl::functions()\pointer = @GetHistogramParameteriv
  _gl::functions()\version = 0
  Global GetMinmax._gl::PFNGLGETMINMAXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMinmax"
  _gl::functions()\pointer = @GetMinmax
  _gl::functions()\version = 0
  Global GetMinmaxParameterfv._gl::PFNGLGETMINMAXPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMinmaxParameterfv"
  _gl::functions()\pointer = @GetMinmaxParameterfv
  _gl::functions()\version = 0
  Global GetMinmaxParameteriv._gl::PFNGLGETMINMAXPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMinmaxParameteriv"
  _gl::functions()\pointer = @GetMinmaxParameteriv
  _gl::functions()\version = 0
  Global GetSeparableFilter._gl::PFNGLGETSEPARABLEFILTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSeparableFilter"
  _gl::functions()\pointer = @GetSeparableFilter
  _gl::functions()\version = 0
  Global Histogram._gl::PFNGLHISTOGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glHistogram"
  _gl::functions()\pointer = @Histogram
  _gl::functions()\version = 0
  Global Minmax._gl::PFNGLMINMAXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMinmax"
  _gl::functions()\pointer = @Minmax
  _gl::functions()\version = 0
  Global ResetHistogram._gl::PFNGLRESETHISTOGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glResetHistogram"
  _gl::functions()\pointer = @ResetHistogram
  _gl::functions()\version = 0
  Global ResetMinmax._gl::PFNGLRESETMINMAXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glResetMinmax"
  _gl::functions()\pointer = @ResetMinmax
  _gl::functions()\version = 0
  Global SeparableFilter2D._gl::PFNGLSEPARABLEFILTER2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSeparableFilter2D"
  _gl::functions()\pointer = @SeparableFilter2D
  _gl::functions()\version = 0
  Global GetInternalformativ._gl::PFNGLGETINTERNALFORMATIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetInternalformativ"
  _gl::functions()\pointer = @GetInternalformativ
  _gl::functions()\version = 0
  Global GetInternalformati64v._gl::PFNGLGETINTERNALFORMATI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetInternalformati64v"
  _gl::functions()\pointer = @GetInternalformati64v
  _gl::functions()\version = 0
  Global InvalidateBufferData._gl::PFNGLINVALIDATEBUFFERDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateBufferData"
  _gl::functions()\pointer = @InvalidateBufferData
  _gl::functions()\version = 0
  Global InvalidateBufferSubData._gl::PFNGLINVALIDATEBUFFERSUBDATAPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateBufferSubData"
  _gl::functions()\pointer = @InvalidateBufferSubData
  _gl::functions()\version = 0
  Global InvalidateFramebuffer._gl::PFNGLINVALIDATEFRAMEBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateFramebuffer"
  _gl::functions()\pointer = @InvalidateFramebuffer
  _gl::functions()\version = 0
  Global InvalidateSubFramebuffer._gl::PFNGLINVALIDATESUBFRAMEBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateSubFramebuffer"
  _gl::functions()\pointer = @InvalidateSubFramebuffer
  _gl::functions()\version = 0
  Global InvalidateTexImage._gl::PFNGLINVALIDATETEXIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateTexImage"
  _gl::functions()\pointer = @InvalidateTexImage
  _gl::functions()\version = 0
  Global InvalidateTexSubImage._gl::PFNGLINVALIDATETEXSUBIMAGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glInvalidateTexSubImage"
  _gl::functions()\pointer = @InvalidateTexSubImage
  _gl::functions()\version = 0
  Global FlushMappedBufferRange._gl::PFNGLFLUSHMAPPEDBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFlushMappedBufferRange"
  _gl::functions()\pointer = @FlushMappedBufferRange
  _gl::functions()\version = 0
  Global MapBufferRange._gl::PFNGLMAPBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMapBufferRange"
  _gl::functions()\pointer = @MapBufferRange
  _gl::functions()\version = 0
  Global BindBuffersBase._gl::PFNGLBINDBUFFERSBASEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindBuffersBase"
  _gl::functions()\pointer = @BindBuffersBase
  _gl::functions()\version = 0
  Global BindBuffersRange._gl::PFNGLBINDBUFFERSRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindBuffersRange"
  _gl::functions()\pointer = @BindBuffersRange
  _gl::functions()\version = 0
  Global BindImageTextures._gl::PFNGLBINDIMAGETEXTURESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindImageTextures"
  _gl::functions()\pointer = @BindImageTextures
  _gl::functions()\version = 0
  Global BindSamplers._gl::PFNGLBINDSAMPLERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindSamplers"
  _gl::functions()\pointer = @BindSamplers
  _gl::functions()\version = 0
  Global BindTextures._gl::PFNGLBINDTEXTURESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindTextures"
  _gl::functions()\pointer = @BindTextures
  _gl::functions()\version = 0
  Global BindVertexBuffers._gl::PFNGLBINDVERTEXBUFFERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindVertexBuffers"
  _gl::functions()\pointer = @BindVertexBuffers
  _gl::functions()\version = 0
  Global MultiDrawArraysIndirect._gl::PFNGLMULTIDRAWARRAYSINDIRECTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawArraysIndirect"
  _gl::functions()\pointer = @MultiDrawArraysIndirect
  _gl::functions()\version = 0
  Global MultiDrawElementsIndirect._gl::PFNGLMULTIDRAWELEMENTSINDIRECTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiDrawElementsIndirect"
  _gl::functions()\pointer = @MultiDrawElementsIndirect
  _gl::functions()\version = 0
  Global PolygonOffsetClamp._gl::PFNGLPOLYGONOFFSETCLAMPPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPolygonOffsetClamp"
  _gl::functions()\pointer = @PolygonOffsetClamp
  _gl::functions()\version = 0
  Global GetProgramInterfaceiv._gl::PFNGLGETPROGRAMINTERFACEIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramInterfaceiv"
  _gl::functions()\pointer = @GetProgramInterfaceiv
  _gl::functions()\version = 0
  Global GetProgramResourceIndex._gl::PFNGLGETPROGRAMRESOURCEINDEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramResourceIndex"
  _gl::functions()\pointer = @GetProgramResourceIndex
  _gl::functions()\version = 0
  Global GetProgramResourceLocation._gl::PFNGLGETPROGRAMRESOURCELOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramResourceLocation"
  _gl::functions()\pointer = @GetProgramResourceLocation
  _gl::functions()\version = 0
  Global GetProgramResourceLocationIndex._gl::PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramResourceLocationIndex"
  _gl::functions()\pointer = @GetProgramResourceLocationIndex
  _gl::functions()\version = 0
  Global GetProgramResourceName._gl::PFNGLGETPROGRAMRESOURCENAMEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramResourceName"
  _gl::functions()\pointer = @GetProgramResourceName
  _gl::functions()\version = 0
  Global GetProgramResourceiv._gl::PFNGLGETPROGRAMRESOURCEIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramResourceiv"
  _gl::functions()\pointer = @GetProgramResourceiv
  _gl::functions()\version = 0
  Global ProvokingVertex._gl::PFNGLPROVOKINGVERTEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProvokingVertex"
  _gl::functions()\pointer = @ProvokingVertex
  _gl::functions()\version = 0
  Global BindSampler._gl::PFNGLBINDSAMPLERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindSampler"
  _gl::functions()\pointer = @BindSampler
  _gl::functions()\version = 0
  Global DeleteSamplers._gl::PFNGLDELETESAMPLERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteSamplers"
  _gl::functions()\pointer = @DeleteSamplers
  _gl::functions()\version = 0
  Global GenSamplers._gl::PFNGLGENSAMPLERSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenSamplers"
  _gl::functions()\pointer = @GenSamplers
  _gl::functions()\version = 0
  Global GetSamplerParameterIiv._gl::PFNGLGETSAMPLERPARAMETERIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSamplerParameterIiv"
  _gl::functions()\pointer = @GetSamplerParameterIiv
  _gl::functions()\version = 0
  Global GetSamplerParameterIuiv._gl::PFNGLGETSAMPLERPARAMETERIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSamplerParameterIuiv"
  _gl::functions()\pointer = @GetSamplerParameterIuiv
  _gl::functions()\version = 0
  Global GetSamplerParameterfv._gl::PFNGLGETSAMPLERPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSamplerParameterfv"
  _gl::functions()\pointer = @GetSamplerParameterfv
  _gl::functions()\version = 0
  Global GetSamplerParameteriv._gl::PFNGLGETSAMPLERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSamplerParameteriv"
  _gl::functions()\pointer = @GetSamplerParameteriv
  _gl::functions()\version = 0
  Global IsSampler._gl::PFNGLISSAMPLERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsSampler"
  _gl::functions()\pointer = @IsSampler
  _gl::functions()\version = 0
  Global SamplerParameterIiv._gl::PFNGLSAMPLERPARAMETERIIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSamplerParameterIiv"
  _gl::functions()\pointer = @SamplerParameterIiv
  _gl::functions()\version = 0
  Global SamplerParameterIuiv._gl::PFNGLSAMPLERPARAMETERIUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSamplerParameterIuiv"
  _gl::functions()\pointer = @SamplerParameterIuiv
  _gl::functions()\version = 0
  Global SamplerParameterf._gl::PFNGLSAMPLERPARAMETERFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSamplerParameterf"
  _gl::functions()\pointer = @SamplerParameterf
  _gl::functions()\version = 0
  Global SamplerParameterfv._gl::PFNGLSAMPLERPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSamplerParameterfv"
  _gl::functions()\pointer = @SamplerParameterfv
  _gl::functions()\version = 0
  Global SamplerParameteri._gl::PFNGLSAMPLERPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSamplerParameteri"
  _gl::functions()\pointer = @SamplerParameteri
  _gl::functions()\version = 0
  Global SamplerParameteriv._gl::PFNGLSAMPLERPARAMETERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSamplerParameteriv"
  _gl::functions()\pointer = @SamplerParameteriv
  _gl::functions()\version = 0
  Global ActiveShaderProgram._gl::PFNGLACTIVESHADERPROGRAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glActiveShaderProgram"
  _gl::functions()\pointer = @ActiveShaderProgram
  _gl::functions()\version = 0
  Global BindProgramPipeline._gl::PFNGLBINDPROGRAMPIPELINEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindProgramPipeline"
  _gl::functions()\pointer = @BindProgramPipeline
  _gl::functions()\version = 0
  Global CreateShaderProgramv._gl::PFNGLCREATESHADERPROGRAMVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateShaderProgramv"
  _gl::functions()\pointer = @CreateShaderProgramv
  _gl::functions()\version = 0
  Global DeleteProgramPipelines._gl::PFNGLDELETEPROGRAMPIPELINESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteProgramPipelines"
  _gl::functions()\pointer = @DeleteProgramPipelines
  _gl::functions()\version = 0
  Global GenProgramPipelines._gl::PFNGLGENPROGRAMPIPELINESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenProgramPipelines"
  _gl::functions()\pointer = @GenProgramPipelines
  _gl::functions()\version = 0
  Global GetProgramPipelineInfoLog._gl::PFNGLGETPROGRAMPIPELINEINFOLOGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramPipelineInfoLog"
  _gl::functions()\pointer = @GetProgramPipelineInfoLog
  _gl::functions()\version = 0
  Global GetProgramPipelineiv._gl::PFNGLGETPROGRAMPIPELINEIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramPipelineiv"
  _gl::functions()\pointer = @GetProgramPipelineiv
  _gl::functions()\version = 0
  Global IsProgramPipeline._gl::PFNGLISPROGRAMPIPELINEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsProgramPipeline"
  _gl::functions()\pointer = @IsProgramPipeline
  _gl::functions()\version = 0
  Global ProgramUniform1d._gl::PFNGLPROGRAMUNIFORM1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1d"
  _gl::functions()\pointer = @ProgramUniform1d
  _gl::functions()\version = 0
  Global ProgramUniform1dv._gl::PFNGLPROGRAMUNIFORM1DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1dv"
  _gl::functions()\pointer = @ProgramUniform1dv
  _gl::functions()\version = 0
  Global ProgramUniform1f._gl::PFNGLPROGRAMUNIFORM1FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1f"
  _gl::functions()\pointer = @ProgramUniform1f
  _gl::functions()\version = 0
  Global ProgramUniform1fv._gl::PFNGLPROGRAMUNIFORM1FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1fv"
  _gl::functions()\pointer = @ProgramUniform1fv
  _gl::functions()\version = 0
  Global ProgramUniform1i._gl::PFNGLPROGRAMUNIFORM1IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1i"
  _gl::functions()\pointer = @ProgramUniform1i
  _gl::functions()\version = 0
  Global ProgramUniform1iv._gl::PFNGLPROGRAMUNIFORM1IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1iv"
  _gl::functions()\pointer = @ProgramUniform1iv
  _gl::functions()\version = 0
  Global ProgramUniform1ui._gl::PFNGLPROGRAMUNIFORM1UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1ui"
  _gl::functions()\pointer = @ProgramUniform1ui
  _gl::functions()\version = 0
  Global ProgramUniform1uiv._gl::PFNGLPROGRAMUNIFORM1UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform1uiv"
  _gl::functions()\pointer = @ProgramUniform1uiv
  _gl::functions()\version = 0
  Global ProgramUniform2d._gl::PFNGLPROGRAMUNIFORM2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2d"
  _gl::functions()\pointer = @ProgramUniform2d
  _gl::functions()\version = 0
  Global ProgramUniform2dv._gl::PFNGLPROGRAMUNIFORM2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2dv"
  _gl::functions()\pointer = @ProgramUniform2dv
  _gl::functions()\version = 0
  Global ProgramUniform2f._gl::PFNGLPROGRAMUNIFORM2FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2f"
  _gl::functions()\pointer = @ProgramUniform2f
  _gl::functions()\version = 0
  Global ProgramUniform2fv._gl::PFNGLPROGRAMUNIFORM2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2fv"
  _gl::functions()\pointer = @ProgramUniform2fv
  _gl::functions()\version = 0
  Global ProgramUniform2i._gl::PFNGLPROGRAMUNIFORM2IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2i"
  _gl::functions()\pointer = @ProgramUniform2i
  _gl::functions()\version = 0
  Global ProgramUniform2iv._gl::PFNGLPROGRAMUNIFORM2IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2iv"
  _gl::functions()\pointer = @ProgramUniform2iv
  _gl::functions()\version = 0
  Global ProgramUniform2ui._gl::PFNGLPROGRAMUNIFORM2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2ui"
  _gl::functions()\pointer = @ProgramUniform2ui
  _gl::functions()\version = 0
  Global ProgramUniform2uiv._gl::PFNGLPROGRAMUNIFORM2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform2uiv"
  _gl::functions()\pointer = @ProgramUniform2uiv
  _gl::functions()\version = 0
  Global ProgramUniform3d._gl::PFNGLPROGRAMUNIFORM3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3d"
  _gl::functions()\pointer = @ProgramUniform3d
  _gl::functions()\version = 0
  Global ProgramUniform3dv._gl::PFNGLPROGRAMUNIFORM3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3dv"
  _gl::functions()\pointer = @ProgramUniform3dv
  _gl::functions()\version = 0
  Global ProgramUniform3f._gl::PFNGLPROGRAMUNIFORM3FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3f"
  _gl::functions()\pointer = @ProgramUniform3f
  _gl::functions()\version = 0
  Global ProgramUniform3fv._gl::PFNGLPROGRAMUNIFORM3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3fv"
  _gl::functions()\pointer = @ProgramUniform3fv
  _gl::functions()\version = 0
  Global ProgramUniform3i._gl::PFNGLPROGRAMUNIFORM3IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3i"
  _gl::functions()\pointer = @ProgramUniform3i
  _gl::functions()\version = 0
  Global ProgramUniform3iv._gl::PFNGLPROGRAMUNIFORM3IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3iv"
  _gl::functions()\pointer = @ProgramUniform3iv
  _gl::functions()\version = 0
  Global ProgramUniform3ui._gl::PFNGLPROGRAMUNIFORM3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3ui"
  _gl::functions()\pointer = @ProgramUniform3ui
  _gl::functions()\version = 0
  Global ProgramUniform3uiv._gl::PFNGLPROGRAMUNIFORM3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform3uiv"
  _gl::functions()\pointer = @ProgramUniform3uiv
  _gl::functions()\version = 0
  Global ProgramUniform4d._gl::PFNGLPROGRAMUNIFORM4DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4d"
  _gl::functions()\pointer = @ProgramUniform4d
  _gl::functions()\version = 0
  Global ProgramUniform4dv._gl::PFNGLPROGRAMUNIFORM4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4dv"
  _gl::functions()\pointer = @ProgramUniform4dv
  _gl::functions()\version = 0
  Global ProgramUniform4f._gl::PFNGLPROGRAMUNIFORM4FPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4f"
  _gl::functions()\pointer = @ProgramUniform4f
  _gl::functions()\version = 0
  Global ProgramUniform4fv._gl::PFNGLPROGRAMUNIFORM4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4fv"
  _gl::functions()\pointer = @ProgramUniform4fv
  _gl::functions()\version = 0
  Global ProgramUniform4i._gl::PFNGLPROGRAMUNIFORM4IPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4i"
  _gl::functions()\pointer = @ProgramUniform4i
  _gl::functions()\version = 0
  Global ProgramUniform4iv._gl::PFNGLPROGRAMUNIFORM4IVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4iv"
  _gl::functions()\pointer = @ProgramUniform4iv
  _gl::functions()\version = 0
  Global ProgramUniform4ui._gl::PFNGLPROGRAMUNIFORM4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4ui"
  _gl::functions()\pointer = @ProgramUniform4ui
  _gl::functions()\version = 0
  Global ProgramUniform4uiv._gl::PFNGLPROGRAMUNIFORM4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniform4uiv"
  _gl::functions()\pointer = @ProgramUniform4uiv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix2dv._gl::PFNGLPROGRAMUNIFORMMATRIX2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix2dv"
  _gl::functions()\pointer = @ProgramUniformMatrix2dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix2fv._gl::PFNGLPROGRAMUNIFORMMATRIX2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix2fv"
  _gl::functions()\pointer = @ProgramUniformMatrix2fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix2x3dv._gl::PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix2x3dv"
  _gl::functions()\pointer = @ProgramUniformMatrix2x3dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix2x3fv._gl::PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix2x3fv"
  _gl::functions()\pointer = @ProgramUniformMatrix2x3fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix2x4dv._gl::PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix2x4dv"
  _gl::functions()\pointer = @ProgramUniformMatrix2x4dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix2x4fv._gl::PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix2x4fv"
  _gl::functions()\pointer = @ProgramUniformMatrix2x4fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix3dv._gl::PFNGLPROGRAMUNIFORMMATRIX3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix3dv"
  _gl::functions()\pointer = @ProgramUniformMatrix3dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix3fv._gl::PFNGLPROGRAMUNIFORMMATRIX3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix3fv"
  _gl::functions()\pointer = @ProgramUniformMatrix3fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix3x2dv._gl::PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix3x2dv"
  _gl::functions()\pointer = @ProgramUniformMatrix3x2dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix3x2fv._gl::PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix3x2fv"
  _gl::functions()\pointer = @ProgramUniformMatrix3x2fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix3x4dv._gl::PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix3x4dv"
  _gl::functions()\pointer = @ProgramUniformMatrix3x4dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix3x4fv._gl::PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix3x4fv"
  _gl::functions()\pointer = @ProgramUniformMatrix3x4fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix4dv._gl::PFNGLPROGRAMUNIFORMMATRIX4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix4dv"
  _gl::functions()\pointer = @ProgramUniformMatrix4dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix4fv._gl::PFNGLPROGRAMUNIFORMMATRIX4FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix4fv"
  _gl::functions()\pointer = @ProgramUniformMatrix4fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix4x2dv._gl::PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix4x2dv"
  _gl::functions()\pointer = @ProgramUniformMatrix4x2dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix4x2fv._gl::PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix4x2fv"
  _gl::functions()\pointer = @ProgramUniformMatrix4x2fv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix4x3dv._gl::PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix4x3dv"
  _gl::functions()\pointer = @ProgramUniformMatrix4x3dv
  _gl::functions()\version = 0
  Global ProgramUniformMatrix4x3fv._gl::PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glProgramUniformMatrix4x3fv"
  _gl::functions()\pointer = @ProgramUniformMatrix4x3fv
  _gl::functions()\version = 0
  Global UseProgramStages._gl::PFNGLUSEPROGRAMSTAGESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUseProgramStages"
  _gl::functions()\pointer = @UseProgramStages
  _gl::functions()\version = 0
  Global ValidateProgramPipeline._gl::PFNGLVALIDATEPROGRAMPIPELINEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glValidateProgramPipeline"
  _gl::functions()\pointer = @ValidateProgramPipeline
  _gl::functions()\version = 0
  Global GetActiveAtomicCounterBufferiv._gl::PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveAtomicCounterBufferiv"
  _gl::functions()\pointer = @GetActiveAtomicCounterBufferiv
  _gl::functions()\version = 0
  Global BindImageTexture._gl::PFNGLBINDIMAGETEXTUREPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindImageTexture"
  _gl::functions()\pointer = @BindImageTexture
  _gl::functions()\version = 0
  Global MemoryBarrier._gl::PFNGLMEMORYBARRIERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMemoryBarrier"
  _gl::functions()\pointer = @MemoryBarrier
  _gl::functions()\version = 0
  Global ShaderStorageBlockBinding._gl::PFNGLSHADERSTORAGEBLOCKBINDINGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glShaderStorageBlockBinding"
  _gl::functions()\pointer = @ShaderStorageBlockBinding
  _gl::functions()\version = 0
  Global GetActiveSubroutineName._gl::PFNGLGETACTIVESUBROUTINENAMEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveSubroutineName"
  _gl::functions()\pointer = @GetActiveSubroutineName
  _gl::functions()\version = 0
  Global GetActiveSubroutineUniformName._gl::PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveSubroutineUniformName"
  _gl::functions()\pointer = @GetActiveSubroutineUniformName
  _gl::functions()\version = 0
  Global GetActiveSubroutineUniformiv._gl::PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveSubroutineUniformiv"
  _gl::functions()\pointer = @GetActiveSubroutineUniformiv
  _gl::functions()\version = 0
  Global GetProgramStageiv._gl::PFNGLGETPROGRAMSTAGEIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetProgramStageiv"
  _gl::functions()\pointer = @GetProgramStageiv
  _gl::functions()\version = 0
  Global GetSubroutineIndex._gl::PFNGLGETSUBROUTINEINDEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSubroutineIndex"
  _gl::functions()\pointer = @GetSubroutineIndex
  _gl::functions()\version = 0
  Global GetSubroutineUniformLocation._gl::PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSubroutineUniformLocation"
  _gl::functions()\pointer = @GetSubroutineUniformLocation
  _gl::functions()\version = 0
  Global GetUniformSubroutineuiv._gl::PFNGLGETUNIFORMSUBROUTINEUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformSubroutineuiv"
  _gl::functions()\pointer = @GetUniformSubroutineuiv
  _gl::functions()\version = 0
  Global UniformSubroutinesuiv._gl::PFNGLUNIFORMSUBROUTINESUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformSubroutinesuiv"
  _gl::functions()\pointer = @UniformSubroutinesuiv
  _gl::functions()\version = 0
  Global ClientWaitSync._gl::PFNGLCLIENTWAITSYNCPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClientWaitSync"
  _gl::functions()\pointer = @ClientWaitSync
  _gl::functions()\version = 0
  Global DeleteSync._gl::PFNGLDELETESYNCPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteSync"
  _gl::functions()\pointer = @DeleteSync
  _gl::functions()\version = 0
  Global FenceSync._gl::PFNGLFENCESYNCPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFenceSync"
  _gl::functions()\pointer = @FenceSync
  _gl::functions()\version = 0
  Global GetInteger64v._gl::PFNGLGETINTEGER64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetInteger64v"
  _gl::functions()\pointer = @GetInteger64v
  _gl::functions()\version = 0
  Global GetSynciv._gl::PFNGLGETSYNCIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetSynciv"
  _gl::functions()\pointer = @GetSynciv
  _gl::functions()\version = 0
  Global IsSync._gl::PFNGLISSYNCPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsSync"
  _gl::functions()\pointer = @IsSync
  _gl::functions()\version = 0
  Global WaitSync._gl::PFNGLWAITSYNCPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glWaitSync"
  _gl::functions()\pointer = @WaitSync
  _gl::functions()\version = 0
  Global PatchParameterfv._gl::PFNGLPATCHPARAMETERFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPatchParameterfv"
  _gl::functions()\pointer = @PatchParameterfv
  _gl::functions()\version = 0
  Global PatchParameteri._gl::PFNGLPATCHPARAMETERIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPatchParameteri"
  _gl::functions()\pointer = @PatchParameteri
  _gl::functions()\version = 0
  Global TextureBarrier._gl::PFNGLTEXTUREBARRIERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureBarrier"
  _gl::functions()\pointer = @TextureBarrier
  _gl::functions()\version = 0
  Global TexBufferRange._gl::PFNGLTEXBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexBufferRange"
  _gl::functions()\pointer = @TexBufferRange
  _gl::functions()\version = 0
  Global GetMultisamplefv._gl::PFNGLGETMULTISAMPLEFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMultisamplefv"
  _gl::functions()\pointer = @GetMultisamplefv
  _gl::functions()\version = 0
  Global SampleMaski._gl::PFNGLSAMPLEMASKIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSampleMaski"
  _gl::functions()\pointer = @SampleMaski
  _gl::functions()\version = 0
  Global TexImage2DMultisample._gl::PFNGLTEXIMAGE2DMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexImage2DMultisample"
  _gl::functions()\pointer = @TexImage2DMultisample
  _gl::functions()\version = 0
  Global TexImage3DMultisample._gl::PFNGLTEXIMAGE3DMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexImage3DMultisample"
  _gl::functions()\pointer = @TexImage3DMultisample
  _gl::functions()\version = 0
  Global TexStorage1D._gl::PFNGLTEXSTORAGE1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexStorage1D"
  _gl::functions()\pointer = @TexStorage1D
  _gl::functions()\version = 0
  Global TexStorage2D._gl::PFNGLTEXSTORAGE2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexStorage2D"
  _gl::functions()\pointer = @TexStorage2D
  _gl::functions()\version = 0
  Global TexStorage3D._gl::PFNGLTEXSTORAGE3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexStorage3D"
  _gl::functions()\pointer = @TexStorage3D
  _gl::functions()\version = 0
  Global TexStorage2DMultisample._gl::PFNGLTEXSTORAGE2DMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexStorage2DMultisample"
  _gl::functions()\pointer = @TexStorage2DMultisample
  _gl::functions()\version = 0
  Global TexStorage3DMultisample._gl::PFNGLTEXSTORAGE3DMULTISAMPLEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexStorage3DMultisample"
  _gl::functions()\pointer = @TexStorage3DMultisample
  _gl::functions()\version = 0
  Global TextureView._gl::PFNGLTEXTUREVIEWPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTextureView"
  _gl::functions()\pointer = @TextureView
  _gl::functions()\version = 0
  Global GetQueryObjecti64v._gl::PFNGLGETQUERYOBJECTI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryObjecti64v"
  _gl::functions()\pointer = @GetQueryObjecti64v
  _gl::functions()\version = 0
  Global GetQueryObjectui64v._gl::PFNGLGETQUERYOBJECTUI64VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryObjectui64v"
  _gl::functions()\pointer = @GetQueryObjectui64v
  _gl::functions()\version = 0
  Global QueryCounter._gl::PFNGLQUERYCOUNTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glQueryCounter"
  _gl::functions()\pointer = @QueryCounter
  _gl::functions()\version = 0
  Global BindTransformFeedback._gl::PFNGLBINDTRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindTransformFeedback"
  _gl::functions()\pointer = @BindTransformFeedback
  _gl::functions()\version = 0
  Global DeleteTransformFeedbacks._gl::PFNGLDELETETRANSFORMFEEDBACKSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteTransformFeedbacks"
  _gl::functions()\pointer = @DeleteTransformFeedbacks
  _gl::functions()\version = 0
  Global DrawTransformFeedback._gl::PFNGLDRAWTRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawTransformFeedback"
  _gl::functions()\pointer = @DrawTransformFeedback
  _gl::functions()\version = 0
  Global GenTransformFeedbacks._gl::PFNGLGENTRANSFORMFEEDBACKSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenTransformFeedbacks"
  _gl::functions()\pointer = @GenTransformFeedbacks
  _gl::functions()\version = 0
  Global IsTransformFeedback._gl::PFNGLISTRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsTransformFeedback"
  _gl::functions()\pointer = @IsTransformFeedback
  _gl::functions()\version = 0
  Global PauseTransformFeedback._gl::PFNGLPAUSETRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPauseTransformFeedback"
  _gl::functions()\pointer = @PauseTransformFeedback
  _gl::functions()\version = 0
  Global ResumeTransformFeedback._gl::PFNGLRESUMETRANSFORMFEEDBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glResumeTransformFeedback"
  _gl::functions()\pointer = @ResumeTransformFeedback
  _gl::functions()\version = 0
  Global BeginQueryIndexed._gl::PFNGLBEGINQUERYINDEXEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBeginQueryIndexed"
  _gl::functions()\pointer = @BeginQueryIndexed
  _gl::functions()\version = 0
  Global DrawTransformFeedbackStream._gl::PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawTransformFeedbackStream"
  _gl::functions()\pointer = @DrawTransformFeedbackStream
  _gl::functions()\version = 0
  Global EndQueryIndexed._gl::PFNGLENDQUERYINDEXEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glEndQueryIndexed"
  _gl::functions()\pointer = @EndQueryIndexed
  _gl::functions()\version = 0
  Global GetQueryIndexediv._gl::PFNGLGETQUERYINDEXEDIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetQueryIndexediv"
  _gl::functions()\pointer = @GetQueryIndexediv
  _gl::functions()\version = 0
  Global DrawTransformFeedbackInstanced._gl::PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawTransformFeedbackInstanced"
  _gl::functions()\pointer = @DrawTransformFeedbackInstanced
  _gl::functions()\version = 0
  Global DrawTransformFeedbackStreamInstanced._gl::PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawTransformFeedbackStreamInstanced"
  _gl::functions()\pointer = @DrawTransformFeedbackStreamInstanced
  _gl::functions()\version = 0
  Global BindBufferBase._gl::PFNGLBINDBUFFERBASEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindBufferBase"
  _gl::functions()\pointer = @BindBufferBase
  _gl::functions()\version = 0
  Global BindBufferRange._gl::PFNGLBINDBUFFERRANGEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindBufferRange"
  _gl::functions()\pointer = @BindBufferRange
  _gl::functions()\version = 0
  Global GetActiveUniformBlockName._gl::PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveUniformBlockName"
  _gl::functions()\pointer = @GetActiveUniformBlockName
  _gl::functions()\version = 0
  Global GetActiveUniformBlockiv._gl::PFNGLGETACTIVEUNIFORMBLOCKIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveUniformBlockiv"
  _gl::functions()\pointer = @GetActiveUniformBlockiv
  _gl::functions()\version = 0
  Global GetActiveUniformName._gl::PFNGLGETACTIVEUNIFORMNAMEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveUniformName"
  _gl::functions()\pointer = @GetActiveUniformName
  _gl::functions()\version = 0
  Global GetActiveUniformsiv._gl::PFNGLGETACTIVEUNIFORMSIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetActiveUniformsiv"
  _gl::functions()\pointer = @GetActiveUniformsiv
  _gl::functions()\version = 0
  Global GetIntegeri_v._gl::PFNGLGETINTEGERI_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetIntegeri_v"
  _gl::functions()\pointer = @GetIntegeri_v
  _gl::functions()\version = 0
  Global GetUniformBlockIndex._gl::PFNGLGETUNIFORMBLOCKINDEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformBlockIndex"
  _gl::functions()\pointer = @GetUniformBlockIndex
  _gl::functions()\version = 0
  Global GetUniformIndices._gl::PFNGLGETUNIFORMINDICESPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetUniformIndices"
  _gl::functions()\pointer = @GetUniformIndices
  _gl::functions()\version = 0
  Global UniformBlockBinding._gl::PFNGLUNIFORMBLOCKBINDINGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glUniformBlockBinding"
  _gl::functions()\pointer = @UniformBlockBinding
  _gl::functions()\version = 0
  Global BindVertexArray._gl::PFNGLBINDVERTEXARRAYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindVertexArray"
  _gl::functions()\pointer = @BindVertexArray
  _gl::functions()\version = 0
  Global DeleteVertexArrays._gl::PFNGLDELETEVERTEXARRAYSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteVertexArrays"
  _gl::functions()\pointer = @DeleteVertexArrays
  _gl::functions()\version = 0
  Global GenVertexArrays._gl::PFNGLGENVERTEXARRAYSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGenVertexArrays"
  _gl::functions()\pointer = @GenVertexArrays
  _gl::functions()\version = 0
  Global IsVertexArray._gl::PFNGLISVERTEXARRAYPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glIsVertexArray"
  _gl::functions()\pointer = @IsVertexArray
  _gl::functions()\version = 0
  Global GetVertexAttribLdv._gl::PFNGLGETVERTEXATTRIBLDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetVertexAttribLdv"
  _gl::functions()\pointer = @GetVertexAttribLdv
  _gl::functions()\version = 0
  Global VertexAttribL1d._gl::PFNGLVERTEXATTRIBL1DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL1d"
  _gl::functions()\pointer = @VertexAttribL1d
  _gl::functions()\version = 0
  Global VertexAttribL1dv._gl::PFNGLVERTEXATTRIBL1DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL1dv"
  _gl::functions()\pointer = @VertexAttribL1dv
  _gl::functions()\version = 0
  Global VertexAttribL2d._gl::PFNGLVERTEXATTRIBL2DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL2d"
  _gl::functions()\pointer = @VertexAttribL2d
  _gl::functions()\version = 0
  Global VertexAttribL2dv._gl::PFNGLVERTEXATTRIBL2DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL2dv"
  _gl::functions()\pointer = @VertexAttribL2dv
  _gl::functions()\version = 0
  Global VertexAttribL3d._gl::PFNGLVERTEXATTRIBL3DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL3d"
  _gl::functions()\pointer = @VertexAttribL3d
  _gl::functions()\version = 0
  Global VertexAttribL3dv._gl::PFNGLVERTEXATTRIBL3DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL3dv"
  _gl::functions()\pointer = @VertexAttribL3dv
  _gl::functions()\version = 0
  Global VertexAttribL4d._gl::PFNGLVERTEXATTRIBL4DPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL4d"
  _gl::functions()\pointer = @VertexAttribL4d
  _gl::functions()\version = 0
  Global VertexAttribL4dv._gl::PFNGLVERTEXATTRIBL4DVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribL4dv"
  _gl::functions()\pointer = @VertexAttribL4dv
  _gl::functions()\version = 0
  Global VertexAttribLPointer._gl::PFNGLVERTEXATTRIBLPOINTERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribLPointer"
  _gl::functions()\pointer = @VertexAttribLPointer
  _gl::functions()\version = 0
  Global BindVertexBuffer._gl::PFNGLBINDVERTEXBUFFERPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBindVertexBuffer"
  _gl::functions()\pointer = @BindVertexBuffer
  _gl::functions()\version = 0
  Global VertexAttribBinding._gl::PFNGLVERTEXATTRIBBINDINGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribBinding"
  _gl::functions()\pointer = @VertexAttribBinding
  _gl::functions()\version = 0
  Global VertexAttribFormat._gl::PFNGLVERTEXATTRIBFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribFormat"
  _gl::functions()\pointer = @VertexAttribFormat
  _gl::functions()\version = 0
  Global VertexAttribIFormat._gl::PFNGLVERTEXATTRIBIFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribIFormat"
  _gl::functions()\pointer = @VertexAttribIFormat
  _gl::functions()\version = 0
  Global VertexAttribLFormat._gl::PFNGLVERTEXATTRIBLFORMATPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribLFormat"
  _gl::functions()\pointer = @VertexAttribLFormat
  _gl::functions()\version = 0
  Global VertexBindingDivisor._gl::PFNGLVERTEXBINDINGDIVISORPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexBindingDivisor"
  _gl::functions()\pointer = @VertexBindingDivisor
  _gl::functions()\version = 0
  Global ColorP3ui._gl::PFNGLCOLORP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorP3ui"
  _gl::functions()\pointer = @ColorP3ui
  _gl::functions()\version = 0
  Global ColorP3uiv._gl::PFNGLCOLORP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorP3uiv"
  _gl::functions()\pointer = @ColorP3uiv
  _gl::functions()\version = 0
  Global ColorP4ui._gl::PFNGLCOLORP4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorP4ui"
  _gl::functions()\pointer = @ColorP4ui
  _gl::functions()\version = 0
  Global ColorP4uiv._gl::PFNGLCOLORP4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColorP4uiv"
  _gl::functions()\pointer = @ColorP4uiv
  _gl::functions()\version = 0
  Global MultiTexCoordP1ui._gl::PFNGLMULTITEXCOORDP1UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP1ui"
  _gl::functions()\pointer = @MultiTexCoordP1ui
  _gl::functions()\version = 0
  Global MultiTexCoordP1uiv._gl::PFNGLMULTITEXCOORDP1UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP1uiv"
  _gl::functions()\pointer = @MultiTexCoordP1uiv
  _gl::functions()\version = 0
  Global MultiTexCoordP2ui._gl::PFNGLMULTITEXCOORDP2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP2ui"
  _gl::functions()\pointer = @MultiTexCoordP2ui
  _gl::functions()\version = 0
  Global MultiTexCoordP2uiv._gl::PFNGLMULTITEXCOORDP2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP2uiv"
  _gl::functions()\pointer = @MultiTexCoordP2uiv
  _gl::functions()\version = 0
  Global MultiTexCoordP3ui._gl::PFNGLMULTITEXCOORDP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP3ui"
  _gl::functions()\pointer = @MultiTexCoordP3ui
  _gl::functions()\version = 0
  Global MultiTexCoordP3uiv._gl::PFNGLMULTITEXCOORDP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP3uiv"
  _gl::functions()\pointer = @MultiTexCoordP3uiv
  _gl::functions()\version = 0
  Global MultiTexCoordP4ui._gl::PFNGLMULTITEXCOORDP4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP4ui"
  _gl::functions()\pointer = @MultiTexCoordP4ui
  _gl::functions()\version = 0
  Global MultiTexCoordP4uiv._gl::PFNGLMULTITEXCOORDP4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoordP4uiv"
  _gl::functions()\pointer = @MultiTexCoordP4uiv
  _gl::functions()\version = 0
  Global NormalP3ui._gl::PFNGLNORMALP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormalP3ui"
  _gl::functions()\pointer = @NormalP3ui
  _gl::functions()\version = 0
  Global NormalP3uiv._gl::PFNGLNORMALP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormalP3uiv"
  _gl::functions()\pointer = @NormalP3uiv
  _gl::functions()\version = 0
  Global SecondaryColorP3ui._gl::PFNGLSECONDARYCOLORP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColorP3ui"
  _gl::functions()\pointer = @SecondaryColorP3ui
  _gl::functions()\version = 0
  Global SecondaryColorP3uiv._gl::PFNGLSECONDARYCOLORP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSecondaryColorP3uiv"
  _gl::functions()\pointer = @SecondaryColorP3uiv
  _gl::functions()\version = 0
  Global TexCoordP1ui._gl::PFNGLTEXCOORDP1UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP1ui"
  _gl::functions()\pointer = @TexCoordP1ui
  _gl::functions()\version = 0
  Global TexCoordP1uiv._gl::PFNGLTEXCOORDP1UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP1uiv"
  _gl::functions()\pointer = @TexCoordP1uiv
  _gl::functions()\version = 0
  Global TexCoordP2ui._gl::PFNGLTEXCOORDP2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP2ui"
  _gl::functions()\pointer = @TexCoordP2ui
  _gl::functions()\version = 0
  Global TexCoordP2uiv._gl::PFNGLTEXCOORDP2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP2uiv"
  _gl::functions()\pointer = @TexCoordP2uiv
  _gl::functions()\version = 0
  Global TexCoordP3ui._gl::PFNGLTEXCOORDP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP3ui"
  _gl::functions()\pointer = @TexCoordP3ui
  _gl::functions()\version = 0
  Global TexCoordP3uiv._gl::PFNGLTEXCOORDP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP3uiv"
  _gl::functions()\pointer = @TexCoordP3uiv
  _gl::functions()\version = 0
  Global TexCoordP4ui._gl::PFNGLTEXCOORDP4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP4ui"
  _gl::functions()\pointer = @TexCoordP4ui
  _gl::functions()\version = 0
  Global TexCoordP4uiv._gl::PFNGLTEXCOORDP4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexCoordP4uiv"
  _gl::functions()\pointer = @TexCoordP4uiv
  _gl::functions()\version = 0
  Global VertexAttribP1ui._gl::PFNGLVERTEXATTRIBP1UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP1ui"
  _gl::functions()\pointer = @VertexAttribP1ui
  _gl::functions()\version = 0
  Global VertexAttribP1uiv._gl::PFNGLVERTEXATTRIBP1UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP1uiv"
  _gl::functions()\pointer = @VertexAttribP1uiv
  _gl::functions()\version = 0
  Global VertexAttribP2ui._gl::PFNGLVERTEXATTRIBP2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP2ui"
  _gl::functions()\pointer = @VertexAttribP2ui
  _gl::functions()\version = 0
  Global VertexAttribP2uiv._gl::PFNGLVERTEXATTRIBP2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP2uiv"
  _gl::functions()\pointer = @VertexAttribP2uiv
  _gl::functions()\version = 0
  Global VertexAttribP3ui._gl::PFNGLVERTEXATTRIBP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP3ui"
  _gl::functions()\pointer = @VertexAttribP3ui
  _gl::functions()\version = 0
  Global VertexAttribP3uiv._gl::PFNGLVERTEXATTRIBP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP3uiv"
  _gl::functions()\pointer = @VertexAttribP3uiv
  _gl::functions()\version = 0
  Global VertexAttribP4ui._gl::PFNGLVERTEXATTRIBP4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP4ui"
  _gl::functions()\pointer = @VertexAttribP4ui
  _gl::functions()\version = 0
  Global VertexAttribP4uiv._gl::PFNGLVERTEXATTRIBP4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexAttribP4uiv"
  _gl::functions()\pointer = @VertexAttribP4uiv
  _gl::functions()\version = 0
  Global VertexP2ui._gl::PFNGLVERTEXP2UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexP2ui"
  _gl::functions()\pointer = @VertexP2ui
  _gl::functions()\version = 0
  Global VertexP2uiv._gl::PFNGLVERTEXP2UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexP2uiv"
  _gl::functions()\pointer = @VertexP2uiv
  _gl::functions()\version = 0
  Global VertexP3ui._gl::PFNGLVERTEXP3UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexP3ui"
  _gl::functions()\pointer = @VertexP3ui
  _gl::functions()\version = 0
  Global VertexP3uiv._gl::PFNGLVERTEXP3UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexP3uiv"
  _gl::functions()\pointer = @VertexP3uiv
  _gl::functions()\version = 0
  Global VertexP4ui._gl::PFNGLVERTEXP4UIPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexP4ui"
  _gl::functions()\pointer = @VertexP4ui
  _gl::functions()\version = 0
  Global VertexP4uiv._gl::PFNGLVERTEXP4UIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glVertexP4uiv"
  _gl::functions()\pointer = @VertexP4uiv
  _gl::functions()\version = 0
  Global DepthRangeArrayv._gl::PFNGLDEPTHRANGEARRAYVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthRangeArrayv"
  _gl::functions()\pointer = @DepthRangeArrayv
  _gl::functions()\version = 0
  Global DepthRangeIndexed._gl::PFNGLDEPTHRANGEINDEXEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthRangeIndexed"
  _gl::functions()\pointer = @DepthRangeIndexed
  _gl::functions()\version = 0
  Global GetDoublei_v._gl::PFNGLGETDOUBLEI_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetDoublei_v"
  _gl::functions()\pointer = @GetDoublei_v
  _gl::functions()\version = 0
  Global GetFloati_v._gl::PFNGLGETFLOATI_VPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFloati_v"
  _gl::functions()\pointer = @GetFloati_v
  _gl::functions()\version = 0
  Global ScissorArrayv._gl::PFNGLSCISSORARRAYVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScissorArrayv"
  _gl::functions()\pointer = @ScissorArrayv
  _gl::functions()\version = 0
  Global ScissorIndexed._gl::PFNGLSCISSORINDEXEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScissorIndexed"
  _gl::functions()\pointer = @ScissorIndexed
  _gl::functions()\version = 0
  Global ScissorIndexedv._gl::PFNGLSCISSORINDEXEDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScissorIndexedv"
  _gl::functions()\pointer = @ScissorIndexedv
  _gl::functions()\version = 0
  Global ViewportArrayv._gl::PFNGLVIEWPORTARRAYVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glViewportArrayv"
  _gl::functions()\pointer = @ViewportArrayv
  _gl::functions()\version = 0
  Global ViewportIndexedf._gl::PFNGLVIEWPORTINDEXEDFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glViewportIndexedf"
  _gl::functions()\pointer = @ViewportIndexedf
  _gl::functions()\version = 0
  Global ViewportIndexedfv._gl::PFNGLVIEWPORTINDEXEDFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glViewportIndexedfv"
  _gl::functions()\pointer = @ViewportIndexedfv
  _gl::functions()\version = 0
  Global CreateArraySetExt._gl::PFNGLCREATEARRAYSETEXTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glCreateArraySetExt"
  _gl::functions()\pointer = @CreateArraySetExt
  _gl::functions()\version = 0
  Global DebugMessageCallback._gl::PFNGLDEBUGMESSAGECALLBACKPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDebugMessageCallback"
  _gl::functions()\pointer = @DebugMessageCallback
  _gl::functions()\version = 0
  Global DebugMessageControl._gl::PFNGLDEBUGMESSAGECONTROLPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDebugMessageControl"
  _gl::functions()\pointer = @DebugMessageControl
  _gl::functions()\version = 0
  Global DebugMessageInsert._gl::PFNGLDEBUGMESSAGEINSERTPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDebugMessageInsert"
  _gl::functions()\pointer = @DebugMessageInsert
  _gl::functions()\version = 0
  Global GetDebugMessageLog._gl::PFNGLGETDEBUGMESSAGELOGPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetDebugMessageLog"
  _gl::functions()\pointer = @GetDebugMessageLog
  _gl::functions()\version = 0
  Global GetObjectLabel._gl::PFNGLGETOBJECTLABELPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetObjectLabel"
  _gl::functions()\pointer = @GetObjectLabel
  _gl::functions()\version = 0
  Global GetObjectPtrLabel._gl::PFNGLGETOBJECTPTRLABELPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetObjectPtrLabel"
  _gl::functions()\pointer = @GetObjectPtrLabel
  _gl::functions()\version = 0
  Global ObjectLabel._gl::PFNGLOBJECTLABELPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glObjectLabel"
  _gl::functions()\pointer = @ObjectLabel
  _gl::functions()\version = 0
  Global ObjectPtrLabel._gl::PFNGLOBJECTPTRLABELPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glObjectPtrLabel"
  _gl::functions()\pointer = @ObjectPtrLabel
  _gl::functions()\version = 0
  Global PopDebugGroup._gl::PFNGLPOPDEBUGGROUPPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPopDebugGroup"
  _gl::functions()\pointer = @PopDebugGroup
  _gl::functions()\version = 0
  Global PushDebugGroup._gl::PFNGLPUSHDEBUGGROUPPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPushDebugGroup"
  _gl::functions()\pointer = @PushDebugGroup
  _gl::functions()\version = 0
  Global GetnUniformfv._gl::PFNGLGETNUNIFORMFVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetnUniformfv"
  _gl::functions()\pointer = @GetnUniformfv
  _gl::functions()\version = 0
  Global GetnUniformiv._gl::PFNGLGETNUNIFORMIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetnUniformiv"
  _gl::functions()\pointer = @GetnUniformiv
  _gl::functions()\version = 0
  Global GetnUniformuiv._gl::PFNGLGETNUNIFORMUIVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetnUniformuiv"
  _gl::functions()\pointer = @GetnUniformuiv
  _gl::functions()\version = 0
  Global ReadnPixels._gl::PFNGLREADNPIXELSPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glReadnPixels"
  _gl::functions()\pointer = @ReadnPixels
  _gl::functions()\version = 0
  Global BufferRegionEnabled._gl::PFNGLBUFFERREGIONENABLEDPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glBufferRegionEnabled"
  _gl::functions()\pointer = @BufferRegionEnabled
  _gl::functions()\version = 0
  Global DeleteBufferRegion._gl::PFNGLDELETEBUFFERREGIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDeleteBufferRegion"
  _gl::functions()\pointer = @DeleteBufferRegion
  _gl::functions()\version = 0
  Global DrawBufferRegion._gl::PFNGLDRAWBUFFERREGIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDrawBufferRegion"
  _gl::functions()\pointer = @DrawBufferRegion
  _gl::functions()\version = 0
  Global NewBufferRegion._gl::PFNGLNEWBUFFERREGIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNewBufferRegion"
  _gl::functions()\pointer = @NewBufferRegion
  _gl::functions()\version = 0
  Global ReadBufferRegion._gl::PFNGLREADBUFFERREGIONPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glReadBufferRegion"
  _gl::functions()\pointer = @ReadBufferRegion
  _gl::functions()\version = 0
  Global AlphaFuncx._gl::PFNGLALPHAFUNCXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glAlphaFuncx"
  _gl::functions()\pointer = @AlphaFuncx
  _gl::functions()\version = 0
  Global ClearColorx._gl::PFNGLCLEARCOLORXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearColorx"
  _gl::functions()\pointer = @ClearColorx
  _gl::functions()\version = 0
  Global ClearDepthx._gl::PFNGLCLEARDEPTHXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClearDepthx"
  _gl::functions()\pointer = @ClearDepthx
  _gl::functions()\version = 0
  Global Color4x._gl::PFNGLCOLOR4XPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glColor4x"
  _gl::functions()\pointer = @Color4x
  _gl::functions()\version = 0
  Global DepthRangex._gl::PFNGLDEPTHRANGEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDepthRangex"
  _gl::functions()\pointer = @DepthRangex
  _gl::functions()\version = 0
  Global Fogx._gl::PFNGLFOGXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogx"
  _gl::functions()\pointer = @Fogx
  _gl::functions()\version = 0
  Global Fogxv._gl::PFNGLFOGXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFogxv"
  _gl::functions()\pointer = @Fogxv
  _gl::functions()\version = 0
  Global Frustumf._gl::PFNGLFRUSTUMFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFrustumf"
  _gl::functions()\pointer = @Frustumf
  _gl::functions()\version = 0
  Global Frustumx._gl::PFNGLFRUSTUMXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glFrustumx"
  _gl::functions()\pointer = @Frustumx
  _gl::functions()\version = 0
  Global LightModelx._gl::PFNGLLIGHTMODELXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightModelx"
  _gl::functions()\pointer = @LightModelx
  _gl::functions()\version = 0
  Global LightModelxv._gl::PFNGLLIGHTMODELXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightModelxv"
  _gl::functions()\pointer = @LightModelxv
  _gl::functions()\version = 0
  Global Lightx._gl::PFNGLLIGHTXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightx"
  _gl::functions()\pointer = @Lightx
  _gl::functions()\version = 0
  Global Lightxv._gl::PFNGLLIGHTXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLightxv"
  _gl::functions()\pointer = @Lightxv
  _gl::functions()\version = 0
  Global LineWidthx._gl::PFNGLLINEWIDTHXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLineWidthx"
  _gl::functions()\pointer = @LineWidthx
  _gl::functions()\version = 0
  Global LoadMatrixx._gl::PFNGLLOADMATRIXXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glLoadMatrixx"
  _gl::functions()\pointer = @LoadMatrixx
  _gl::functions()\version = 0
  Global Materialx._gl::PFNGLMATERIALXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMaterialx"
  _gl::functions()\pointer = @Materialx
  _gl::functions()\version = 0
  Global Materialxv._gl::PFNGLMATERIALXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMaterialxv"
  _gl::functions()\pointer = @Materialxv
  _gl::functions()\version = 0
  Global MultMatrixx._gl::PFNGLMULTMATRIXXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultMatrixx"
  _gl::functions()\pointer = @MultMatrixx
  _gl::functions()\version = 0
  Global MultiTexCoord4x._gl::PFNGLMULTITEXCOORD4XPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMultiTexCoord4x"
  _gl::functions()\pointer = @MultiTexCoord4x
  _gl::functions()\version = 0
  Global Normal3x._gl::PFNGLNORMAL3XPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glNormal3x"
  _gl::functions()\pointer = @Normal3x
  _gl::functions()\version = 0
  Global Orthof._gl::PFNGLORTHOFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glOrthof"
  _gl::functions()\pointer = @Orthof
  _gl::functions()\version = 0
  Global Orthox._gl::PFNGLORTHOXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glOrthox"
  _gl::functions()\pointer = @Orthox
  _gl::functions()\version = 0
  Global PointSizex._gl::PFNGLPOINTSIZEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointSizex"
  _gl::functions()\pointer = @PointSizex
  _gl::functions()\version = 0
  Global PolygonOffsetx._gl::PFNGLPOLYGONOFFSETXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPolygonOffsetx"
  _gl::functions()\pointer = @PolygonOffsetx
  _gl::functions()\version = 0
  Global Rotatex._gl::PFNGLROTATEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glRotatex"
  _gl::functions()\pointer = @Rotatex
  _gl::functions()\version = 0
  Global SampleCoveragex._gl::PFNGLSAMPLECOVERAGEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glSampleCoveragex"
  _gl::functions()\pointer = @SampleCoveragex
  _gl::functions()\version = 0
  Global Scalex._gl::PFNGLSCALEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glScalex"
  _gl::functions()\pointer = @Scalex
  _gl::functions()\version = 0
  Global TexEnvx._gl::PFNGLTEXENVXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexEnvx"
  _gl::functions()\pointer = @TexEnvx
  _gl::functions()\version = 0
  Global TexEnvxv._gl::PFNGLTEXENVXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexEnvxv"
  _gl::functions()\pointer = @TexEnvxv
  _gl::functions()\version = 0
  Global TexParameterx._gl::PFNGLTEXPARAMETERXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameterx"
  _gl::functions()\pointer = @TexParameterx
  _gl::functions()\version = 0
  Global Translatex._gl::PFNGLTRANSLATEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTranslatex"
  _gl::functions()\pointer = @Translatex
  _gl::functions()\version = 0
  Global ClipPlanef._gl::PFNGLCLIPPLANEFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClipPlanef"
  _gl::functions()\pointer = @ClipPlanef
  _gl::functions()\version = 0
  Global ClipPlanex._gl::PFNGLCLIPPLANEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glClipPlanex"
  _gl::functions()\pointer = @ClipPlanex
  _gl::functions()\version = 0
  Global GetClipPlanef._gl::PFNGLGETCLIPPLANEFPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetClipPlanef"
  _gl::functions()\pointer = @GetClipPlanef
  _gl::functions()\version = 0
  Global GetClipPlanex._gl::PFNGLGETCLIPPLANEXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetClipPlanex"
  _gl::functions()\pointer = @GetClipPlanex
  _gl::functions()\version = 0
  Global GetFixedv._gl::PFNGLGETFIXEDVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetFixedv"
  _gl::functions()\pointer = @GetFixedv
  _gl::functions()\version = 0
  Global GetLightxv._gl::PFNGLGETLIGHTXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetLightxv"
  _gl::functions()\pointer = @GetLightxv
  _gl::functions()\version = 0
  Global GetMaterialxv._gl::PFNGLGETMATERIALXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMaterialxv"
  _gl::functions()\pointer = @GetMaterialxv
  _gl::functions()\version = 0
  Global GetTexEnvxv._gl::PFNGLGETTEXENVXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexEnvxv"
  _gl::functions()\pointer = @GetTexEnvxv
  _gl::functions()\version = 0
  Global GetTexParameterxv._gl::PFNGLGETTEXPARAMETERXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetTexParameterxv"
  _gl::functions()\pointer = @GetTexParameterxv
  _gl::functions()\version = 0
  Global PointParameterx._gl::PFNGLPOINTPARAMETERXPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointParameterx"
  _gl::functions()\pointer = @PointParameterx
  _gl::functions()\version = 0
  Global PointParameterxv._gl::PFNGLPOINTPARAMETERXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glPointParameterxv"
  _gl::functions()\pointer = @PointParameterxv
  _gl::functions()\version = 0
  Global TexParameterxv._gl::PFNGLTEXPARAMETERXVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glTexParameterxv"
  _gl::functions()\pointer = @TexParameterxv
  _gl::functions()\version = 0
  Global AddressSpace._gl::PFNGLADDRESSSPACEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glAddressSpace"
  _gl::functions()\pointer = @AddressSpace
  _gl::functions()\version = 0
  Global DataPipe._gl::PFNGLDATAPIPEPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glDataPipe"
  _gl::functions()\pointer = @DataPipe
  _gl::functions()\version = 0
  Global GetMPEGQuantTableubv._gl::PFNGLGETMPEGQUANTTABLEUBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glGetMPEGQuantTableubv"
  _gl::functions()\pointer = @GetMPEGQuantTableubv
  _gl::functions()\version = 0
  Global MPEGQuantTableubv._gl::PFNGLMPEGQUANTTABLEUBVPROC
  AddElement( _gl::functions() )
  _gl::functions()\name = "glMPEGQuantTableubv"
  _gl::functions()\pointer = @MPEGQuantTableubv
  _gl::functions()\version = 0
;}
EndDeclareModule
XIncludeFile "_module_gl.pbi"
