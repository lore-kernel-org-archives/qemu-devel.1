Received: from eggs.gnu.org ([2001:4830:134:3::10]:37709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJfxn-0000tL-2p
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJfxg-0005O5-1P
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:34:45 -0500
Date: Mon, 5 Nov 2018 15:29:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181105142924.GD10880@linux.fritz.box>
References: <20181104180900.7527-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104180900.7527-1-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/1] vdi: Use a literal number of bytes
 for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

Am 04.11.2018 um 19:09 hat Leonid Bloch geschrieben:
> Please see the commit message for the rationale.
> 
> Difference from v1:
> * Format string is fixed.

Thanks, applied to the block branch.

Kevin
