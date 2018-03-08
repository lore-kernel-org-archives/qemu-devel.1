Received: from eggs.gnu.org ([2001:4830:134:3::10]:36086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etl3B-00005c-Cy
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etl3A-0007Oo-KM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:12:57 -0500
Date: Thu, 8 Mar 2018 10:12:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180308021241.GM13844@lemon.usersys.redhat.com>
References: <20180205202232.19254-1-mreitz@redhat.com>
	<73838a0c-d960-d24d-b706-a0ecbcbe7aaf@redhat.com>
	<20180307100424.GA7917@localhost.localdomain>
	<2d97780c-4a06-1b08-8211-760fc3567c2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d97780c-4a06-1b08-8211-760fc3567c2a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 03/07 12:50, John Snow wrote:
> It's something I'd like to see patchew do, actually:
> 
> "Here's a list of what's on the list that has no reviews or NACKs, and
> needs some love"

It's not hard to define a search condition for that:

http://patchew.org/search-help

http://patchew.org/search?q=project%3AQEMU+age%3A%3E1m+not%3Areviewed+not%3Areplied+not%3Amerged+is%3Atested+to%3Aqemu-block

> 
> coupled with a 30 day "Hey, nobody looked at this" ping to the list
> before it NACKs a set for being too old.

If the initial landing of the patch didn't get enough attention, chances are the
pings will not change much about it especially it's from a bot.

A summary list sounds good, though.

Fam
