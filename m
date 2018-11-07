Received: from eggs.gnu.org ([2001:4830:134:3::10]:51734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKTAX-0004Jo-Mq
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKTAT-0004t1-ND
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:07:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gKTAT-0004sb-H9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:07:09 -0500
Date: Wed, 7 Nov 2018 17:07:03 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181107190703.GE12503@habkost.net>
References: <20181107152434.22219-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107152434.22219-1-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH] i386: Rename bools in PCMachineState to
 end in _enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Nov 07, 2018 at 09:24:34AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This makes their function more clear and prevents conflicts when adding
> the actual devices to the machine state, if necessary.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>

Thanks, queueing for 3.2.

-- 
Eduardo
