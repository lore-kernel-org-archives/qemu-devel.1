Received: from eggs.gnu.org ([2001:4830:134:3::10]:37916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvSG9-0004Dr-2S
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvSG5-0001aQ-Pk
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fvSG5-0001Wv-Co
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:05:33 -0400
Date: Thu, 30 Aug 2018 16:05:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180830190518.GR8359@habkost.net>
References: <1535644216-111422-1-git-send-email-peng.hao2@zte.com.cn>
	<1535644216-111422-4-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535644216-111422-4-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V5 3/4] target-i386: add rtc 0x70 port as
 coalesced_pio
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

On Thu, Aug 30, 2018 at 11:50:15PM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

There has been a misunderstanding.  I never sent a Reviewed-by
line for this patch.

-- 
Eduardo
