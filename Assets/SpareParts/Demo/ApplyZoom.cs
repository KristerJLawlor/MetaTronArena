using UnityEngine;
using UnityEngine.UI;

public class ApplyZoom : MonoBehaviour
{
	public Slider zoomSlider;
	private Vector3 adjustedLocalPosition;

	public void Update ( )
	{
		adjustedLocalPosition.y = zoomSlider.value;
		adjustedLocalPosition.z = -zoomSlider.value;

		transform.localPosition = Vector3.
			Lerp( transform.localPosition , adjustedLocalPosition, 
			Time.smoothDeltaTime);

		transform.localPosition = Vector3.
			MoveTowards ( transform.localPosition, adjustedLocalPosition, 
			Time.smoothDeltaTime * Time.smoothDeltaTime );
	}
}
