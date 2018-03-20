Received: from eggs.gnu.org ([2001:4830:134:3::10]:34042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <florolf@n621.de>) id 1eyLiw-000464-LH
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <florolf@n621.de>) id 1eyLiv-0005Sg-PJ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:11:02 -0400
Received: from nyx.n621.de ([2a01:4f8:151:8ffd:2::1]:32861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <florolf@n621.de>) id 1eyLiv-0005RK-IX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:11:01 -0400
Date: Tue, 20 Mar 2018 19:11:00 +0100
From: Florian Larysch <fl@n621.de>
Message-ID: <20180320181100.GE15157@nyx.n621.de>
References: <20180320173324.30844-1-fl@n621.de>
	<48d11603-23ba-ddbb-34a6-8ba345ac5d28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d11603-23ba-ddbb-34a6-8ba345ac5d28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de

On Tue, Mar 20, 2018 at 01:00:40PM -0500, Eric Blake wrote:
> Here after the --- is a nice place to summarize how v3 differs from
> v2, to save reviewers some time. 

The triviality of the change didn't seem to warrant that, but in
retrospect, I realize that searching for the sole trivial change when
reviewing a patch is also (or even more of) a burden. I'll keep that in
mind for the future.

> Also, if all that is wrong is a typo in the commit message, a
> maintainer is often willing to fix that up without you having to
> send a new revision

I interpreted your comment on the v2 as a request for me to fix that.
Sorry for the churn.

Florian
