Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce2dP-000777-8r
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce2dK-0003MF-Cz
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:40:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ce2dK-0003M1-0W
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:40:46 -0500
Date: Wed, 15 Feb 2017 18:40:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170215183952-mutt-send-email-mst@kernel.org>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<111628dff0803a21b75cc390858f0c288decee22.1487139038.git.ben@skyportsystems.com>
	<20170215131903.2394b096@nial.brq.redhat.com>
	<6d3caba0-c747-457d-0fee-b02f7f09e50a@redhat.com>
	<20170215170757.59fe54de@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170215170757.59fe54de@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/7] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, ben@skyportsystems.com, qemu-devel@nongnu.org

On Wed, Feb 15, 2017 at 05:07:57PM +0100, Igor Mammedov wrote:
> > Those improvements can be added later, IMO -- but please do work out
> > with Igor whether he really wants a v7 for those.
> since it's minor fixes not influencing other patches within series
> there is not need to repost whole series,
> just this fixed up patch as replay to this thread tagged as v7
> or a patch on top, I'm fine with either way.

OK, I'll merge v7, send more cleanups/fixes as patches on top pls.

-- 
MST
