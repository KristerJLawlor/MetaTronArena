using UnityEngine;

public class Rotate : MonoBehaviour
{
	public float speed = 3f;

	public void Update ( )
		=> transform.Rotate( 0f, speed * Time.smoothDeltaTime, 0f);
}
