Received: from eggs.gnu.org ([2001:4830:134:3::10]:60600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ek9yT-0005dA-St
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ek9yS-0007fj-MU
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:48:25 -0500
Date: Fri, 9 Feb 2018 15:47:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209144758.GE3998@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

Am 09.02.2018 um 06:29 hat Fam Zheng geschrieben:
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

Thanks, applied to the block branch.

Kevin
