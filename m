Received: from eggs.gnu.org ([2001:4830:134:3::10]:56300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deib1-0002Gp-J0
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deiaw-0003Bv-SJ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:01:27 -0400
Date: Mon, 7 Aug 2017 16:01:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807140107.GF6578@localhost.localdomain>
References: <20170804152655.31510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804152655.31510-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: drop bdrv_set_key from
 BlockDriver
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

Am 04.08.2017 um 17:26 hat Paolo Bonzini geschrieben:
> This is not used anymore since c01c214b69 ("block: remove all encryption
> handling APIs", 2017-07-11).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to the block branch.

Kevin
