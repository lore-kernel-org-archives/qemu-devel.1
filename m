Received: from eggs.gnu.org ([2001:4830:134:3::10]:36408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRwFZ-0004hQ-MF
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRwFZ-0008MB-2L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:35:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRwFY-0008LU-TR
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:35:17 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181122072028.22819-2-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Thu, 22 Nov 2018 15:20:24 +0800")
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-2-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Nov 2018 10:35:08 +0100
Message-ID: <87zhtt1r5f.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/5] bitops: introduce change_bit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> It will be used by threaded workqueue
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
