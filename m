Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiyil-0004EF-NZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiyik-0001UA-W6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:07:35 -0400
Date: Fri, 27 Jul 2018 11:07:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180727090727.GB4355@localhost.localdomain>
References: <20180727065314.1656-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727065314.1656-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Handle EINTR in
 preallocation=full write
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

Am 27.07.2018 um 08:53 hat Fam Zheng geschrieben:
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
