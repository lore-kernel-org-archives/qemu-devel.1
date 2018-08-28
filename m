Received: from eggs.gnu.org ([2001:4830:134:3::10]:35648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fufbw-0007aY-Bn
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fufQj-0004nE-TP
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fufQj-0004mt-LC
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:57:17 -0400
Date: Tue, 28 Aug 2018 11:57:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180828145714.GI5675@localhost.localdomain>
References: <1535199590-68475-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535199590-68475-1-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V4 0/4] introduce coalesced pio support
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

On Sat, Aug 25, 2018 at 08:19:46PM +0800, Peng Hao wrote:
[...]
> Peng Hao (4):
>   target-i386: introduce coalesced_pio kvm header update
>   target-i386:add coalesced_pio API
>   target-i386: add rtc 0x70 port as coalesced_pio
>   target-i386: add i440fx 0xcf8 port as coalesced_pio

Do you have a summary of the changes between v3 and v4?

-- 
Eduardo
