Received: from eggs.gnu.org ([2001:4830:134:3::10]:50771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er6Wx-00049M-6x
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er6Ww-0001IA-IQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:32:43 -0500
Date: Wed, 28 Feb 2018 19:32:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228183229.GP4855@localhost.localdomain>
References: <151948268391.967.15904941335963452518@bdbb90650ae5>
	<6afb67e2-791f-ca17-4028-906f6f01abfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6afb67e2-791f-ca17-4028-906f6f01abfa@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 00/21] blockjobs: add explicit job
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com

Am 27.02.2018 um 22:01 hat John Snow geschrieben:
> All false positives unless someone really would like to advocate for me
> to change the format of the table.

Agreed, this isn't going to stop the series. Changing the format of the
table would make it much harder to read.

Kevin
