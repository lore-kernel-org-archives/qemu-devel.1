Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhSea-0008GZ-KE
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhSeW-0006of-J4
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:41:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhSeW-0006oZ-D3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:40:56 -0400
Date: Mon, 23 Jul 2018 12:40:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723044041.GD2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-5-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719121520.30026-5-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] migration: introduce
 save_zero_page_to_file
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

On Thu, Jul 19, 2018 at 08:15:16PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> It will be used by the compression threads
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
