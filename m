Received: from eggs.gnu.org ([2001:4830:134:3::10]:56497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj673-0001ao-Bl
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj670-0002wg-68
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:24:21 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:61228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj66z-0002wU-UV
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:24:18 -0500
Date: Wed, 1 Mar 2017 15:24:08 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170301152408.GC1760@perard.uk.xensource.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1487861635-17560-3-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] xen: rename xen_modified_memory() to
 xen_hvm_modified_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Feb 23, 2017 at 02:53:52PM +0000, Paul Durrant wrote:
> This patch is a purely cosmetic change that avoids a name collision in
> a subsequent patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
