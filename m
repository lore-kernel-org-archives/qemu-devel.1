Received: from eggs.gnu.org ([2001:4830:134:3::10]:33583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLQvy-0006VK-O7
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLQvy-0002L7-0B
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:23:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180523095830.24362-2-kwolf@redhat.com> (Kevin Wolf's message
	of "Wed, 23 May 2018 11:58:29 +0200")
References: <20180523095830.24362-1-kwolf@redhat.com>
	<20180523095830.24362-2-kwolf@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 23 May 2018 12:23:45 +0200
Message-ID: <87wovubrgu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-iotests: Add more tests to
 "migration" group
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

Kevin Wolf <kwolf@redhat.com> wrote:
> grep for "migrate" turns up a few test cases which use migration, but
> haven't been in the "migration" group so far. Add them to the group.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks
