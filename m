Received: from eggs.gnu.org ([2001:4830:134:3::10]:37149)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1djmQi-0002QX-Pg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1djmQd-0003qI-8R
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:07:44 -0400
Date: Mon, 21 Aug 2017 15:07:32 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20170821130732.GB16745@lst.de>
References: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
	<20170606073806.8180-2-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606073806.8180-2-quwenruo@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] nvme: Check PSDT flag for admin and	rw
	command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, keith.busch@intel.com

Can you send a patch with just the PSDT flag check?  The rest should
only be in an eventually patch to add SGL support.
