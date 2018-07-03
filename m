Received: from eggs.gnu.org ([2001:4830:134:3::10]:39989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1faG2L-0002aM-NJ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1faG2I-0003Ds-Hn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:47:45 -0400
Received: from mail-he1eur04hn030b.outbound.protection.outlook.com
	([2a01:111:f400:fe0d::30b]:19714
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1faG2H-0003DJ-P3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:47:42 -0400
Date: Tue, 3 Jul 2018 10:47:18 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180703074717.GB30904@rkaganb.sw.ru>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
	<42e1ca43-c31a-43a7-950e-57695c5ddd7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e1ca43-c31a-43a7-950e-57695c5ddd7f@redhat.com>
Subject: [Qemu-devel] patchew header docs [was: Re: [PATCH 0/6] hyperv:
 refactor HvSintRoute management]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jul 02, 2018 at 03:55:33PM -0500, Eric Blake wrote:
> On 07/02/2018 11:58 AM, Roman Kagan wrote:
> > This series modifies the management of HvSintRoute, which is an
> > important building block in Hyper-V emulation infrastructure, to make it
> > easier to maintain and enhance, and paves the way to the more complete
> > Synthetic Interrupt Controller (SynIC) emulation.
> > 
> > This series applies on top of "[PATCH 0/2] hyperv: ensure VP index equal
> > to QEMU cpu_index" series (message-id:
> > <20180702134156.13404-1-rkagan@virtuozzo.com>).
> 
> Rewriting that in a form that patchew can parse:
> 
> Based-on: 20180702134156.13404-1-rkagan@virtuozzo.com

Thanks!

Are patchew-recognized headers documented anywhere?

Roman.
