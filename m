Received: from eggs.gnu.org ([2001:4830:134:3::10]:50189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyrq-0007gt-8c
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyrp-0005i5-M8
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:16:58 -0400
Date: Fri, 27 Jul 2018 17:16:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180727091649.GF19416@lemon.usersys.redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

On Fri, 07/27 14:53, Fam Zheng wrote:
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Actually cc qemu-stable@nongnu.org
