Received: from eggs.gnu.org ([2001:4830:134:3::10]:57773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1U9Q-0001cW-5Q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1U9M-0005vu-92
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:42:48 -0400
Date: Fri, 21 Apr 2017 16:42:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170421084238.GC8342@lemon.lan>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-3-famz@redhat.com>
	<20170421083528.GB4318@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421083528.GB4318@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 02/20] qapi: Add 'force-shared-write'
 to blockdev-add arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, 04/21 10:35, Kevin Wolf wrote:
> Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 
> As far as I am concerned, this could be squashed into patch 1, though.
> Adding a new field to the schema is an integral part of adding a new
> option, I think.

Makes sense.

Fam
