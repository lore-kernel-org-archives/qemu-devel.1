Received: from eggs.gnu.org ([2001:4830:134:3::10]:33396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cavery@redhat.com>) id 1eihcc-00054x-QU
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cavery@redhat.com>) id 1eihcX-0001o1-5y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:19:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cavery@redhat.com>) id 1eihcX-0001ji-07
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:19:45 -0500
From: Cathy Avery <cavery@redhat.com>
Message-ID: <5A7867F5.6080500@redhat.com>
Date: Mon, 5 Feb 2018 09:19:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] virtio-blk discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: changpeng.liu@intel.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi,

I am looking at extending virtio-blk by adding support for the discard 
request.

https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03889.html

My understanding is that you have already begun this work with [PATCH] 
virtio-blk: add DISCARD support to virtio-blk drive

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05146.html

Are you intending to finish the implementation? I don't want to start a 
development effort if you are already working on it.

Thanks,

Cathy Avery
