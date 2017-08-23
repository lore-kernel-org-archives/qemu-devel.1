Received: from eggs.gnu.org ([2001:4830:134:3::10]:57493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWB2-0002cZ-Gm
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWAz-00022l-Ta
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:58:36 -0400
Message-ID: <1503496711.16071.23.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 15:58:31 +0200
In-Reply-To: <20170821041040.GF12356@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<25eb9dc6c387f03754114e4a0584516847f1da7d.1503249785.git.balaton@eik.bme.hu>
	<20170821041040.GF12356@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] ohci: Allow sysbus version to be
 used as a companion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Mon, 2017-08-21 at 14:10 +1000, David Gibson wrote:
> On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> 1;4803;0c> Some PPC SoCs have an EHCI with OHCI companion USB
> controller. To
> > emulate this allow the sysbus version of OHCI to be used as a
> > companion.
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Gerd,=C2=A0=C2=A0if you're happy with this, I can queue it for 2.11.=C2=
=A0=C2=A0Let me
> know what you'd prefer.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
