using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

#region V6.0
using static EventManager.CustomEventType;
#endregion

public class OnscreenRay : MonoBehaviour
{
    public static Vector3 hitPosition;

    #region Event & Awake
    private UnityAction rayAction;
    private void Awake()
    {
        rayAction = new UnityAction(RayAction);
    }
    private void OnEnable()
    {
        EventManager.StartListening(ON_SCREEN_RAY, rayAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(ON_SCREEN_RAY, rayAction);
    }

    private void RayAction()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;

        if (Physics.Raycast(ray.origin, ray.direction, out hit))
        {
            if (hit.transform.gameObject.tag == "Ground")
            {
                hitPosition = hit.point;
                EventManager.TriggerEvent(MOVE);
            }
        }
    }
    #endregion

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButtonUp(0))
        {
            EventManager.TriggerEvent(ON_SCREEN_RAY);
        }
    }


}
