Received: from eggs.gnu.org ([209.51.188.92]:51667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gpvIO-0005tg-T9
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gpvIO-0000Zy-55
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:25:20 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CABLmASGpih1TTWS4eCuckv12RvExs_UaQ=rPU+danJTSXR8grg@mail.gmail.com>
Date: Sat, 2 Feb 2019 08:25:13 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <69FB954B-4C50-4740-8DD2-8642D5FBCD8F@gmail.com>
References: <56F356E9-04E0-4419-91BD-55CC91C853E1@gmail.com>
	<CABLmASGpih1TTWS4eCuckv12RvExs_UaQ=rPU+danJTSXR8grg@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu_vga.drv missing 256 colors support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Jan 31, 2019, at 7:49 AM, Howard Spoelstra <hsp.cat7@gmail.com> =
wrote:
>=20
>=20
>=20
> On Thu, Jan 31, 2019 at 12:12 PM Programmingkid =
<programmingkidx@gmail.com> wrote:
> After testing a recent commit of QEMU I noticed that 256 color support =
is missing in Mac OS 9's color options. A lot of games refuse to run =
without being able to set the monitor to 256 colors. Could we have this =
option added?=20
>=20
> Thank you.
>=20
> Hi,
>=20
> An updated vga driver that supports 256 colours and reads edid info =
has been committed to dgibson's ppc-for-4.0 branch: =
https://github.com/dgibson/qemu/commit/4c693a81dbab9cecbf101c4c24e4b8af819=
df46c

Thank you very much for this info. I did notice the 256 colors option =
was back with this new driver. I didn't notice any change with the =
number of resolutions available. Were you able to see new resolution =
options?=
