Received: from eggs.gnu.org ([2001:4830:134:3::10]:41272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coRH8-0002nX-1K
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coRH7-00080d-Ef
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:00:50 -0400
Date: Thu, 16 Mar 2017 10:00:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170316090034.GA4995@noname.redhat.com>
References: <20170315212811.15937-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315212811.15937-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockdev: fix bitmap clear undo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

Am 15.03.2017 um 22:28 hat John Snow geschrieben:
> Only undo the action if we actually prepared the action.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin
