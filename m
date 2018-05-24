Received: from eggs.gnu.org ([2001:4830:134:3::10]:58856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLkww-00033s-Ie
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fLkww-0002kg-0S
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:46:14 -0400
Date: Thu, 24 May 2018 15:46:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180524074606.GA12594@lemon.usersys.redhat.com>
References: <20180521085834.15632-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521085834.15632-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] nvme: Make nvme_init error handling
 code more readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com

On Mon, 05/21 16:58, Fam Zheng wrote:
> Coverity doesn't like the tests under fail label (report CID 1385847).
> Reset the fields so the clean up order is more apparent.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Queued, thanks.

Fam
