Received: from eggs.gnu.org ([2001:4830:134:3::10]:59139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHx2t-0006CO-6m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHx2p-0001WY-6X
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:48:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHx2p-0001W2-0m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:48:03 -0400
Date: Mon, 5 Jun 2017 15:47:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170605184757.GA5016@thinpad.lan.raisama.net>
References: <20170605155655.19315-1-ehabkost@redhat.com>
	<20170605190434-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605190434-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] pc: Use "min-[x]level" on compat_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

On Mon, Jun 05, 2017 at 07:07:21PM +0300, Michael S. Tsirkin wrote:
[...]
> 
> With above tweaks:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> feel free to merge this through your tree.

Thanks.  Queued on my x86-next branch.

-- 
Eduardo
