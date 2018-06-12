Received: from eggs.gnu.org ([2001:4830:134:3::10]:36832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSjSy-0006IY-Gc
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSjSx-0003C7-PA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:36:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-8-mreitz@redhat.com>
Date: Tue, 12 Jun 2018 15:35:57 +0200
In-Reply-To: <20180611205203.2624-8-mreitz@redhat.com> (Max Reitz's message of
	"Mon, 11 Jun 2018 22:52:00 +0200")
Message-ID: <87sh5st9du.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 07/10] tests: Add QDict clone-flatten
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> This new test verifies that qdict_flatten() does not modify a shallow
> clone of the given QDict.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
