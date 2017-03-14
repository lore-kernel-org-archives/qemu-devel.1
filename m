Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnp8u-0002sH-D0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnp8t-0006Ae-Mh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:17:48 -0400
Date: Tue, 14 Mar 2017 17:17:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314161740.GN3952@noname.str.redhat.com>
References: <20170314161205.19415-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314161205.19415-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 14.03.2017 um 17:12 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
