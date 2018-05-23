Received: from eggs.gnu.org ([2001:4830:134:3::10]:36027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLQxU-0008C0-UY
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLQxP-0003xp-NP
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:25:28 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180523095830.24362-3-kwolf@redhat.com> (Kevin Wolf's message
	of "Wed, 23 May 2018 11:58:30 +0200")
References: <20180523095830.24362-1-kwolf@redhat.com>
	<20180523095830.24362-3-kwolf@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 23 May 2018 12:25:02 +0200
Message-ID: <87sh6ibrep.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-iotests: Remove MIG_SOCKET from
 non-migration tests
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
> 185 and 191 define a MIG_SOCKET even though they don't do anything with
> migration. Remove the useless variable.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
