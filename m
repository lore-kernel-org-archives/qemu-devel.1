Received: from eggs.gnu.org ([2001:4830:134:3::10]:35997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRwEE-0003zm-Fi
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRwED-0006uQ-Kg
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:33:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRwEC-0006rS-BU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:33:53 -0500
Date: Wed, 28 Nov 2018 10:33:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181128093347.zc2fpclw5re3cfhj@sirius.home.kraxel.org>
References: <20181126153036.22414-1-fziglio@redhat.com>
	<20181127123502.GZ12172@natto.ory.fergeau.eu>
	<20181128054850.exrlih6zqskaw7a7@sirius.home.kraxel.org>
	<CAJ+F1CKbLZuivyqcDCWxfBJY=VscGGeR7Cp5uFDvXduGxbocpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKbLZuivyqcDCWxfBJY=VscGGeR7Cp5uFDvXduGxbocpA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH] spice: Use new
 SpiceImageCompression definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, spice-devel <spice-devel@lists.freedesktop.org>, QEMU <qemu-devel@nongnu.org>

On Wed, Nov 28, 2018 at 12:19:51PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
> On Wed, Nov 28, 2018 at 9:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> >
> > 0.12.6 is more than three years old, so this or something newer shoul=
d
> > be available in most distros meanwhile.  Raising the bar to that vers=
ion
> > looks ok to me (separate patch please, and please also drop #ifdefs w=
e
> > don't need any more then).
>=20
> See https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00486.html
> "bump spice-server required version to 0.12.6"

Whoops.  Looks like that one slipped through for some reason.

sorry,
  Gerd
