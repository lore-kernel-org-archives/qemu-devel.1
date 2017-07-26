Received: from eggs.gnu.org ([2001:4830:134:3::10]:40744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRRC-0005jw-5n
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRR7-0006tR-C5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daRR7-0006su-61
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:53:33 -0400
Date: Wed, 26 Jul 2017 15:53:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170726185325.GH5167@localhost.localdomain>
References: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
	<1501049917-4701-3-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501049917-4701-3-git-send-email-wang.yi59@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hmp: allow apic-id for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, imammedo@redhat.com, qemu-devel@nongnu.org, liu.yunh@zte.com.cn, Liu.Jianjun3@zte.com.cn

On Wed, Jul 26, 2017 at 02:18:37AM -0400, Yi Wang wrote:
> Add [apic-id] support for hmp command "info lapic", which is
> useful when debugging ipi and so on. Current behavior is not
> changed when the parameter isn't specified.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Queued for 2.11 on x86-next.  Thanks.

-- 
Eduardo
