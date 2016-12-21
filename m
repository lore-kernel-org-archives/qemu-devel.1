Received: from eggs.gnu.org ([2001:4830:134:3::10]:39053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cJZIC-00026I-MN
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 00:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cJZI7-0007ln-OX
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 00:18:20 -0500
Received: from smtp2-2.goneo.de ([85.220.129.34]:38695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <holger@fam-schranz.de>)
	id 1cJZI7-0007lK-Hw
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 00:18:15 -0500
References: <20161220210053.31842.32241@loki>
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <c1db276f-4e5b-5953-df0d-c07130bbd0ff@fam-schranz.de>
Date: Wed, 21 Dec 2016 06:18:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161220210053.31842.32241@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.8.0 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com

Hi Michael,

could it be, that the link to qemu-2.8.0.tar.bz2 is linked to the
qemu-2.8.0-rc4.tar.bz2? The link for signature seems it is correct.

Best regards

Holger

Am 20.12.2016 um 22:00 schrieb Michael Roth:
> Hello,
>
> On behalf of the QEMU Team, I'd like to announce the availability of
> the QEMU 2.8.0 release. This release contains 1900+ commits from 201
> authors.
>
> You can grab the tarball from our download page here:
>
>    http://wiki.qemu.org/Download
>
> The full list of changes are available at:
>
>    http://wiki.qemu.org/ChangeLog/2.8
>
> Highlights include:
>
>   * Support for fault-tolerant guests via COLO (COarse-grained LOck-stepp=
ing)
>   * Support for fast host/guest socket communication over virtio via AF_V=
SOCK
>   * Support for compressed formats when generating live backups
>   * Support for new virtio-crypto device
>   * Improved display rendering when using SPICE GUI in OpenGL mode
>   * ACPI support for NVDIMM device hotplug
>
>   * ARM: 'virt' machine support for ITS when using ACPI
>   * ARM: Aspeed board improvements
>   * ARM: STM32F2xx board (Netduino 2) support for ADC and SPI devices
>   * MIPS: support for 24KEc CPUs
>   * PPC: support for POWER9 CPUs and powernv platform
>   * PPC: pseries support for more the 1TiB of guest memory and memory unp=
lug
>   * PPC: pseries support PCI host bridge NUMA affinities
>   * s390: support for CPU models and virtio-ccw revision 2
>   * x86: support for Extended Interrupt Mode in emulated IOMMUs
>   * x86: support for up to 288 CPUs on q35 machine type
>   * Xen: unplug support for SCSI disks and xenlinux-compatible devices
>
>   * and lots more...
>
> Thank you to everyone involved!
>
>


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft.
https://www.avast.com/antivirus
