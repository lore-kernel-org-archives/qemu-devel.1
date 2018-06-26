Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1fXdAS-00030D-Vj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1fXdAP-0007TP-EN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:53:17 -0400
Date: Mon, 25 Jun 2018 19:56:24 -0600
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20180626015624.GD4106@localhost.localdomain>
References: <20180626014452.GA1858@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626014452.GA1858@bogon.didichuxing.com>
Subject: Re: [Qemu-devel] [Qemu-block][RFC PATCH] hw/block/nvme: add
 optional parameter num_queues for nvme device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiping Zhang <zhangweiping@didichuxing.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, Jun 26, 2018 at 09:44:56AM +0800, Weiping Zhang wrote:
> Add an optional paramter num_queues for device, and set it
> to 64 by default.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>

Looks good to me.

Acked-by: Keith Busch <keith.busch@intel.com>
