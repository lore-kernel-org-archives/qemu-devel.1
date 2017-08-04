Received: from eggs.gnu.org ([2001:4830:134:3::10]:36721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dddgn-0002gO-71
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dddga-0001xu-Ln
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:34:57 -0400
Date: Fri, 4 Aug 2017 22:34:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170804143407.GC14780@lemon>
References: <20170804135545.28266-1-famz@redhat.com>
	<301cd265-7c95-e9da-7c30-e3c342bbae54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301cd265-7c95-e9da-7c30-e3c342bbae54@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Clarify about
 relative backing file options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 08/04 09:23, Eric Blake wrote:
> > +If a relative path name is given, the backing file is looked up against
> > +@var{filename}, rather than the current working directory.
> 
> Maybe better as:
> the backing file is looked up relative to the directory containing
> @var{filename}

Sounds good, will update.
