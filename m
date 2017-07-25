Received: from eggs.gnu.org ([2001:4830:134:3::10]:37149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZxkh-0002vE-Ls
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZxkd-0002rp-NX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:11:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Date: Tue, 25 Jul 2017 13:11:36 +0200
In-Reply-To: <1500973176-29235-1-git-send-email-kwolf@redhat.com> (Kevin
	Wolf's message of "Tue, 25 Jul 2017 10:59:36 +0200")
Message-ID: <87zibspy8n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Fix reference output for 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Commits 70f17a1 ('error: Revert unwanted change of warning messages')
> and e1824e5 ('qemu-iotests: Test 'info block'') had a semantic merge
> conflict, which results in failure for qemu-iotests case 186. Fix the
> reference output to consider the changes of 70f17a1.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
