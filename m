Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVHNi-0002qC-IJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVHNh-0008DF-Sz
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:45:30 -0500
Date: Fri, 7 Dec 2018 15:45:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181207144519.GF5119@linux.fritz.box>
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-5-kwolf@redhat.com>
	<87in05wkev.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in05wkev.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] iotests: Add VMDK tests for
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 07.12.2018 um 14:12 hat Markus Armbruster geschrieben:
> git-am complains
> 
>     Applying: iotests: Add VMDK tests for blockdev-create
>     .git/rebase-apply/patch:281: trailing whitespace.
>                 format: 
>     .git/rebase-apply/patch:308: trailing whitespace.
>                 format: 
>     .git/rebase-apply/patch:335: trailing whitespace.
>                 format: 
>     .git/rebase-apply/patch:600: new blank line at EOF.
>     +
>     warning: 4 lines add whitespace errors.

This is in the reference output, so trailing whitespace/blank lines are
actually correct.

Kevin
