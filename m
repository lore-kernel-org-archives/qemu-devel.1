Received: from eggs.gnu.org ([2001:4830:134:3::10]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnnMO-0005H0-0i
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnnMJ-0004hp-Ul
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:55:52 -0400
Date: Fri, 1 Sep 2017 22:55:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170901145531.GA656@lemon.lan>
References: <20170901105434.3288-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901105434.3288-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 09/01 11:54, Daniel P. Berrange wrote:
> Two recently added iotests are currently breaking 'check -luks',
> fix the easy one and disable the hard one.

I can add -luks to the test-block series with this, thanks for the quick fix!

Tested-by: Fam Zheng <famz@redhat.com>
