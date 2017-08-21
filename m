Received: from eggs.gnu.org ([2001:4830:134:3::10]:37789)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1djmSO-0003pp-45
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1djmSJ-0004GF-Be
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:09:28 -0400
Received: from verein.lst.de ([213.95.11.211]:58548 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1djmSJ-0004G8-5X
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:09:23 -0400
Date: Mon, 21 Aug 2017 15:09:21 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20170821130921.GA16988@lst.de>
References: <20170528130649.28168-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528130649.28168-1-dan@kernelim.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Fix get/set number of queues	feature,
	again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Aloni <dan@kernelim.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Alex Friedman <alex@e8storage.com>, Stefan Hajnoczi <stefanha@redhat.com>

This didn't seem to make it into mainline, does it need a ping?
