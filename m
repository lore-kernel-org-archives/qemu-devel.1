Received: from eggs.gnu.org ([2001:4830:134:3::10]:42625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQnAj-00017h-2v
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQnAf-000068-5Y
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQnAe-00005w-Vz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:32:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E323A83F45
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:32:24 +0000 (UTC)
Date: Tue, 10 Jan 2017 05:32:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110053133-mutt-send-email-mst@kernel.org>
References: <1478772703-28185-1-git-send-email-thuth@redhat.com>
	<1478772703-28185-7-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478772703-28185-7-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PULL 6/6] MAINTAINERS: Remove obsolete stable
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Nov 10, 2016 at 11:11:43AM +0100, Thomas Huth wrote:
> There are only very old and orphaned stable branches listed
> in the MAINTAINERS file - so this section is pretty useless
> nowadays. Let's remove it.
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Could you add some kind of entry for stable though?
Otherwise people won't know which address to CC.

> ---
>  MAINTAINERS | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8575ab..4a60579 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1574,28 +1574,6 @@ F: tcg/tci/
>  F: tci.c
>  F: disas/tci.c
>  
> -Stable branches
> ----------------
> -Stable 1.0
> -L: qemu-stable@nongnu.org
> -T: git git://git.qemu-project.org/qemu-stable-1.0.git
> -S: Orphan
> -
> -Stable 0.15
> -L: qemu-stable@nongnu.org
> -T: git git://git.qemu-project.org/qemu-stable-0.15.git
> -S: Orphan
> -
> -Stable 0.14
> -L: qemu-stable@nongnu.org
> -T: git git://git.qemu-project.org/qemu-stable-0.14.git
> -S: Orphan
> -
> -Stable 0.10
> -L: qemu-stable@nongnu.org
> -T: git git://git.qemu-project.org/qemu-stable-0.10.git
> -S: Orphan
> -
>  Block drivers
>  -------------
>  VMDK
> -- 
> 1.8.3.1
> 
