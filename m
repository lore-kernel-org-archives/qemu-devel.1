Received: from eggs.gnu.org ([2001:4830:134:3::10]:54957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRDsC-0006s9-Q4
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRDs7-0007hT-Vm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRDs7-0007gd-Qc
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:12:07 -0500
Date: Mon, 26 Nov 2018 11:12:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126101205.ybiqw6kjywdaylx7@sirius.home.kraxel.org>
References: <20181120083419.17716-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120083419.17716-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb-host: set ifs.detached as true if
 kernel driver is not active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, jianjay.zhou@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com

On Tue, Nov 20, 2018 at 04:34:19PM +0800, linzhecheng wrote:
> If no kernel driver is active, we can already claim and perform I/O on
> it without detaching it.

Queued for 3.1

thanks,
  Gerd
