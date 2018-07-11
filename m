Received: from eggs.gnu.org ([2001:4830:134:3::10]:46081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdCIo-0002qW-Up
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdCIo-0002Eu-7R
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:24:54 -0400
Date: Wed, 11 Jul 2018 12:24:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180711102444.GE4266@localhost.localdomain>
References: <20180711012227.31600-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711012227.31600-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Document copy offloading
 implications with -S and -c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 11.07.2018 um 03:22 hat Fam Zheng geschrieben:
> Explicitly enabling zero detection or compression suppresses copy
> offloading during convert. Document it.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
