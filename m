Received: from eggs.gnu.org ([2001:4830:134:3::10]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJyWB-00016Q-5T
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJyW7-0006Il-73
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:18:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJyW7-0006II-12
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:18:55 -0500
Date: Wed, 29 Nov 2017 17:18:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129091847.GC12220@lemon>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151194617493.816.13426298875361921541@bafd83ae6430>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, ehabkost@redhat.com, mst@redhat.com, marcel@redhat.com, imammedo@redhat.com

On Wed, 11/29 01:02, no-reply@patchew.org wrote:
> /tmp/cc3Czn0R.s: Fatal error: can't write 3947 bytes to section .debug_str of hw/arm/virt-acpi-build.o because: 'No space left on device'

Hmm, the host is shared and what I have is a normal user account, so there is no
control over disk space availability.  Anyway this is completely unrelated to
this series. Sorry for the noise.

Fam
