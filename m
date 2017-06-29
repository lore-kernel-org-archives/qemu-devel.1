Received: from eggs.gnu.org ([2001:4830:134:3::10]:47264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVFc-0001Ub-G5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVFb-0002vZ-QA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:56:36 -0400
Date: Thu, 29 Jun 2017 16:56:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629085621.GA28654@lemon.lan>
References: <20170628184724.21378-1-stefanha@redhat.com>
	<20170628184724.21378-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628184724.21378-6-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: fix virtio-net-test ISR
 dependence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 06/28 19:47, Stefan Hajnoczi wrote:
> Use the new used ring APIs instead of assuming ISR being set means the
> request has completed.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
