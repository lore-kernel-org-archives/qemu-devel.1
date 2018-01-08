Received: from eggs.gnu.org ([2001:4830:134:3::10]:38118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eYUw9-0003ry-09
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eYUw5-0000M8-Sb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:45:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eYUw5-0000Km-MG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:45:45 -0500
Date: Mon, 8 Jan 2018 11:45:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180108104542.4r4ww2iaxrj4c2fw@sirius.home.kraxel.org>
References: <20171117112258.5888-1-makovick@gmail.com>
	<20180101211600.3f533781@holly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180101211600.3f533781@holly>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org

On Mon, Jan 01, 2018 at 09:16:00PM +0100, Jind=C5=99ich Makovi=C4=8Dka wr=
ote:
> On Fri, 17 Nov 2017 12:22:55 +0100
> Jindrich Makovicka <makovick@gmail.com> wrote:
>=20
> > Hi,
> >=20
> > here is a respin of the three remaining patches, with checkpatch
> > errors corrected.
> >=20
> > Also added the Fixes: line for "sdl2 uses surface relative
> > coordinates", and an explaining comment to "sdl2: Ignore UI hotkeys".
> >=20
> > Regards, Jindrich
> >=20
>=20
> Hi,
>=20
> these changes somehow got lost. Any chance to have them merged into the
> next minor?

First master, then possibly backport into -stable.

Just back from a few weeks of sick leave due to broken finger.

Will have to go through my email backlog, then I'll go handle
pending patches.  Will probably take some days though ...

cheers,
  Gerd
