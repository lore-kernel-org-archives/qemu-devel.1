Received: from eggs.gnu.org ([2001:4830:134:3::10]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkWTE-00024r-7C
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkWT9-0003lB-V7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:17:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkWT9-0003kO-P7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:17:19 -0400
Date: Wed, 23 Aug 2017 11:17:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823141716.GG27715@localhost.localdomain>
References: <20170815170051.127257-1-brijesh.singh@amd.com>
	<9ab5d26f-a35d-eae6-6d68-60dabc2c5238@amd.com>
	<f2a991e0-6006-e839-f6c8-090be9877037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a991e0-6006-e839-f6c8-090be9877037@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] target-i386/cpu: Add new EPYC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <rth@twiddle.net>

On Tue, Aug 22, 2017 at 05:49:30PM +0200, Paolo Bonzini wrote:
> On 22/08/2017 16:44, Brijesh Singh wrote:
> > Hi Eduardo and Paolo,
> > 
> > Please let me know if want me to address something else in this patch.
> > 
> > After this patch is accepted, I am planning to submit similar patch to
> > to libvirt to create EPYC CPU.
> 
> It looks good to me, but Eduardo is the maintainer and may spot
> something missing. :)
> 
> QEMU is now in freeze, but the patch can easily go in at the beginning
> of 2.11.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'm queueing it for 2.11 on my x86-next branch.

-- 
Eduardo
