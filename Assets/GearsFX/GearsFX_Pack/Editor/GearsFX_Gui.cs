using UnityEngine;
using UnityEditor;

public class GearsFX_Gui : ShaderGUI
{

    MaterialEditor editor;
    MaterialProperty[] properties;

    //get preperties function
    MaterialProperty FindProperty(string name)
    {
        return FindProperty(name, properties);
    }
    //

    ////
    static GUIContent staticLabel = new GUIContent();
    static GUIContent MakeLabel(MaterialProperty property, string tooltip = null)
    {
        staticLabel.text = property.displayName;
        staticLabel.tooltip = tooltip;
        return staticLabel;
    }
    ////

    public override void OnGUI(MaterialEditor editor, MaterialProperty[] properties)
    {
        this.editor = editor;
        this.properties = properties;
        DoMain();

    }


    // GUI FUNCTION	
    void DoMain()
    {
        //--- Logo
        Texture2D myGUITexture = (Texture2D)Resources.Load("GearsFX_Icon");
        GUILayout.Label(myGUITexture, EditorStyles.centeredGreyMiniLabel);

        //LABELS
        GUILayout.Label("/---------------/ GEARS FX PACK /---------------/", EditorStyles.centeredGreyMiniLabel);
        GUILayout.Label("SURFACE", EditorStyles.helpBox);

        // get properties
        MaterialProperty _DiffuseMap = ShaderGUI.FindProperty("_DiffuseMap", properties);

        //Add to GUI
        editor.TexturePropertySingleLine(MakeLabel(_DiffuseMap, "FFace Map"), _DiffuseMap, FindProperty("_SurfaceColor"));
        //editor.TextureScaleOffsetProperty(_DiffuseMap);

        MaterialProperty _Additive = FindProperty("_Additive");
        editor.ShaderProperty(_Additive, MakeLabel(_Additive));
        //--------------------

        //MaterialProperty _SurfaceColor = FindProperty("_SurfaceColor");
        //editor.ShaderProperty(_SurfaceColor, MakeLabel(_SurfaceColor));

        /////////////
        GUILayout.Label("OUTLINES", EditorStyles.helpBox);

        MaterialProperty _Outlines_Color = FindProperty("_Outlines_Color");
        editor.ShaderProperty(_Outlines_Color, MakeLabel(_Outlines_Color));

        MaterialProperty _Outlines_Color_Opacity = FindProperty("_Outlines_Color_Opacity");
        editor.ShaderProperty(_Outlines_Color_Opacity, MakeLabel(_Outlines_Color_Opacity));

        MaterialProperty _GearsOutlinesIntensity = FindProperty("_GearsOutlinesIntensity");
        editor.ShaderProperty(_GearsOutlinesIntensity, MakeLabel(_GearsOutlinesIntensity));

        /////////////
        GUILayout.Label("FACES", EditorStyles.helpBox);

        MaterialProperty _Faces_Color = FindProperty("_Faces_Color");
        editor.ShaderProperty(_Faces_Color, MakeLabel(_Faces_Color));

        MaterialProperty _Faces_Color_Opacity = FindProperty("_Faces_Color_Opacity");
        editor.ShaderProperty(_Faces_Color_Opacity, MakeLabel(_Faces_Color_Opacity));
        /*
        MaterialProperty _FacePourcentage = FindProperty("_FacePourcentage");
        editor.ShaderProperty(_FacePourcentage, MakeLabel(_FacePourcentage));
        */
        /////////////
        GUILayout.Label("MASK", EditorStyles.helpBox);

        // get properties
        MaterialProperty _Outlines_Mask = ShaderGUI.FindProperty("_Outlines_Mask", properties);

        //Add to GUI

        //editor.ShaderProperty(_Outlines_Mask, MakeLabel(_Outlines_Mask));
        editor.TexturePropertySingleLine(MakeLabel(_Outlines_Mask, "FFace Map"), _Outlines_Mask, FindProperty("_TileX_Outline"), FindProperty("_TileY_Outline"));
        //--------------------

        // get properties
        MaterialProperty _AnimationMask = ShaderGUI.FindProperty("_AnimationMask", properties);

        //Add to GUI
        editor.TexturePropertySingleLine(MakeLabel(_AnimationMask, "FFace Map"), _AnimationMask, FindProperty("_TileX"), FindProperty("_TileY"));
        //editor.ShaderProperty(_AnimationMask, MakeLabel(_AnimationMask));

        MaterialProperty _SwitchAxis = FindProperty("_SwitchAxis");
        editor.ShaderProperty(_SwitchAxis, MakeLabel(_SwitchAxis));

        MaterialProperty _Mask_Debug = FindProperty("_Mask_Debug");
        editor.ShaderProperty(_Mask_Debug, MakeLabel(_Mask_Debug));
        //--------------------

        /////////////
        GUILayout.Label("ANIMATIONS", EditorStyles.helpBox);

     
        MaterialProperty _SinusoidalePanner = FindProperty("_SinusoidalePanner");
        editor.ShaderProperty(_SinusoidalePanner, MakeLabel(_SinusoidalePanner));

        MaterialProperty _Flickering = FindProperty("_Flickering");
        editor.ShaderProperty(_Flickering, MakeLabel(_Flickering));

        MaterialProperty _MaskAnimationSpeed = FindProperty("_MaskAnimationSpeed");
        editor.ShaderProperty(_MaskAnimationSpeed, MakeLabel(_MaskAnimationSpeed));

        MaterialProperty _OutlineMaskSpeed = FindProperty("_OutlineMaskSpeed");
        editor.ShaderProperty(_OutlineMaskSpeed, MakeLabel(_OutlineMaskSpeed));

        MaterialProperty _FarDistanceMax = FindProperty("_FarDistanceMax");
        editor.ShaderProperty(_FarDistanceMax, MakeLabel(_FarDistanceMax));

        MaterialProperty _ExtraRotationVariationSpeed = FindProperty("_ExtraRotationVariationSpeed");
        editor.ShaderProperty(_ExtraRotationVariationSpeed, MakeLabel(_ExtraRotationVariationSpeed));





       
    }
}