Received: from eggs.gnu.org ([2001:4830:134:3::10]:36813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJfu9-0006jy-BZ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJfu8-0000zl-Dl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:31:01 -0500
Date: Mon, 5 Nov 2018 15:30:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181105143027.GE10880@linux.fritz.box>
References: <20181104180657.7471-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104180657.7471-1-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/1] include: Add a comment to explain
 the origin of
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

Am 04.11.2018 um 19:07 hat Leonid Bloch geschrieben:
> Please see the commit message for the rationale.
> 
> Difference from v1:
> * Tabs removed from the code indentation of the sample code in the
>   comment, in order to pass checkpatch.

Thanks, applied to the block branch.

Kevin
