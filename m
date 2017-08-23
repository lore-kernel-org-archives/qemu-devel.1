Received: from eggs.gnu.org ([2001:4830:134:3::10]:38600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dkV3p-0006Q2-F1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dkV3l-0005jg-Fu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:47:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809140256.25584-6-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-6-el13635@mail.ntua.gr>
Date: Wed, 23 Aug 2017 14:46:23 +0200
Message-ID: <w51ziaqh2ow.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/6] block: add iotest 191 for legacy
 throttling interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed 09 Aug 2017 04:02:55 PM CEST, Manos Pitsidianakis wrote:
> Check that the implicit throttle filter driver node, used for
> compatibility with the legacy throttling interface on the BlockBackend
> level, works.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
