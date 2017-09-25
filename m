Received: from eggs.gnu.org ([2001:4830:134:3::10]:49178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwVvc-0000Fr-1y
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwVvY-0002Yy-3b
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:08:16 -0400
Received: from smtp.citrix.com ([66.165.176.89]:15402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwVvX-0002YP-SP
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:08:12 -0400
Date: Mon, 25 Sep 2017 17:08:09 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170925160809.GC25986@perard.uk.xensource.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-3-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1505498999-17427-3-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/6] xen: defer call to xen_restrict
 until running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

On Fri, Sep 15, 2017 at 07:09:55PM +0100, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
