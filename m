Received: from eggs.gnu.org ([2001:4830:134:3::10]:39292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5UUl-0004Ak-6N
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5UUg-0006uM-65
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:25:39 -0400
Received: from smtp.citrix.com ([66.165.176.89]:19668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5UUf-0006tJ-UM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:25:34 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23017.53018.149469.676582@mariner.uk.xensource.com>
Date: Fri, 20 Oct 2017 11:25:30 +0100
In-Reply-To: <20171019164728.GC11934@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-2-git-send-email-ian.jackson@eu.citrix.com>
	<23003.41880.818255.728737@mariner.uk.xensource.com>
	<20171010103215.GD1771@perard.uk.xensource.com>
	<23016.54514.243025.328812@mariner.uk.xensource.com>
	<20171019164728.GC11934@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Anthony PERARD writes ("Re: [PATCH 1/8] xen: link against xentoolcore"):
> On Thu, Oct 19, 2017 at 05:38:10PM +0100, Ian Jackson wrote:
> > We still need this patch for the rest of the series, though.
> 
> Of course, I was only arguing that this patch on its own is not usefull.

Right.  I wanted to accurately reflect the situation in the commit
message, hence the explanation.

> Do you need a signed-off-by or review-by from me? Since it looks like
> I'm the author.

Indeed, so I don't think it makes sense for you to say you've reviewed
it.

Ian.
