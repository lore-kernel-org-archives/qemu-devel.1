Received: from eggs.gnu.org ([2001:4830:134:3::10]:33826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIZq4-0004od-Mj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIZq1-0006vA-GQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:13:28 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170607115958.GB8144@noname.redhat.com>
References: <cover.1495536228.git.berto@igalia.com>
	<20170607114406.GA24076@igalia.com>
	<20170607115958.GB8144@noname.redhat.com>
Date: Wed, 07 Jun 2017 14:13:21 +0200
Message-ID: <w51tw3sxafy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On Wed 07 Jun 2017 01:59:58 PM CEST, Kevin Wolf wrote:
> Am 07.06.2017 um 13:44 hat Alberto Garcia geschrieben:
>> ping
>
> You wanted to address two or three things in the next version, so I
> assumed that this version shouldn't be merged.

Right, I had a couple of minor changes, but the core of the series is
going to remain the same and can already be reviewed.

But of course I can just send the second version with my changes, I'll
do it then.

Berto
