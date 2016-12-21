Received: from eggs.gnu.org ([2001:4830:134:3::10]:46695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cJhSK-0003EY-Qu
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cJhSB-0000Ig-AG
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:01:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55722
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cJhSB-0000IW-4H
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:01:11 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBLDxR2B096968
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 09:01:10 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27ftcajqd0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 09:01:10 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 21 Dec 2016 07:01:08 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <c1db276f-4e5b-5953-df0d-c07130bbd0ff@fam-schranz.de>
References: <20161220210053.31842.32241@loki>
	<c1db276f-4e5b-5953-df0d-c07130bbd0ff@fam-schranz.de>
Date: Wed, 21 Dec 2016 08:00:52 -0600
Message-Id: <20161221140052.9877.16212@loki>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.8.0 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Holger Schranz <holger@fam-schranz.de>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com

Quoting Holger Schranz (2016-12-20 23:18:00)
> Hi Michael,
> =

> could it be, that the link to qemu-2.8.0.tar.bz2 is linked to the
> qemu-2.8.0-rc4.tar.bz2? The link for signature seems it is correct.

Argh, yes only one link was updated. Both links are correct now.

Thanks!

> =

> Best regards
> =

> Holger
> =

> Am 20.12.2016 um 22:00 schrieb Michael Roth:
> > Hello,
> >
> > On behalf of the QEMU Team, I'd like to announce the availability of
> > the QEMU 2.8.0 release. This release contains 1900+ commits from 201
> > authors.
> >
> > You can grab the tarball from our download page here:
> >
> >    http://wiki.qemu.org/Download
> >
> > The full list of changes are available at:
> >
> >    http://wiki.qemu.org/ChangeLog/2.8
> >
> > Highlights include:
> >
> >   * Support for fault-tolerant guests via COLO (COarse-grained LOck-ste=
pping)
> >   * Support for fast host/guest socket communication over virtio via AF=
_VSOCK
> >   * Support for compressed formats when generating live backups
> >   * Support for new virtio-crypto device
> >   * Improved display rendering when using SPICE GUI in OpenGL mode
> >   * ACPI support for NVDIMM device hotplug
> >
> >   * ARM: 'virt' machine support for ITS when using ACPI
> >   * ARM: Aspeed board improvements
> >   * ARM: STM32F2xx board (Netduino 2) support for ADC and SPI devices
> >   * MIPS: support for 24KEc CPUs
> >   * PPC: support for POWER9 CPUs and powernv platform
> >   * PPC: pseries support for more the 1TiB of guest memory and memory u=
nplug
> >   * PPC: pseries support PCI host bridge NUMA affinities
> >   * s390: support for CPU models and virtio-ccw revision 2
> >   * x86: support for Extended Interrupt Mode in emulated IOMMUs
> >   * x86: support for up to 288 CPUs on q35 machine type
> >   * Xen: unplug support for SCSI disks and xenlinux-compatible devices
> >
> >   * and lots more...
> >
> > Thank you to everyone involved!
> >
> >
> =

> =

> ---
> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft.
> https://www.avast.com/antivirus
>=20
