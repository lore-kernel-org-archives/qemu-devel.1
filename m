Received: from eggs.gnu.org ([2001:4830:134:3::10]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d14pJ-0001XM-Lo
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d14pF-0003OS-PR
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d14pF-0003O4-J9
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:40:17 -0400
Message-ID: <1492666811.6853.42.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Apr 2017 07:40:11 +0200
In-Reply-To: <dbaad765-44b8-785f-3612-3173001b94bf@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
	<87fuhf9kcz.fsf@dusky.pond.sub.org>
	<20170418095103.GF21261@stefanha-x1.localdomain>
	<1492516675.27392.45.camel@redhat.com>
	<7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com>
	<1492596922.6853.5.camel@redhat.com>
	<dbaad765-44b8-785f-3612-3173001b94bf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > You can have two floppy drives, but they are hooked to the same
>=20
> Yes, I'm aware.
>=20
> I'm just saying here "Spec-wise" because you can have two controllers,
> one at 0x3F0 and one at 0x370.

Oh, ok.  Wasn't aware of this detail.

Can't remember to have ever seen a pc with more than two floppy drives
(as-in: physical hardware).  And even two floppy drives is pretty rare.
Only in the early 90ies, while the transition from 5.25" floppies to
3.5" floppies happened, it was somewhat common to have two drives (one
of each type).

cheers,
  Gerd
