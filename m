Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dADQB-0005oz-Ka
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dADQA-0000ev-Ty
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:40:11 -0400
Date: Mon, 15 May 2017 18:40:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170515104003.GC23262@lemon.lan>
References: <20170509094837.22852-1-berrange@redhat.com>
	<13946c13-8d93-8832-d509-bf8f7be3f419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13946c13-8d93-8832-d509-bf8f7be3f419@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/4] Improve convert and dd commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri, 05/12 19:41, Max Reitz wrote:
> The fun is increased by the fact that the locking series has
> (inadvertently) removed the -B documentation from convert, so there is
> another conflict looming in the future...

Sorry about the mistake there..

I've posted a patch for that:

[Qemu-devel] [PATCH] qemu-img: Fix documentation of convert

Fam
