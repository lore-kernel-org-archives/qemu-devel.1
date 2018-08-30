Received: from eggs.gnu.org ([2001:4830:134:3::10]:37161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvSF7-0003SV-0m
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvSF3-0000xF-Ry
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fvSF3-0000w4-Hm
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:04:29 -0400
Date: Thu, 30 Aug 2018 16:04:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180830190424.GQ8359@habkost.net>
References: <1535644216-111422-1-git-send-email-peng.hao2@zte.com.cn>
	<1535644216-111422-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535644216-111422-2-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V5 1/4] target-i386: introduce
 coalesced_pio kvm header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, zhong.weidong@zte.com.cn

On Thu, Aug 30, 2018 at 11:50:13PM +0800, Peng Hao wrote:
> add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I think there was a misunderstanding. I never sent a Reviewed-by
line for this patch, because we need to get the KVM patch
accepted before including this.

-- 
Eduardo
