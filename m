Received: from eggs.gnu.org ([2001:4830:134:3::10]:58211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSOzE-0001Wr-I1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSOzA-0003Zv-H9
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:16:20 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSOz8-0003Y2-Of
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:16:16 -0500
Date: Thu, 29 Nov 2018 16:16:09 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181129161609.GH14786@perard.uk.xensource.com>
References: <154350643288.788685.710801848628732800.stgit@bahia.lan>
	<154350644254.788685.1054122983905807739.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154350644254.788685.1054122983905807739.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for 4.0 2/2] xen/9pfs: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Nov 29, 2018 at 04:47:22PM +0100, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
