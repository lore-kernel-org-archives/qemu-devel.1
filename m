Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPGn-0001eA-HJ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPGk-00089R-UM
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:28:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cmPGk-000894-Od
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:28:02 -0500
Date: Fri, 10 Mar 2017 15:27:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170310182759.GB4694@thinpad.lan.raisama.net>
References: <1489151370-15453-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489151370-15453-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] hostmem: introduce
 host_memory_backend_mr_inited
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Mar 10, 2017 at 09:09:28PM +0800, Peter Xu wrote:
> This is a tiny cleanup series for host backend mem. Patch 1 introduced
> the new interface, patch 2 uses them. Please review, thanks.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing for 2.10, on my machine-next branch.

-- 
Eduardo
