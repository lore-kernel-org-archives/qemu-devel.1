Received: from eggs.gnu.org ([209.51.188.92]:52276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hI1uW-00015q-Pu
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 22:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hI1uV-00078D-TF
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 22:08:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hI1uV-00076Z-Pg
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 22:08:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id v7so5442235qti.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 19:08:50 -0700 (PDT)
Date: Sat, 20 Apr 2019 22:08:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190420220659-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] some comments on virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

Hi guys!
Some comments about things to improve in the virtio
crypto device part of the spec:
https://news.ycombinator.com/item?id=19698399#19706987

It would be great if someone translated this to
github issues and tried to improve the spec by
addressing them.

Thanks!

-- 
MST
