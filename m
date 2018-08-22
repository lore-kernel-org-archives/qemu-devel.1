Received: from eggs.gnu.org ([2001:4830:134:3::10]:40938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQFM-0004HR-Ct
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQFI-0004Rr-BZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:20:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQFI-0004Rh-5O
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:20:12 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180821081029.26121-3-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Tue, 21 Aug 2018 16:10:21 +0800")
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
	<20180821081029.26121-3-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:20:01 +0200
Message-ID: <87mute4sa6.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 02/10] migration: fix counting normal
 page for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> The compressed page is not normal page
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
