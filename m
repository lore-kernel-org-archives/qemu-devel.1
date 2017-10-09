Received: from eggs.gnu.org ([2001:4830:134:3::10]:34082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1UV1-0004mL-GT
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1UUw-0001rk-O3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1UUw-0001rP-IZ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:37:18 -0400
Message-ID: <1507541836.32088.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 09 Oct 2017 11:37:16 +0200
In-Reply-To: <CY4PR15MB14645F1B82057940D068F009F3740@CY4PR15MB1464.namprd15.prod.outlook.com>
References: <CY4PR15MB1464F1EE43FD8CA97C728FD3F3760@CY4PR15MB1464.namprd15.prod.outlook.com>
	<87376suayp.fsf@dusky.pond.sub.org>,
	<1507534390.32088.5.camel@redhat.com>
	<CY4PR15MB14645F1B82057940D068F009F3740@CY4PR15MB1464.namprd15.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What is the status of the QEMU sound rework?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zir Blazer <zir_blazer@hotmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> The guy from reddit whose Thread I=C2=A0linked in the previous mail=C2=A0=
has
> done a bit more work, and his current status is this:
> https://www.reddit.com/r/VFIO/comments/74vokw/improved_pulse_audio_dr
> iver_for_qemu/
>=20
> He identified some issues with the QEMU audio=C2=A0backend, and accordi=
ng
> to the testers, his fixes seems to be working.
>=20
> As it=C2=A0is probable that he eventually upstreams something, you may
> want to be interesed in checking his work.

He asked me a few questions already and has the intention to send his
work upstream.

> I know that you just said that you don't have time, but since audio
> improvements for QEMU seems to have been stuck for some years, it may
> be important to be proactive now that there is people interesed
> and=C2=A0working in the issue,=C2=A0as to not lose this rare=C2=A0momen=
tum.

Sure.  Typically I try hard to set aside time for helping people, this
often pays off long-term.

cheers,
  Gerd
