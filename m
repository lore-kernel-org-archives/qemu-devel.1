Received: from eggs.gnu.org ([2001:4830:134:3::10]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ek9By-0006Ae-2k
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ek9Bx-0002Fd-AL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:58:18 -0500
Date: Fri, 9 Feb 2018 14:58:09 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180209135807.7gugj2hxxknc7fdo@eukaryote>
References: <20180209052915.12855-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209052915.12855-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Feb 09, 2018 at 01:29:12PM +0800, Fam Zheng wrote:
> v7: Tweak wording again "allowing concurrent writers" -> "allowing other QEMU
>     processes to open it in write mode". [Eric, Stefan, Kevin]
>     Add patch to document share-rw. [Stefan]
> 
> v6: Tweak wording ("concurrent writers"). [Max]
> 
> Fam Zheng (3):
>   qemu-img.texi: Clean up parameter list
>   qemu-img: Document --force-share / -U
>   docs: Document share-rw property more thoroughly
> 
>  docs/qemu-block-drivers.texi | 10 ++++++
>  qemu-img.texi                | 74 ++++++++++++++++++++++++++++----------------
>  2 files changed, 57 insertions(+), 27 deletions(-)

Thanks!

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

-- 
/kashyap
