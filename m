Received: from eggs.gnu.org ([2001:4830:134:3::10]:34911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXmJJ-0007Aw-9i
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXmJF-0006qI-Jq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180626084300.12571-1-kwolf@redhat.com>
Date: Tue, 26 Jun 2018 13:38:50 +0200
In-Reply-To: <20180626084300.12571-1-kwolf@redhat.com> (Kevin Wolf's message
	of "Tue, 26 Jun 2018 10:43:00 +0200")
Message-ID: <87d0wdzsj9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi/job: The next release will be 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Commit 51f63ec7d tried to change all references to 2.13 into 3.0, but
> it failed to achieve this because it was not properly rebased on top of
> the series introducing qapi/job.json. Change the references now.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Can't see more of them.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
