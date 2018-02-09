Received: from eggs.gnu.org ([2001:4830:134:3::10]:32782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ek1qK-0007cO-5T
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ek1qG-0008Dl-W5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:07:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ek1qG-0008DM-SK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:07:24 -0500
Date: Fri, 9 Feb 2018 14:07:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180209060710.GB2783@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
	<151808912011.285.15166058884960463518@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151808912011.285.15166058884960463518@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PATCH v6 00/28] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, aarcange@redhat.com, quintela@redhat.com, a.perevalov@samsung.com, dgilbert@redhat.com

On Thu, Feb 08, 2018 at 03:25:21AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.

For all the five patchew reports: I forgot to add based-on tag.  This
series is based on monitor-oob series.

-- 
Peter Xu
