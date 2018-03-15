Received: from eggs.gnu.org ([2001:4830:134:3::10]:34048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewSMk-0003TE-2m
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewSMh-0003vT-2X
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:52:18 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180315035157.6929-1-famz@redhat.com>
References: <20180315035157.6929-1-famz@redhat.com>
Date: Thu, 15 Mar 2018 13:52:11 +0100
Message-ID: <w51r2ol4i2s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Fix leak of
 ignore_children in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 15 Mar 2018 04:51:57 AM CET, Fam Zheng wrote:
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
