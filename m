Received: from eggs.gnu.org ([2001:4830:134:3::10]:50462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1eRAev-0002cr-Tk
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1eRAes-0003bh-GB
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:41:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2123 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sochin.jiang@huawei.com>)
	id 1eRAes-0003VD-4T
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:41:42 -0500
From: sochin.jiang <sochin.jiang@huawei.com>
Message-ID: <b74a4929-26ed-711a-6d90-c6c06b492fd8@huawei.com>
Date: Tue, 19 Dec 2017 13:41:12 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] virtio-9p: hot-plug/unplug about virtio-9p device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ego@in.ibm.com, aliguori@us.ibm.com, aneesh.kumar@linux.vnet.ibm.com
Cc: Jiangyiwen <jiangyiwen@huawei.com>, sochin.jiang@huawei.com, qemu-devel@nongnu.org


     Hi, guys.

    I'm looking for the hot-plug/unplug features of virtio-9p device recently, and found there's a lack of support.

    I am wondering why ? Is there a reason. Actually, I write a qmp command to support fsdev_add, then a device_add qmp will    

    successfully add a virtio-9p device(just like virtio-blk).

   Whether there is some concerns that we haven't support this ? hope for a reply, thanks.


sochin.
