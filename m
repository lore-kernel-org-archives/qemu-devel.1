Received: from eggs.gnu.org ([2001:4830:134:3::10]:40275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d19Cm-00029J-5B
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d19Cl-0003vX-BX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:20:52 -0400
Date: Thu, 20 Apr 2017 12:20:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170420102040.GD4747@noname.redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
	<20170420075237.18219-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420075237.18219-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 04/20] qemu-img: Add --unsafe-read
 option to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 20.04.2017 um 09:52 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

This one conflicts with my block-next branch, probably Peter's
simplification of img_convert().

Kevin
