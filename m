Received: from eggs.gnu.org ([2001:4830:134:3::10]:49482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa6bR-0004yp-66
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa6bO-0002EL-1V
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:43:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fa6bN-0002Du-Rt
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:43:17 -0400
Date: Mon, 2 Jul 2018 18:43:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180702214315.GH7451@localhost.localdomain>
References: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_SEND_IPI CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Mon, Jul 02, 2018 at 06:22:51PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Adds PV_SEND_IPI CPUID feature bit.
> 

Thanks!

Paolo, Radim: can I assume the bit is already reserved and queue
this patch, or should I wait until the KVM patch is merged into
kvm.git?

-- 
Eduardo
