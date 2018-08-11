Received: from eggs.gnu.org ([2001:4830:134:3::10]:49802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1foVCB-0005cl-Qs
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 10:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1foVC5-0002ML-VW
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 10:48:47 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.20056.1533966041.1290.qemu-devel@nongnu.org>
Date: Sat, 11 Aug 2018 10:48:38 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <6132BC6D-9E74-4114-A7D1-A05D939ECBDB@gmail.com>
References: <mailman.20056.1533966041.1290.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/ppc: deprecate the machine type
 'prep', replaced by '40p'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herv? Poussineau <hpoussin@reactos.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


> On Aug 11, 2018, at 1:40 AM, qemu-devel-request@nongnu.org wrote:
>=20
>=20
> Hello,
>=20
> Le 10/08/2018 ? 18:17, Programmingkid a ?crit?:
>>=20
>> Can a real 40p machine boot Windows NT 4.0 PowerPC?
>>=20
>>=20
>=20
> Yes.
>=20
> A real 40p machine is able to run (at least):
> - Windows NT (up to 4.0 SP1)
> - AIX (up to 4.3.3)
> - the beta of OS/2 PowerPC
> - Solaris
> - Linux
> - NetBSD/PReP
>=20
> However, Windows NT emulation doesn't work so well. OpenBIOS doesn't =
support (yet)
> booting from the floppy drive.

I don't think floppy drive usage is necessary for Windows NT 4.0. I have =
installed the x86 version many times without having to use a floppy =
drive or a floppy image file.=20

https://www.youtube.com/watch?v=3DXpAOCJFqImM
This video shows someone installing Windows NT 4.0 on a Motorola =
PowerStack 2 (PReP?) with only the CD-ROM drive.=
