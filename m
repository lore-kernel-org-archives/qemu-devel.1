Received: from eggs.gnu.org ([2001:4830:134:3::10]:46366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eM5As-0001ji-F4
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 23:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eM5Ap-0002T1-Al
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 23:49:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eM5Ap-0002Sd-46
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 23:49:39 -0500
Date: Tue, 5 Dec 2017 06:49:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171205064753-mutt-send-email-mst@kernel.org>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
	<20171129091847.GC12220@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129091847.GC12220@lemon>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com

On Wed, Nov 29, 2017 at 05:18:47PM +0800, Fam Zheng wrote:
> On Wed, 11/29 01:02, no-reply@patchew.org wrote:
> > /tmp/cc3Czn0R.s: Fatal error: can't write 3947 bytes to section .debug_str of hw/arm/virt-acpi-build.o because: 'No space left on device'
> 
> Hmm, the host is shared and what I have is a normal user account, so there is no
> control over disk space availability.  Anyway this is completely unrelated to
> this series. Sorry for the noise.
> 
> Fam

Could you disable this until you have the time to detect disk full
errors?  You are training people to ignore this bot, not a good thing.
