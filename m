Received: from eggs.gnu.org ([2001:4830:134:3::10]:45405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewW02-00076Y-0E
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewW01-0002sw-9Z
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:45:06 -0400
Date: Thu, 15 Mar 2018 17:44:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180315164457.GD3876@localhost.localdomain>
References: <20180315143056.14144-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315143056.14144-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iscsi: fix iSER compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 15.03.2018 um 15:30 hat Paolo Bonzini geschrieben:
> This fails in Fedora 28.
> 
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to the block branch.

Kevin
