Received: from eggs.gnu.org ([209.51.188.92]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hIQ6k-000193-JI
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hIPxZ-0008JK-T0
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:49:38 -0400
Received: from pv50p00im-ztdg10022001.me.com ([17.58.6.58]:54922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hIPxZ-0008Is-L2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:49:37 -0400
From: Chen Zhang <tgfbeta@me.com>
Message-Id: <620D1944-20D4-4F98-8677-F0009E6CE66E@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Mon, 22 Apr 2019 11:49:33 +0800
In-Reply-To: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
References: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix absolute and relative
 input issues on Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Ping

https://patchwork.kernel.org/patch/10888727/ =
<https://patchwork.kernel.org/patch/10888727/>

https://patchwork.kernel.org/patch/10888725/ =
<https://patchwork.kernel.org/patch/10888725/>


> On Apr 8, 2019, at 10:04 AM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
> The following patches fixed absolute and relative input device issues =
on macOS Mojave.
>=20
> Chen Zhang (2):
>   ui/cocoa: Fix absolute input device grabbing issue on Mojave
>   ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
>     device
>=20
>  ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.19.2
>=20
