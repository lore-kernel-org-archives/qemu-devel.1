Received: from eggs.gnu.org ([2001:4830:134:3::10]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cHUaq-0001Qx-9R
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cHUam-0006Fh-Ar
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:53:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:32656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1cHUam-0006F7-40
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:52:56 -0500
Date: Thu, 15 Dec 2016 12:47:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <421b6da7-1197-83a4-a8a1-e34bcf15904e@redhat.com>
Message-ID: <alpine.BSF.2.20.1612151245380.76554@zero.eik.bme.hu>
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
	<1481637176.27088.132.camel@redhat.com>
	<282345c0-fad3-eb66-63c5-3d1d24ab6d6d@redhat.com>
	<1481708165.8440.19.camel@redhat.com>
	<421b6da7-1197-83a4-a8a1-e34bcf15904e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr: Fix boot path of
 usb-host storage devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 14 Dec 2016, Thomas Huth wrote:
> in it? Certainly not SLOF. Maybe OpenBIOS? Does OpenBIOS support USB storage
> devices?

No it doesn't. Only keyboard HID devices.

Regards,
BALATON Zoltan
