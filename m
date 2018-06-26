Received: from eggs.gnu.org ([2001:4830:134:3::10]:45836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXp58-0001J3-4M
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXp57-0006Ls-9l
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:36:34 -0400
Date: Tue, 26 Jun 2018 16:36:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180626143625.GB3964@dhcp-200-186.str.redhat.com>
References: <20180626014452.GA1858@bogon.didichuxing.com>
	<20180626015624.GD4106@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626015624.GD4106@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] hw/block/nvme: add
 optional parameter num_queues for nvme device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>
Cc: Weiping Zhang <zhangweiping@didichuxing.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 26.06.2018 um 03:56 hat Keith Busch geschrieben:
> On Tue, Jun 26, 2018 at 09:44:56AM +0800, Weiping Zhang wrote:
> > Add an optional paramter num_queues for device, and set it
> > to 64 by default.
> > 
> > Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
> 
> Looks good to me.
> 
> Acked-by: Keith Busch <keith.busch@intel.com>

Thanks, applied to the block branch.

Kevin
