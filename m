Received: from eggs.gnu.org ([2001:4830:134:3::10]:35489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbWE-0005hP-Ig
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbWD-0008S1-KH
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:08:58 -0400
Date: Mon, 23 Jul 2018 16:08:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723140849.GI8817@localhost.localdomain>
References: <1531926509-8280-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531926509-8280-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Disable debug message by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Am 18.07.2018 um 17:08 hat Thomas Huth geschrieben:
> It's annoying to see this debug message every time you use vvfat.
> Disable it with the DLOG() macro by default, as it is done with the
> other debug messages in this file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin
