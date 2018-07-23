Received: from eggs.gnu.org ([2001:4830:134:3::10]:42144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhSlf-0001B3-O7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhSlc-0000Vq-Nu
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:48:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhSlc-0000Vc-Ij
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:48:16 -0400
Date: Mon, 23 Jul 2018 12:48:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723044802.GE2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-6-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719121520.30026-6-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] migration: drop the return value of
 do_compress_ram_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Jul 19, 2018 at 08:15:17PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> It is not used and cleans the code up a little
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
