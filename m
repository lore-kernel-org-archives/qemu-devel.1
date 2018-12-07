Received: from eggs.gnu.org ([2001:4830:134:3::10]:33771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVLF6-0000i8-6q
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVLF3-0001U4-0c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:52:52 -0500
Date: Fri, 7 Dec 2018 18:52:45 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207185245.GP18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-19-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-19-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/18] xen: remove the legacy 'xen_disk'
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 03:08:44PM +0000, Paul Durrant wrote:
> This backend has now been replaced by the 'xen-qdisk' XenDevice.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
