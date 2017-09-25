Received: from eggs.gnu.org ([2001:4830:134:3::10]:54241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwWFn-00070i-2T
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwWFk-0003OI-00
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:29:07 -0400
Received: from smtp.citrix.com ([66.165.176.89]:56656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=434883a06=anthony.perard@citrix.com>)
	id 1dwWFj-0003N7-Ov
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:29:03 -0400
Date: Mon, 25 Sep 2017 17:28:59 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170925162859.GE25986@perard.uk.xensource.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<1505498999-17427-5-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1505498999-17427-5-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] xen: destroy_hvm_domain: Move
 reason into a variable
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

On Fri, Sep 15, 2017 at 07:09:57PM +0100, Ian Jackson wrote:
> We are going to want to reuse this.
> 
> No functional change.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>


-- 
Anthony PERARD
