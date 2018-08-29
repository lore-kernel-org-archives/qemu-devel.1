Received: from eggs.gnu.org ([2001:4830:134:3::10]:45312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv3Yj-0008Q1-TX
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv3Yf-00016u-Vm
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fv3Yf-00016P-O7
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:43:05 -0400
Date: Wed, 29 Aug 2018 13:43:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180829164300.GL5675@localhost.localdomain>
References: <1535199590-68475-1-git-send-email-peng.hao2@zte.com.cn>
	<1535199590-68475-3-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535199590-68475-3-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V4 2/4]  target-i386:add coalesced_pio API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On Sat, Aug 25, 2018 at 08:19:48PM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
