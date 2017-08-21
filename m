Received: from eggs.gnu.org ([2001:4830:134:3::10]:53092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djlbO-0001B3-TN
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djlbJ-0007qq-Rz
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:14:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170819142947.e5xqkmfe6kssot3f@postretch>
References: <cover.1502979710.git.berto@igalia.com>
	<427228619067b0a029d2ae7706a3743a6da38128.1502979710.git.berto@igalia.com>
	<20170819142947.e5xqkmfe6kssot3f@postretch>
Date: Mon, 21 Aug 2017 14:14:36 +0200
Message-ID: <w51bmn9nmmr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] throttle: Fix wrong variable name in
 the header documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Sat 19 Aug 2017 04:29:47 PM CEST, Manos Pitsidianakis wrote:
> On Thu, Aug 17, 2017 at 05:28:12PM +0300, Alberto Garcia wrote:
>>The level of the burst bucket is stored in bkt.burst_level, not
>>bkt.burst_lenght.
>
> s/lenght/length, otherwise:

Oh my, fixing a typo by introducing another typo :-)

> Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Berto
