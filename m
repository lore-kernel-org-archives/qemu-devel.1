Received: from eggs.gnu.org ([2001:4830:134:3::10]:35262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwsYX-0000JZ-T6
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwsYU-0000Mg-RK
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:22:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwsYU-0000MN-KV
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:22:26 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180903092644.25812-4-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Mon, 3 Sep 2018 17:26:43 +0800")
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-4-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 19:22:19 +0200
Message-ID: <875zzm3390.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/4] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Currently, it includes:
> pages: amount of pages compressed and transferred to the target VM
> busy: amount of count that no free thread to compress data
> busy-rate: rate of thread busy
> compressed-size: amount of bytes after compression
> compression-rate: rate of compressed size
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
