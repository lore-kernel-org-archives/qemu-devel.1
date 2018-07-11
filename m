Received: from eggs.gnu.org ([2001:4830:134:3::10]:39586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdBbG-0001G2-Lu
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 05:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdBbG-0002mv-3Q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 05:39:54 -0400
Date: Wed, 11 Jul 2018 11:39:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180711093946.GC4266@localhost.localdomain>
References: <20180711070519.23633-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711070519.23633-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 153: Fix dead code
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

Am 11.07.2018 um 09:05 hat Fam Zheng geschrieben:
> This step was left behind my mistake. As suggested by the echoed text,
> the intention was to test two devices with the same image, with
> different options. The behavior should be the same as two QEMU
> processes. Complete it.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
