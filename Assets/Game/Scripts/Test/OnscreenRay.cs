using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

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
        EventManager.StartListening(EventManager.CustomEventType.OnscreenRay, rayAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(EventManager.CustomEventType.OnscreenRay, rayAction);
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
                EventManager.TriggerEvent(EventManager.CustomEventType.Move);
            }
        }
    }
    #endregion

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButtonUp(0))
        {
            EventManager.TriggerEvent(EventManager.CustomEventType.OnscreenRay);
        }
    }


}
