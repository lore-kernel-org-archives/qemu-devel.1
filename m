Received: from eggs.gnu.org ([2001:4830:134:3::10]:33356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eD5PJ-0007EV-Ur
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eD5PG-0006HA-IW
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:15:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171004152553.30263-1-mreitz@redhat.com>
	<20171004152553.30263-7-mreitz@redhat.com>
Date: Fri, 10 Nov 2017 10:15:02 +0100
In-Reply-To: <20171004152553.30263-7-mreitz@redhat.com> (Max Reitz's message
	of "Wed, 4 Oct 2017 17:25:53 +0200")
Message-ID: <874lq25wbt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 6/6] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Add a new test file (check-qobject.c) for unit tests that concern
> QObjects as a whole.
>
> Its only purpose for now is to test the qobject_is_equal() function.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
