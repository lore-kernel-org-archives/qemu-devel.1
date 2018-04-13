Received: from eggs.gnu.org ([2001:4830:134:3::10]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f70D5-0004T5-9P
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f70D0-0004SG-I3
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:01:55 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <6e396823-f99c-2917-ccc5-04dda4a48f39@redhat.com>
References: <20180328133845.20632-1-berto@igalia.com>
	<6e396823-f99c-2917-ccc5-04dda4a48f39@redhat.com>
Date: Fri, 13 Apr 2018 17:01:47 +0200
Message-ID: <w5136zz5ew4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts/dump-qcow2.pl: Script to dump
 qcow2 metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 13 Apr 2018 04:45:15 PM CEST, Max Reitz wrote:

> OK, now that that's out of the way...  I'm wondering why you want to
> add this to the qemu tree?  If you'd written an iotest that would make
> use of it, sure.  But if it's just for debugging, then I'd personally
> think it would be better to just add it to a private repository.

Sure, that works for me, I just find it useful for debugging and I
decided to share it in case you think it fits in the scripts/ directory.

> That would give you more freedom to extend it, too.

Indeed.

Berto
