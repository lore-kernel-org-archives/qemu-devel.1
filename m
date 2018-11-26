Received: from eggs.gnu.org ([2001:4830:134:3::10]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRDqT-0005yq-D6
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRDqO-00063j-T2
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:10:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRDqO-000638-OK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:10:20 -0500
Date: Mon, 26 Nov 2018 11:10:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126101018.jnisucsvcxgmsbd3@sirius.home.kraxel.org>
References: <20181123064646.23036-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123064646.23036-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] cirrus_vga/migration: update the bank
 offset before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, maoming.maoming@huawei.com, Wang Xin <wangxinxin.wang@huawei.com>

On Fri, Nov 23, 2018 at 02:46:46PM +0800, linzhecheng wrote:
> From: Wang Xin <wangxinxin.wang@huawei.com>
> 
> The cirrus bank0/1 offset should be updated before we update the vram's alias
> offset.

Queued for 3.1

thanks,
  Gerd
