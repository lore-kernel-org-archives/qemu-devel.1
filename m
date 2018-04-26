Received: from eggs.gnu.org ([2001:4830:134:3::10]:35994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBhyi-0003AT-H6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBhyd-0002Lj-KN
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:34:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:20800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBhyd-0002Jr-8u
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:34:27 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23265.58200.655918.190402@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 15:34:00 +0100
In-Reply-To: <0b6d4152-f949-6c7a-6855-baa8e7124407@redhat.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-2-git-send-email-ian.jackson@eu.citrix.com>
	<23265.45771.760936.993507@mariner.uk.xensource.com>
	<0b6d4152-f949-6c7a-6855-baa8e7124407@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/16] checkpatch: Add
 xendevicemodel_handle to the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Ross  Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> If no one has commented on what seems pretty trivial (especially since
> checkpatch.pl has no official maintainer, but is more of a
> "whoever-touched-it-last" file at the moment), then including the patch
> in your pull request is perfectly acceptable.  As a maintainer, it is
> also perfectly acceptable for you to ignore false positives from
> checkpatch (although documenting it in the commit message and/or cover
> letter never hurts, when you are intentionally ignoring a false positive).

Thanks for the comprehensive response.

> But, as there has also been a recent patch to teach checkpatch about
> glib types [1], your patch makes sense (any merge conflict between your
> patch and that one will be obvious to resolve).  So on that grounds,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks.

I will rebase onto current master before sending a pull request, so
I'll get to resolve that conflict.

Regards,
Ian.
