using UnityEngine;
public class RenderTextureAutoResolution : MonoBehaviour
{
	[SerializeField]
	private RenderTexture texture = null;
	[SerializeField]
	private Vector2Int resolution = new Vector2Int(0, 0);
	[SerializeField]
	private bool autoResolution = true;
	void OnEnable()
	{
		ChangeRes();
	}
	private void FixedUpdate()
	{
		if(autoResolution && Screen.height!= texture.height)
		{
			ChangeRes();
		}
	}
	private void ChangeRes()
	{
		if (texture == null)
			return;
		texture.Release();
		texture.width = autoResolution ? Screen.width : resolution.x;
		texture.height = autoResolution ? Screen.height : resolution.y;
		if (autoResolution) resolution = new Vector2Int(Screen.width, Screen.height);
		texture.Create();
	}
}
