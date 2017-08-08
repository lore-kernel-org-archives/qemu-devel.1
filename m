Received: from eggs.gnu.org ([2001:4830:134:3::10]:49296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df1r8-00035P-7B
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df1r5-0007u2-K1
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:35:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w517eyel5xz.fsf@maestria.local.igalia.com>
References: <20170807161529.3779-1-berto@igalia.com>
	<20170808100030.GB16801@stefanha-x1.localdomain>
	<w517eyel5xz.fsf@maestria.local.igalia.com>
Date: Tue, 08 Aug 2017 12:35:15 +0200
Message-ID: <w514ltil53w.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg
 and LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue 08 Aug 2017 12:17:12 PM CEST, Alberto Garcia wrote:

> I was under the impression that Markus wanted to change the QAPI types
> of the throttling fields in BlockDeviceInfo for 2.10 as well, so this
> patch is relevant.

I just saw that his series is still an RFC, so we can leave this patch
for 2.11. Sorry again!

Berto
