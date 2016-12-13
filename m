Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cGhfJ-0000wm-7g
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cGhfI-0002W6-Ew
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:38:21 -0500
Date: Tue, 13 Dec 2016 08:38:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161213073812.GA4443@noname.str.redhat.com>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212181237.3aymdmenxeu2kwjj@grep.be>
Subject: Re: [Qemu-devel] [Qemu-block] [Nbd] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Eric Blake <eblake@redhat.com>, nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com

Am 12.12.2016 um 19:12 hat Wouter Verhelst geschrieben:
> I'm not opposed to this proposal, per se, but there seems to be some
> disagreement (by Kevin, for instance) on whether this extension is at
> all useful.

FWIW, I'm not opposed to adding the flag. I don't think it can hurt, but
I wanted to ask the question so that we don't end up adding a feature
that noone actually uses. Ultimately it's your call as a maintainer
anyway how conservative you want to be with spec additions.

Kevin
