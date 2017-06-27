Received: from eggs.gnu.org ([2001:4830:134:3::10]:43639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPlnm-0006I4-D2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPlnl-0005wd-Mn
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:24:50 -0400
Date: Tue, 27 Jun 2017 16:24:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170627082441.GF14166@lemon.lan>
References: <20170505021500.19315-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505021500.19315-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Enhance block status when crossing
 EOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, 05/04 21:14, Eric Blake wrote:
> Thus, this is a followup to that series, but I'm also okay if we
> think it is too much maintenance compared to the potential gains,
> and decide to drop it after all.

The comments are good enough and I like how this makes the function interface a
bit more powerful. Fixed the typo as pointed out by Stefan and applied. Thanks!

Fam
