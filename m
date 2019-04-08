Received: from eggs.gnu.org ([209.51.188.92]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRgn-0008MI-C1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRgm-0001kj-KC
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:39:45 -0400
Date: Mon, 8 Apr 2019 12:39:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190408103939.GC11997@linux.fritz.box>
References: <20190408084056.26212-1-ghorges@xiyoulinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408084056.26212-1-ghorges@xiyoulinux.org>
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ghorges <ghorges@xiyoulinux.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 08.04.2019 um 10:40 hat ghorges geschrieben:
> ---
>  linux-user/syscall.c | 66 ++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Thomas already gave you some hints what to improve. I'd just like to add
that you shouldn't send the email to the qemu-block mailing list if the
patch is not about the block layer at all.

Kevin
